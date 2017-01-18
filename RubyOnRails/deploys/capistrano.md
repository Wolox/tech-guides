This is a guide to deploy a RoR app with Capistrano.

## Gemfile

```ruby
group :development do
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-maintenance', github: 'capistrano/maintenance', require: false
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  gem 'capistrano-nginx-unicorn'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rails-console'
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'capistrano-postgresql', '~> 4.2.0'
  gem 'airbrussh', require: false
end
```

## Capfile

```ruby
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/rbenv_install'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/nginx_unicorn'
require 'capistrano/postgresql'
require 'capistrano/sidekiq'
require 'capistrano/rails/console'
require 'capistrano-db-tasks'
require 'capistrano/faster_assets'
require 'rollbar/capistrano3'
require 'whenever/capistrano'
require 'airbrussh/capistrano'

# Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
```

## config/deploy/production.rb

```ruby
set :stage, :production
set :rails_env, :production

role :app, %w(ubuntu@url.com)
role :web, %w(ubuntu@url.com)
role :db,  %w(ubuntu@url.com)

set :bundle_binstubs, -> { shared_path.join('bin') }

set :ssh_options, keys: %w(~/.ssh/rails-bootstrap-prod.pem), forward_agent: true

set :nginx_server_name, 'url'
```

## config/deploy.rb

```ruby
# Capistrano deploy configuration
# Config valid only for Capistrano 3.2.1
lock '3.5.0'

set :application, 'rails-bootstrap'
set :repo_url, 'git@github.com:Wolox/rails-bootstrap.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :scm, :git

set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"

set :log_level, :info

set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# False is required for sidekiq to work
set :pty, false

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_roles, :all

set :unicorn_user, 'ubuntu'
set :unicorn_error_log, "#{shared_path}/log/unicorn_error.log"
set :unicorn_workers, 4

set :bundle_jobs, 20

set :pg_ask_for_password, true

# If you want to remove the dump file from the server after downloading
set :db_remote_clean, true

# If you want to remove the local dump file after loading
set :db_local_clean, true

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
set :rollbar_env, proc { fetch :stage }
set :rollbar_role, proc { :app }

after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'sidekiq:restart'
```

#### Amazon AWS with Capistrano

If you want to deploy your app using [Amazon AWS](https://aws.amazon.com/) and [Capistrano](http://capistranorb.com/) you need to do the following:

Connect to the server and install the following libraries:

```bash
	sudo apt-get update
	sudo apt-get install git
	sudo apt-get install postgresql postgresql-contrib libpq-dev libreadline-dev
	sudo apt-get install nodejs build-essential
	sudo apt-get install nginx
	sudo apt-get install unicorn
	sudo apt-get install vim
```

And then run the following locally using:

```bash
	bundle exec cap production nginx:setup
	bundle exec cap production unicorn:setup_initializer
	bundle exec cap production unicorn:setup_app_config
	bundle exec cap production postgresql:generate_database_yml_archetype
	bundle exec cap production postgresql:generate_database_yml
```

Then add the user and database to the database in the server:

```bash
  sudo su - postgres
  CREATE ROLE "your-username" LOGIN CREATEDB PASSWORD 'your-password';
  CREATE DATABASE "your-database" owner "your-username";
```

Before you deploy you need to add the ssh keys and deploy keys for Github. Run the following in your server:

```bash
  ssh-keygen -t rsa -b 4096
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
```

And then add the `~/.ssh/id_rsa.pub` key to a Deploy Key in your Github Repository.

Then you are ready to deploy our app:

```bash
  bundle exec cap production deploy
```

The postgresql task will ask for your database password but it will use some default values for the url and the username. If you want to modify them you should modify the files in `db/database.yml`, and `shared/config/database.yml` in the server.

To install [Redis](http://redis.io/) run the script [here](http://redis.io/download#installation) and then run:

```bash
  sudo apt-get install tcl8.5
  make test & make install
  sh utils/install_server.sh
```

After setting some configuration details (you can leave the defaults), the `redis-server` should be running

*Don't forget to enable the ports you need in AWS. (e.g: ssh, http, https)*

Environment variables should be loaded in the `/etc/environment` file. You may need to restart the server or sidekiq after this.

###### Troubleshoot

##### Rbenv

If you have an error while executing `install_bundler` capistrano task then modify the `~/.bash_profile` as indicated [here](https://github.com/rbenv/rbenv#basic-github-checkout).

and run `rbenv global` with the version in [.ruby-version](.ruby-version)

##### Sidekiq

If Sidekiq start fails when you make the first deploy. You can comment the sidekiq lines in [deploy.rb](config/deploy.rb) and [Capfile](Capfile) during the first deploy.
