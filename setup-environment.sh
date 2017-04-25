#!/bin/bash

##################################################################################
# Script to setup the development environment that we use in Wolox for Ubuntu 16 #
#                                                                                #
# Usage:                                                                         #
#   $ chmod +x setup-environment.sh                                              #
#   $ ./setup-environment.sh (rails|node)                                        #
##################################################################################

install_zsh() {
  sudo apt-get install zsh
  chsh -s $(which zsh)
}

install_atom() {
  # Update atom from downloaded deb file
  rm -f /tmp/atom.deb
  curl -L https://atom.io/download/deb > /tmp/atom.deb
  dpkg --install /tmp/atom.deb

  echo "***** apm upgrade - to ensure we update all apm packages *****"
  apm upgrade --confirm false
}

# TODO: get ruby version from parameter
install_ruby() {
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
  cd
  rm -rf ~/.rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(rbenv init -)"' >> ~/.zshrc
  exec $SHELL

  rm -rf ~/.rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
  exec $SHELL

  rbenv install 2.3.3
  rbenv global 2.3.3
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc
  gem install bundler
}

# TODO: get rails version from parameter
install_rails() {
  gem install rails -v 5.0.0.1
}

install_postgres() {
  sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install postgresql-common
  sudo apt-get install postgresql-9.5 libpq-dev
}

install_zsh
install_atom

case "$1" in
  rails)
    install_ruby
    install_rails
    install_postgres
    ;;
  node)
    echo "Node"
    ;;
  *)
    echo $"Usage: $0 {rails|node}"
    exit 1
esac
