# Enviroment setup

## Introduction

This doc will show us how to setup the React Native enviroment and a few good tools that we will find very useful. Sadly we can't run iOS simulators on Ubuntu which makes macOS the best option to develop apps for both platforms.
Nevertheless we can set an enviroment on Ubuntu but it will only work for Android devices.

## Basic setup

Follow this guide [React Native Starter Guide](https://facebook.github.io/react-native/docs/getting-started) to install all the basic IDEs and dependencies.
We recommend Visual Studio Code as text editor and the following plugins: 
.ejs, Color Highlight, EJS language support, ESLint, Git Blame, Git lens, React Native Tools, Jest, Open iTerm2, Path Intellisense and Rainbow Brackets
Also we recommend to use Github SSH agent to manage our credentials, here is a guide to know how to install it [Github SSH agent](https://help.github.com/articles/connecting-to-github-with-ssh/)
If you want to use a physical device to test your app here is the [Oficial guide](https://facebook.github.io/react-native/docs/running-on-device). Have in mind that you will test it in different screen sizes so we recommend you to create at least 4 devices for each OS (Android and iOS) to ensure a good testing. You can install Vysor, which will allow you to see an Android device screen on your mac or pc.

## Some add-ons

Our default terminal is Bash, despite there are a few options available we choose to use [iTerm2](https://iterm2.com/) along with [Zshell(zsh)](https://ohmyz.sh/)
Once you have zsh and vsCode installed you can do cmd + shift + p => install 'code' command in PATH on vsCode to add vsCode to our PATH. With it, we'll be able to open files on vsCode by typing the `code` command.
Now we can do `code ~/.zshrc` to edit our zshell config file and add our Android PATH

```
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
```

For gif creation we use Giphy.
And last but not least, install Reactotron. Reactotron is a debugging tool with some interesting features, [here](https://github.com/infinitered/reactotron) is the official repo.