# Redis configuration on Elasticbeanstalk

## Configuration

In order to install Redis in your EB instance add a file named redis.config under your app's .ebextensions folder. This file should contain a configuration like this:

```
packages:
  yum:
    gcc-c++: []
    make: []
sources:
  /home/ec2-user: http://download.redis.io/releases/redis-2.8.4.tar.gz
commands:
  redis_build:
    command: make
    cwd: /home/ec2-user/redis-2.8.4
  redis_config_001:
    command: sed -i -e "s/daemonize no/daemonize yes/" redis.conf
    cwd: /home/ec2-user/redis-2.8.4
  redis_config_002:
    command: sed -i -e "s/# maxmemory <bytes>/maxmemory 500MB/" redis.conf
    cwd: /home/ec2-user/redis-2.8.4
  redis_config_003:
    command: sed -i -e "s/# maxmemory-policy volatile-lru/maxmemory-policy allkeys-lru/" redis.conf
    cwd: /home/ec2-user/redis-2.8.4
  redis_server:
    command: src/redis-server redis.conf
    cwd: /home/ec2-user/redis-2.8.4
```
