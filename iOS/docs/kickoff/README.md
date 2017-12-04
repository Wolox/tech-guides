iOS Kickoff guide
-----------------

This is a tutorial explaining how to kickoff an iOS project from scratch. Some steps can't be followed without being granted access to certain services: request them to an iOS' technical leader:

* [Pablo Giorgi](mailto:pablo.giorgi@wolox.com.ar)
* [Guido Marucci Blas](mailto:guidomb@wolox.com.ar)

## Before starting...

The following will be needed to start an iOS project kickoff process:

* Have access to project's GitHub repository.
* Make sure `wolox-ci` GitHub user has writing access to repository.
* Have AmazonS3 credentials to configure [CarthageCache](https://github.com/guidomb/carthage_cache).
* Verify access to project's iOS devs email `PROJECT_NAME-dev-ios@wolox.com.ar`.
* Verify access to project's Trello board.
* Verify access to project's Google Drive.
* Have XCode and XCode Command Line Tools installed.
* Have git and [Homebrew](https://brew.sh) installed.
* Have [rbenv](https://github.com/rbenv/rbenv) installed.

## Kickoff

Next steps will get your iOS project configured, for these, replace `Project Name` with your project name.

A little heads up: It's *extremely* important naming conventions, such as camel case notation and so on, are followed. I.e.: if `BaseProject.xcodeproj` should be renamed with our project name, then it should be `ProjectName.xcodeproj`. Always follow the naming pattern on the base project. Read this [Convention guide](../../../mobile/docs/naming/README.md) to figure out what the `Project Name` should be.

Also, this is meant to be sequentially, so don't skip or mix steps.

### Setup

#### Adding Base Project

First, clone the base project repository. The included project comes with a basic XCode configuration and includes the most useful/needed dependencies. To do this, run on your Terminal:

`$ git clone git@github.com:Wolox/ios-base-project.git`

We should then clone from GitHub the empty project repository for our `Project Name`, with ULR `https://github.com/Wolox/example-project-ios` and SSH URL `git@github.com:Wolox/project-name-ios.git`. On the same path/console, run:

`$ git clone git@github.com:Wolox/project-name-ios.git`

Clone the repository.

`$ rsync -av --progress ios-base-project/. project-name-ios --exclude .git`

Fast copy everything but the .git file from base project to your project.

`$ cd project-name-ios`

Change to your project directory.

`$ git checkout -b "project-setup" `

Create a new branch to properly set up the project.

`$ git add .`

Don't forget to add the changes.

`$ git commit -m "Initial commit"`

Watch the message! This will be your project's first commit ;)

#### Project Renaming

Open XCode project by running:

`$ open BaseProject.xcodeproj`

Change its name from `BaseProject` to your own `ProjectName`, following [this](https://help.apple.com/xcode/mac/8.0/#/dev3db3afe4f) tutorial.

After doing this you'll note that still the `ProjectName`'s `Scheme` hasn't been renamed. To do this, duplicate the actual scheme and rename it, only then delete the old scheme. While editing the scheme, tick the `shared` option so project can be run on CI environment.

![rename scheme](./resources/xcode-scheme-rename.gif)

Folders and groups should also be renamed. Run the following on your console to fasten the process:

`$ brew install rename ack`
`$ find . -name 'BaseProject*' -print0 | xargs -0 rename -S 'BaseProject' 'ProjectName'`
`$ ack --literal --files-with-matches 'BaseProject' | xargs sed -i '' 's/BaseProject/ProjectName/g'`

Verify every `BaseProject` appearance has been renamed, running:

`$ ack --literal 'BaseProject'`

If this hasn't print out anything, you are good to go!

#### Build Scripts Configuration

Renaming is over! Time to move on to configuring the [build scripts](https://github.com/guidomb/ios-scripts) file. To do this, edit the `script/.env` file, which should already contain these lines (among some others):

```
PROJECT_NAME=BaseProject
XCODE_PROJECT=BaseProject.xcodeproj
```

Replace the values for `PROJECT_NAME` and `XCODE_PROJECT` with the following ones:

```
PROJECT_NAME=ProjectName
XCODE_PROJECT=ProjectName.xcodeproj
```

Check the value for `REQUIRED_XCODE_VERSION` matches the installed version. You can check it with the command `xcodebuild -version`.

Replace the values for `REQUIRED_SWIFTLINT_VERSION` and `REQUIRED_CARTHAGE_VERSION` with the last release version for each of them.
You can check them in [SwiftLint releases](https://github.com/realm/SwiftLint/releases) and [Carthage releases](https://github.com/Carthage/Carthage/releases).

#### Include Fastlane

Move to the project's root folder and download the [Fastlane](https://docs.fastlane.tools) content from the [Fastlane repository](https://github.com/Wolox/fastlane-mobile) by doing:

`git clone --depth=1 https://github.com/Wolox/fastlane-mobile.git fastlane; rm -rf fastlane/.git`

This copies the `fastlane-mobile` repository into `fastlane` folder, and removes the `.git` directory.

#### Bootstrapping project

Run bootstrapping script, which will install every necessary dependency to build the project:
`$ ./script/bootstrap `

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

#### Wrapping up

Make sure the project can be built and run it on the simulator (⌘ + R). You should see the following screen:

![base project screenshot](./resources/base-project-screenshot.png)

Add these changes by running:
`$ git add .`

And commit them:
`$ git commit -m "Rename project"`

Then send it to the clouds!
`$ git push origin HEAD -u`


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
