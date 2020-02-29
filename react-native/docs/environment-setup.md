# Enviroment setup

## Introduction

This doc will show us how to setup the React Native enviroment and a few good tools that we will find very usefull. Sadly we can't run iOS simulators from Ubuntu and it makes macOS the best option to develop apps for both platforms.
Nevertheless we can set an enviroment on Ubuntu but it will only work for Android devices.

## Basic setup

Folow this guide [React Native Starter Guide](https://facebook.github.io/react-native/docs/getting-started) to install all the basic IDEs and dependencies.
We recommend Visual Studio Code as text editor and the following plugins: 
.ejs, Color Highlight, EJS language support, ESLint, Git Blame, Git lens, React Native Tools, Jest, Open iTerm2, Path Intellisense and Rainbow Brackets
Also we recomende to use Github SSH agent to manage our credentials, here is a guide to know how to install it [Github SSH agent](https://help.github.com/articles/connecting-to-github-with-ssh/)
If you want to use a physical device to test your app here it the [Oficial guide](https://facebook.github.io/react-native/docs/running-on-device). Have in mind that you will test in different screen sizes so we recommend you to create at least 4 devices for each OS (Android and iOS) to ensure a good testing. You can installa Vysor, it will allow you to see an Android device screen on your mac or pc.

## Some add-ons

Our default terminal is bash an while is ok there are a few options out there and we choose to use [iTerm2](https://iterm2.com/) along with [Zshell(zsh)](https://ohmyz.sh/)
Once you have zsh and vsCode installed you can do cmd + shift + p => install 'code' command in PATH on vsCode to add vsCode to our PATH. With we'll be able to open files on vsCode with the `code` command.
We are going to run `code ~/.zshrc` from our terminal and add the content of [this doc](https://docs.google.com/document/d/1gMjx25qyjxduW9J87hr18Ub56P1ajmNy6KT_X9Z18fI/edit) at the bottom and save it. This will add several aliases to our terminal to make our work easier.
For gif creation we use Giphy.
And last but not least, install Reactotron. Reactotron is a tool for debugging tool with some interesting features, we leave you a configuration file for it [here](https://docs.google.com/document/d/1i_Dq2sW6CjePw40i_84Y1TVXle7he2q6CnUekkVDAZI/edit).
