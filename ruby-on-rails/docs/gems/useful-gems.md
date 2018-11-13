# Recommended Ruby/Rails gems by Wolox

## Index

  1. [Abstractions](#abstractions)
  1. [API](#api)
  1. [Apps](#apps)
  1. [Authentication](#authentication)
  1. [Authorization](#authorization)
  1. [Benchmarking](#benchmarking)
  1. [Code analysis](#code-analysis)
  1. [Concurrency](#concurrency)
  1. [Configuration](#configuration)
  1. [Database](#database)
  1. [Debugging](#debugging)
  1. [File uploads](#file-uploads)
  1. [Geolocation](#geolocation)
  1. [HTTP Clients](#http-clients)
  1. [Localization](#localization)
  1. [Mail](#mail)
  1. [Model Validations](#model-validations)
  1. [Pagination](#pagination)
  1. [Parsers](#parsers)
  1. [Push Notifications](#push-notifications)
  1. [SEO](#seo)
  1. [Testing](#testing)
  1. [Workers](#workers)

## Abstractions

|Name|Description|Stars|
|-----|-----|-----|
|[dry](https://github.com/dry-rb)|Set of gems designed to solve different problems including initialization, types, etc||
|[interactor](https://github.com/collectiveidea/interactor)|Create use case service objects, [read more](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)|[![GitHub stars](https://img.shields.io/github/stars/collectiveidea/interactor.svg?style=social&label=Star)](https://github.com/collectiveidea/interactor)|
|[virtus](https://github.com/solnic/virtus)|Add attribute type checking to your POJOs|[![GitHub stars](https://img.shields.io/github/stars/solnic/virtus.svg?style=social&label=Star)](https://github.com/solnic/virtus)|

## API

|Name|Description|Stars|
|-----|-----|-----|
|[active_model_serializers](https://github.com/rails-api/active_model_serializers)|JSON serialization of your activerecord models|[![GitHub stars](https://img.shields.io/github/stars/rails-api/active_model_serializers.svg?style=social&label=Star)](https://github.com/rails-api/active_model_serializers)|
|[versionist](https://github.com/bploetz/versionist)|Version Rails based RESTful APIs.|[![GitHub stars](https://img.shields.io/github/stars/bploetz/versionist.svg?style=social&label=Star)](https://github.com/bploetz/versionist)|

## Apps

|Name|Description|Stars|
|-----|-----|-----|
|[candy-check](https://github.com/jnbt/candy_check)|Check and verify in-app receipts. [read more](https://medium.com/wolox-driving-innovation/7b208f9cfa3e)|[![GitHub stars](https://img.shields.io/github/stars/jnbt/candy_check.svg?style=social&label=Star)](https://github.com/jnbt/candy_check)|

## Authentication

|Name|Description|Stars|
|-----|-----|-----|
|[devise](https://github.com/plataformatec/devise)|Authentication library|[![GitHub stars](https://img.shields.io/github/stars/plataformatec/devise.svg?style=social&label=Star)](https://github.com/plataformatec/devise)|
|[devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth)|Token based authentication for Rails JSON APIs|[![GitHub stars](https://img.shields.io/github/stars/lynndylanhurley/devise_token_auth.svg?style=social&label=Star)](https://github.com/lynndylanhurley/devise_token_auth)|
|[JWT](https://github.com/jwt/ruby-jwt)|JSON Web Token implementation for ruby|[![GitHub stars](https://img.shields.io/github/stars/jwt/ruby-jwt.svg?style=social&label=Star)](https://github.com/jwt/ruby-jwt)|

## Authorization

|Name|Description|Stars|
|-----|-----|-----|
|[CanCanCan](https://github.com/CanCanCommunity/cancancan)|Policies library|[![GitHub stars](https://img.shields.io/github/stars/CanCanCommunity/cancancan.svg?style=social&label=Star)](https://github.com/CanCanCommunity/cancancan)|
|[Pundit](https://github.com/elabs/pundit)|Policies library|[![GitHub stars](https://img.shields.io/github/stars/elabs/pundit.svg?style=social&label=Star)](https://github.com/elabs/pundit)|

## Benchmarking

|Name|Description|Stars|
|-----|-----|-----|
|[benchmark-ips](https://github.com/evanphx/benchmark-ips)|Benchmark library that uses CPU instructions per second instead of time|[![GitHub stars](https://img.shields.io/github/stars/evanphx/benchmark-ips.svg?style=social&label=Star)](https://github.com/evanphx/benchmark-ips)|

## Code analysis

|Name|Description|Stars|
|-----|-----|-----|
|[brakeman](https://github.com/presidentbeef/brakeman)|Looks for security vulnerabilities in your Rails app|[![GitHub stars](https://img.shields.io/github/stars/presidentbeef/brakeman.svg?style=social&label=Star)](https://github.com/presidentbeef/brakeman)|
|[reek](https://github.com/troessner/reek)|Looks for code smells|[![GitHub stars](https://img.shields.io/github/stars/troessner/reek.svg?style=social&label=Star)](https://github.com/troessner/reek)|
|[rubocop](https://github.com/bbatsov/rubocop)|Coding style linter|[![GitHub stars](https://img.shields.io/github/stars/bbatsov/rubocop.svg?style=social&label=Star)](https://github.com/bbatsov/rubocop)|
|[simplecov](https://github.com/colszowka/simplecov)|Code coverage tool|[![GitHub stars](https://img.shields.io/github/stars/colszowka/simplecov.svg?style=social&label=Star)](https://github.com/colszowka/simplecov)|

## Concurrency

|Name|Description|Stars|
|-----|-----|-----|
|[concurrent-ruby](https://github.com/ruby-concurrency/concurrent-ruby)|Set of concurrent tools and objects for ruby|[![GitHub stars](https://img.shields.io/github/stars/ruby-concurrency/concurrent-ruby.svg?style=social&label=Star)](https://github.com/ruby-concurrency/concurrent-ruby)|

## Configuration

|Name|Description|Stars|
|-----|-----|-----|
|[dotenv](https://github.com/bkeepers/dotenv)|Load environment variables for your app automatically without using secrets.yml|[![GitHub stars](https://img.shields.io/github/stars/bkeepers/dotenv.svg?style=social&label=Star)](https://github.com/bkeepers/dotenv)|


## Database

|Name|Description|Stars|
|-----|-----|-----|
|[bullet](https://github.com/flyerhzm/bullet)|Find N+1 queries in your Rails application|[![GitHub stars](https://img.shields.io/github/stars/flyerhzm/bullet.svg?style=social&label=Star)](https://github.com/flyerhzm/bullet)|
|[paranoia](https://github.com/rubysherpas/paranoia)|Easily add logic delete to your activerecord models|[![GitHub stars](https://img.shields.io/github/stars/rubysherpas/paranoia.svg?style=social&label=Star)](https://github.com/rubysherpas/paranoia)|
|[pg_search](https://github.com/Casecommons/pg_search)|Powerful table search for PostgreSQL|[![GitHub stars](https://img.shields.io/github/stars/Casecommons/pg_search.svg?style=social&label=Star)](https://github.com/Casecommons/pg_search)|
|[redis](https://github.com/redis/redis-rb)|Redis driver|[![GitHub stars](https://img.shields.io/github/stars/redis/redis-rb.svg?style=social&label=Star)](https://github.com/redis/redis-rb)|

## Debugging

|Name|Description|Stars|
|-----|-----|-----|
|[byebug](https://github.com/deivid-rodriguez/byebug)|Simple to use, feature rich debugger for Ruby|[![GitHub stars](https://img.shields.io/github/stars/deivid-rodriguez/byebug.svg?style=social&label=Star)](https://github.com/deivid-rodriguez/byebug)|
|[rails_panel](https://github.com/dejan/rails_panel)|RailsPanel is a Chrome extension for Rails development that will end your tailing of development.log|[![GitHub stars](https://img.shields.io/github/stars/dejan/rails_panel.svg?style=social&label=Star)](https://github.com/dejan/rails_panel)|

## File uploads

|Name|Description|Stars|
|-----|-----|-----|
|[carrierwave](https://github.com/carrierwaveuploader/carrierwave)|File upload library|[![GitHub stars](https://img.shields.io/github/stars/carrierwaveuploader/carrierwave.svg?style=social&label=Star)](https://github.com/carrierwaveuploader/carrierwave)|
|[aws-sdk-s3](https://github.com/aws/aws-sdk-ruby)|The official AWS SDK for Ruby.|[![GitHub stars](https://img.shields.io/github/stars/aws/aws-sdk-ruby.svg?style=social&label=Star)](https://github.com/aws/aws-sdk-ruby)|

## Geolocation

|Name|Description|Stars|
|-----|-----|-----|
|[geokit-rails](https://github.com/geokit/geokit-rails)|Geolocation library|[![GitHub stars](https://img.shields.io/github/stars/geokit/geokit-rails.svg?style=social&label=Star)](https://github.com/geokit/geokit-rails)|

## HTTP Clients

|Name|Description|Stars|
|-----|-----|-----|
|[httparty](https://github.com/jnunemaker/httparty)|Make HTTP requests in your app easily|[![GitHub stars](https://img.shields.io/github/stars/jnunemaker/httparty.svg?style=social&label=Star)](https://github.com/jnunemaker/httparty)|

## Localization

|Name|Description|Stars|
|-----|-----|-----|
|[globalize](https://github.com/globalize/globalize)|Translate your models in several languages easily|[![GitHub stars](https://img.shields.io/github/stars/globalize/globalize.svg?style=social&label=Star)](https://github.com/globalize/globalize)|

## Mail

|Name|Description|Stars|
|-----|-----|-----|
|[premail-rails](https://github.com/fphilipe/premailer-rails)|Permit to compile the CSS in the HTML for mails|[![GitHub stars](https://img.shields.io/github/stars/fphilipe/premailer-rails.svg?style=social&label=Star)](https://github.com/fphilipe/premailer-rails)|

## Model Validations

|Name|Description|Stars|
|-----|-----|-----|
|[money-rails](https://github.com/RubyMoney/money-rails)|Handle money values and currency conversion|[![GitHub stars](https://img.shields.io/github/stars/RubyMoney/money-rails.svg?style=social&label=Star)](https://github.com/RubyMoney/money-rails)|

## Pagination

|Name|Description|Stars|
|-----|-----|-----|
|[kaminari](https://github.com/kaminari/kaminari)|Paginate your query results|[![GitHub stars](https://img.shields.io/github/stars/kaminari/kaminari.svg?style=social&label=Star)](https://github.com/kaminari/kaminari)|
|[will_paginate](https://github.com/mislav/will_paginate)|Paginate your query results|[![GitHub stars](https://img.shields.io/github/stars/mislav/will_paginate.svg?style=social&label=Star)](https://github.com/mislav/will_paginate)|
|[wor-paginate](https://github.com/Wolox/wor-paginate)|Paginate your query results (made at Wolox)|[![GitHub stars](https://img.shields.io/github/stars/Wolox/wor-paginate.svg?style=social&label=Star)](https://github.com/Wolox/wor-paginate)|

## Parsers

|Name|Description|Stars|
|-----|-----|-----|
|[nokogiri](https://github.com/sparklemotion/nokogiri)|Parse HTML (and more) documents in a very easy way|[![GitHub stars](https://img.shields.io/github/stars/sparklemotion/nokogiri.svg?style=social&label=Star)](https://github.com/sparklemotion/nokogiri)|

## Push Notifications

|Name|Description|Stars|
|-----|-----|-----|
|[wor-push-notifications-aws](https://github.com/Wolox/wor-push-notifications-aws)|Send Push Notifications to your application using AWS Simple Notification Service (SNS)|[![GitHub stars](https://img.shields.io/github/stars/Wolox/wor-push-notifications-aws.svg?style=social&label=Star)](https://github.com/Wolox/wor-push-notifications-aws)|

## SEO

|Name|Description|Stars|
|-----|-----|-----|
|[friendly_id](https://github.com/norman/friendly_id)|Create pretty URL’s and work with human-friendly strings as if they were numeric ids for ActiveRecord models. |[![GitHub stars](https://img.shields.io/github/stars/norman/friendly_id.svg?style=social&label=Star)](https://github.com/norman/friendly_id)|

## Testing

|Name|Description|Stars|
|-----|-----|-----|
|[parallel_tests](https://github.com/grosser/parallel_tests)|Speedup tests by running parallel on multiple CPU cores. |[![GitHub stars](https://img.shields.io/github/stars/grosser/parallel_tests.svg?style=social&label=Star)](https://github.com/grosser/parallel_tests)|

## Workers

|Name|Description|Stars|
|-----|-----|-----|
|[sidekiq](https://github.com/mperham/sidekiq)|Easily create workers for your asynchronous jobs|[![GitHub stars](https://img.shields.io/github/stars/mperham/sidekiq.svg?style=social&label=Star)](https://github.com/mperham/sidekiq)|
|[sidekiq-scheduler](https://github.com/moove-it/sidekiq-scheduler)|Lightweight job scheduler extension for Sidekiq|[![GitHub stars](https://img.shields.io/github/stars/moove-it/sidekiq-scheduler.svg?style=social&label=Star)](https://github.com/moove-it/sidekiq-scheduler)|
|[sidetiq](https://github.com/endofunky/sidetiq)|Add schedule to your sidekiq jobs|[![GitHub stars](https://img.shields.io/github/stars/endofunky/sidetiq.svg?style=social&label=Star)](https://github.com/endofunky/sidetiq)|


# Not recommended gems

In this section we are going to mention some gems that we tried out but we had problems with. This doesn't mean that the gems are bad (maybe some), but that maybe they lack some important function or they had an error that needed a workaround. The idea is that if you MUST use these gems we can share solutions to problems you might have, so please make a PR if you can contribute. It is also important to mention that the problems listed might have been fixed by the community so you can create a PR to remove them.

|Name|Description|Problems|Possible solutions|
|-----|-----|-----|-----|
|[refile](https://github.com/refile/refile)|File uploading|It didn't have an option to update files (specially painful for user images)|Remove old file and create a new one every time a user wants to update a file|

## Mantainers

  * Ignacio Coluccio
  * Leandro Motta
  * Juan Ignacio Sierra
