# How to create a new Gem

## With Bundler

The easiest and most practical way to create a new gem, is to just use the following command:

```sh
bundler gem 'gem-name'
```
Where, 'gem-name' should be your gem's name.

If you already have a repository, if you clone it first, you can easily do:

```sh
cd my-gem && bundler gem .
```

As a suggestion and configurations, you should configure your bundler gem creator with the following options selected:

- Use [RSpec](https://rspec.info/) for tests.
- Use a clear, open source License. It could be MIT, or Apache-2.0.
- Add a [CODE OF CONDUCT](https://bundler.io/conduct.html), it helps to indicate how issues and pull request should be made, and also helps in cooperation across developers. (The one provided by bundler is nice, but you can, as always, improve over it.)

This easy bootstrap will help you in order to ensure your gem comes with testing, TravisCI integration and some easy tasks.

## What tasks do I have by default?

Use `rake --tasks` and check them out, most of them are convenient alternatives to doing it manually.

You can always add more to the Rakefile, if you require them.
