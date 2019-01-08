iOS Kickoff guide
-----------------

This is a tutorial explaining how to kickoff an iOS project from scratch (some steps can't be followed without being granted access to certain services).

## Before starting...

The following will be needed to start an iOS project kickoff process:

* Have access to project's GitHub repository.
* Make sure `wolox-ci` GitHub user has writing access to repository.
* Have AmazonS3 credentials to configure [CarthageCache](https://github.com/guidomb/carthage_cache).
* Verify access to project's iOS devs email `PROJECT_NAME-dev-ios@wolox.com.ar`.
* Verify access to project's Trello or Jira board.
* Verify access to project's Google Drive.
* Have XCode and XCode Command Line Tools installed.
* Have git and [Homebrew](https://brew.sh) installed.
* Have [rbenv](https://github.com/rbenv/rbenv) installed.

## Kickoff

The following steps will get your iOS project configured. Replace `Project Name` with your project name.

A little heads up: It's *extremely* important naming conventions, such as camel case notation and so on, are followed. I.e.: if `BaseProject.xcodeproj` should be renamed with our project name, then it should be `ProjectName.xcodeproj`. Always follow the naming pattern on the base project. Read this [Convention guide](../../../mobile/docs/naming/README.md) to figure out what the `Project Name` should be. There can't be symbols like `-` in the new project's name or the renaming won't work.

Follow this guide sequentially, don't skip or mix steps.

### Setup

#### Adding Base Project

First, clone the [Base Project](https://github.com/Wolox/ios-base-project) repository. The included project comes with a basic XCode configuration and includes the most useful/needed dependencies.

Also clone from GitHub the empty project repository for our new project.

Now we should fast copy everything but the .git file from base project to our project. Remember to change `project-name-ios` with our project folder name.

`$ rsync -av --progress ios-base-project/. project-name-ios --exclude .git`

Now create a branch for setup (call it something like `project-initial-setup`) and commit and push the changes.

#### Project Renaming

Open your XCode project and change its name from `BaseProject` to your own `ProjectName` following [this](https://help.apple.com/xcode/mac/8.0/#/dev3db3afe4f) tutorial.

After doing this you'll note that the `ProjectName`'s `Scheme` hasn't been renamed. To do this, duplicate the actual scheme and rename it and only then delete the old scheme. While editing the scheme, tick the `shared` option so the project can be run on a CI environment. Here's a gif of the process:

![rename scheme](./resources/xcode-scheme-rename.gif)

Folders and groups should also be renamed. To do this you can use the `rename` script that is in the root of the project by running: `./rename` and following the steps.

#### Build Scripts Configuration

Time to move on to install the build scripts that will bootstrap our project. To do this clone or download [this repository.](https://github.com/guidomb/ios-scripts)

Before doing anything check in a terminal the value for `xcodebuild -version` and the latest versions of SwiftLint and Carthage.

You can check them in [SwiftLint releases](https://github.com/realm/SwiftLint/releases) and [Carthage releases](https://github.com/Carthage/Carthage/releases).

Now run ` ./install <your project directory>` and follow the steps. Select the options you need for your project. If you are not sure you can use the default values the script provides (by pressing `return` when asked for a value) in almost all cases except for:

The name of your project.

When asked to create a `.env` file select `y`.

When the script asks for xCode, Swiftlint and Carthage versions use the values you searched for above.

When asked if you want to bootstrap the project select `y`.

#### Bootstrapping project

Bootstraping the project will install every necessary dependency to build the project.

This will configure [CarthageCache](https://github.com/guidomb/carthage_cache) locally and generate a `.carthage_cache.yml` file. Have your AWS credentials handy: you'll need the `access key ID` and `secret access key` from the account with access to the `carthage-cache` bucket. Configure `us-west-2` as region. When done, you should see this message on the console:

```
ProjectName successfully bootstrapped

Useful scripts:

 * 'script/test' to run tests.
 * 'script/build' to build the project.
 * 'script/update' to update project's dependencies.

You can start hacking by executing:

   open ProjectName.xcodeproj

```

#### Include Fastlane

Move to the project's root folder and download the [Fastlane](https://docs.fastlane.tools) content from the [Fastlane repository](https://github.com/Wolox/fastlane-mobile) by doing:

`git clone --depth=1 https://github.com/Wolox/fastlane-mobile.git fastlane; rm -rf fastlane/.git`

This copies the `fastlane-mobile` repository into `fastlane` folder, and removes the `.git` directory.

#### Wrapping up

Make sure the project can be built and run it on the simulator (⌘ + R). You should see the following screen:

![base project screenshot](./resources/base-project-screenshot.png)

If everything works, commit and push your changes.

### Configure CI

To configure continuous integration follow the guide [CI configuration for iOS projects](./configure-ci/README.md)

### Configure Crash logger

The project integrates [Rollbar](https://github.com/rollbar/rollbar-ios) as default crash logger.

In order to enable it, ask a technical leader to create a new group and a new iOS project in Rollbar.

Once created, sign in to [Rollbar](https://rollbar.com), and go to your project's "Settings" -> "Access Tokens".

Then copy into all the `.xcconfig` files the following content replacing with the tokens:

```
ROLLBAR_CLIENT_ACCESS_TOKEN = <token under "post_client_item">
ROLLBAR_SERVER_ACCESS_TOKEN = <token under "post_server_item">
```

Once the `.xcconfig` files are configured (make sure they are ignored, if they are shown as changes to be committed, then do `git update-index --assume-unchanged ./BaseProject/ConfigurationFiles/*` to ignore these changes) just uncomment the call to `RollbarService().initialize()` in `AppDelegate.swift`.

### Configure GitHub

#### Protect Master

* [Configuring protected branches](https://help.github.com/articles/configuring-protected-branches/)
* [Enabling required status checks](https://help.github.com/articles/enabling-required-status-checks/)

#### Disable "Squash & Merge"

* [Configuring pull request merge squashing](https://help.github.com/articles/configuring-pull-request-merge-squashing/)
