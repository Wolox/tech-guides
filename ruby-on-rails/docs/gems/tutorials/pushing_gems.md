# How to push Gems

*Abstract: In this document we will learn how to build and push new gems or new versions of already developed gems to [RubyGems](https://rubygems.org/gems) and add Wolox as the co-owner.*

## Steps

1. First, we have to register ourselves in [RubyGems](https://rubygems.org/gems) because we'll be using those credentials to push the gem.

2. Then we'll locate ourselves in the folder where our gem is being currently developed and run the following command:

```bash
gem build GEM_NAME.gemspec
```

This will generate a file called GEM_NAME-GEM_VERSION.gem we will use in the next step.

3. Now we are gonna be pushing the new gem that we've built in the step before to [RubyGems](https://rubygems.org/gems), for that we are gonna run the following command:

```bash
gem push GEM_NAME-GEM_VERSION.gem
```

4. Lastly, we are going to add Wolox as a co-owner to the gem we developed:

```bash
gem owner GEM_NAME -a opensource@wolox.com.ar
```

Now you are all done, your gem should be ready to be downloaded in no time after being evaluated by the [RubyGems](https://rubygems.org/gems) team!
