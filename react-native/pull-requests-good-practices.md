# React Native good practices for pull requests

## This document

At [Wolox](http://wolox.com.ar), we have a document dedicated to [Good Practices for Github Pull Requests](https://github.com/Wolox/tech-guides/blob/master/git/docs/pull-requests-good-practices.md). That document contains cross-tech tips on how to create good pull requests. This document is intended to add React Native specific information on both how to create and review pull requests.

## Good practices

* When creating a pull request, always add screenshots or gifs for both Android and iOS. It should feature a "big" phone (e.g. iPhone X, Nexus 5X) and a "small" phone (e.g. iPhone SE, Nexus S) for each system. If you need to make changes to the code that affect visual components, you must update all the screenshots.
* If you're not sure if the pull request you are reviewing works as expected, checkout the branch and run the code yourself. Preventing future errors is always worth the hassle!
* Always check for `<View>`s with only one child when reviewing pull requests. Ask the developer to delete the `<View>` and  style the child component directly.

## Common problems

* If you get `project.pbxproj` conflicts when merging a PR, we usually recommend accepting both changes. After that, run `pod install` so any wrong stuff is fixed.
