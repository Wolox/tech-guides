# Possible issues

## Introduction

In this section we will talk about some issues you might have deploying your app and how to solve those problems.

## Deploys failing because of the Elasticbeanstalk default timeout

This problem usually happens with large or legacy applications. AWS has a global timeout for the deploy (after which the deploy fails), and sometimes this big apps need to run tasks that take too long. To solve this issue you can extend the timeout doing something like:

```
# .ebextensions/0001_increase_timeout.config

option_settings:
    - namespace: aws:elasticbeanstalk:command
      option_name: Timeout
      value: 2000
```

The timeout value is measured in seconds.

## Elasticsearch is not using the elasticsearch_url

If you are using a gem like Searchkick and for some reason it does not load automatically the ENV['ELASTICSEARCH_URL'], you could try the following:

```
# config/initializers/elasticsearch.rb

Searchkick.client = Elasticsearch::Client.new(
  hosts: [
    Rails.application.secrets.elasticsearch_url
  ],
  retry_on_failure: true,
  transport_options: {
    request: {
      timeout: 250
    }
  }
 ```
