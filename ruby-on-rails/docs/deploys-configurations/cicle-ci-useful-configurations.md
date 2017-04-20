# Circle CI - Useful configurations
## Index
- Redis configuration
- Integration with Dictum

## Redis configuration
In order to run Redis in Circle, you need to add this configuration to the circle.yml file.
Note that in this example, we are using Redis 3.2.5.
```
machine:
  services:
    - redis
dependencies:
  pre:
    - sudo service redis-server stop
    - >
      cd ~ && if [ ! -d "redis-3.2.5" ]; then
        wget http://download.redis.io/releases/redis-3.2.5.tar.gz
        tar xzf redis-3.2.5.tar.gz
        cd redis-3.2.5 && make;
      fi
    - cd ~/redis-3.2.5 && sudo make install
    - sudo sed -i 's/bin/local\/bin/g' /etc/init/redis-server.conf
    - sudo service redis-server start
  cache_directories:
    - ~/redis-3.2.5
```    
Source: https://discuss.circleci.com/t/how-to-run-redis-3-2/5815/5

## Integration with Dictum
In the following example, we are generating the project documentation when we are deploying the project. Indeed, we generate all the views from dictum and then upload them to the S3 bucket for our project.

Note that in order to upload those files to S3 bucket, you need to configure your aws credentials: https://circleci.com/docs/continuous-deployment-with-amazon-s3/
```
deployment:
  staging:
    branch: development
    commands:
      - bundle exec rspec
      - bundle exec rails runner -e test Dictum.save_to_file
      - aws s3 sync app/views/docs s3://[path-to-your-s3-bucket] --delete
```      
The deployment section runs commands to deploy to staging or production. These commands are triggered only after a successful (green) build.
You can specify several subsections (such as ‘staging’, ‘production’, etc) and whenever a developer pushes to the branch specified (e.g. development), the commands are executed.

At the moment of writing, Dictum has some problems with rspec when the command ‘bundle exec rake dictum:document’ is executed. Due to this, we are manually running the rspec script and then asking Dictum to save the documentation.

As regards the command to upload to s3 bucket, the option --delete (boolean) deletes files that exist in the destination but not in the source during the sync. You can see http://docs.aws.amazon.com/cli/latest/reference/s3/sync.html for further information.
