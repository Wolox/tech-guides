# Text editors

## Atom

[Atom](https://atom.io/) is a highly customizable text editor. It's open source, developed by GitHub and has tons of Packages to extend its functionality.

### Installation
To install it just open a terminal run the following commands
```
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
```

### Packages

To install packages you can use the built-in package manager or you can install them using the terminal.

|Name|Description|Stars|Build|
|----|-----------|-----|-----|
|[Atom Beautify](https://github.com/Glavin001/atom-beautify)|It sets identation configuration for many languages following its comunity standards. |[![GitHub stars](https://img.shields.io/github/stars/Glavin001/atom-beautify.svg?style=social&label=Star)](https://github.com/Glavin001/atom-beautify)|[![Build Status](https://travis-ci.org/Glavin001/atom-beautify.png?branch=master)](https://travis-ci.org/Glavin001/atom-beautify)
|[Linter](https://github.com/steelbrain/linter)| It shows errors in real time. `Linter` provides an Api so the other linters can display the error messages. You have to install a diferent linter for each language.| [![GitHub stars](https://img.shields.io/github/stars/steelbrain/linter.svg?style=social&label=Star)](https://github.com/steelbrain/linter)|[![Build Status](https://circleci.com/gh/steelbrain/linter.png?branch=master)](https://circleci.com/gh/steelbrain/linter)
|[Minimap](https://github.com/atom-minimap/minimap)|A preview of the full source code.| [![GitHub stars](https://img.shields.io/github/stars/atom-minimap/minimap.svg?style=social&label=Star)](https://github.com/atom-minimap/minimap)|[![Build Status](https://travis-ci.org/atom-minimap/minimap.svg?branch=master)](https://travis-ci.org/atom-minimap/minimap)
|[Color Picker](https://github.com/abe33/atom-pigments)|A color management for Atom.  it intends to enable developers to quickly adjust the color values in their CSS files| [![GitHub stars](https://img.shields.io/github/stars/thomaslindstrom/color-picker.svg?style=social&label=Star)](https://github.com/thomaslindstrom/color-picker)|[![Build Status](https://travis-ci.org/thomaslindstrom/color-picker.svg?branch=master)](https://travis-ci.org/thomaslindstrom/color-picker)
|[Pigments](https://github.com/abe33/atom-pigments)| A package to display colors in project and files| [![GitHub stars](https://img.shields.io/github/stars/abe33/atom-pigments.svg?style=social&label=Star)](https://github.com/abe33/atom-pigments)|[![Build Status](https://travis-ci.org/abe33/atom-pigments.svg?branch=master)](https://travis-ci.org/abe33/atom-pigments)
|[Node Requirer](https://github.com/tnrich/atom-node-requirer)| Lets you quickly add require/import statements to any files/node_modules within your code| [![GitHub stars](https://img.shields.io/github/stars/tnrich/atom-node-requirer.svg?style=social&label=Star)](https://github.com/tnrich/atom-node-requirer)|[![Build Status](https://travis-ci.org/tnrich/atom-node-requirer.svg?branch=master)](https://travis-ci.org/tnrich/atom-node-requirer)
|[JS Hyperclick](https://github.com/AsaAyers/js-hyperclick)| It lets you jump to where variables are defined. (JS only)| [![GitHub stars](https://img.shields.io/github/stars/AsaAyers/js-hyperclick.svg?style=social&label=Star)](https://github.com/AsaAyers/js-hyperclick)|[![Build Status](https://travis-ci.org/AsaAyers/js-hyperclick.svg?branch=master)](https://travis-ci.org/AsaAyers/js-hyperclick)
|[React](https://github.com/orktes/atom-react)| React.js (JSX) language support, indentation, snippets, auto completion, reformatting| [![GitHub stars](https://img.shields.io/github/stars/orktes/atom-react.svg?style=social&label=Star)](https://github.com/orktes/atom-react)|[![Build Status](https://travis-ci.org/orktes/atom-react.svg?branch=master)](https://travis-ci.org/orktes/atom-react)
|[Highlight Selected](https://github.com/richrace/highlight-selected)| Double click on a word to highlight it throughout the open file| [![GitHub stars](https://img.shields.io/github/stars/richrace/highlight-selected.svg?style=social&label=Star)](https://github.com/richrace/highlight-selected)|[![Build Status](https://travis-ci.org/richrace/highlight-selected.svg?branch=master)](https://travis-ci.org/richrace/highlight-selected)
|[Tab Folder Name Index](https://github.com/Connormiha/atom-tab-foldername-index) | It replaces tab’s title if opened multiple files with the same name for more readability | [![GitHub stars](https://img.shields.io/github/stars/Connormiha/atom-tab-foldername-index.svg?style=social&label=Star)](https://github.com/Connormiha/atom-tab-foldername-index)|[![Build Status](https://travis-ci.org/Connormiha/atom-tab-foldername-index.svg?branch=master)](https://travis-ci.org/Connormiha/atom-tab-foldername-index)

# VSCode

[Visual Studio Code](https://code.visualstudio.com) is a source code editor developed by Microsoft for Windows, Linux and macOS. It includes support for debugging, embedded Git control, syntax highlighting, intelligent code completion, snippets, and code refactoring.

## Installing the 'code' command

To import vscode extensions we need to add the 'code' command to the terminal:

- Open VSCode
- Press 'CMD + SHIFT + P' or 'CTRL + SHIFT + P'
- Type: code
- It should show 'Shell Command: Install 'code' command in PATH'
- Now you can use code on the terminal

## Import extensions

To import VSCode extensions it is only necessary to use the folowwing command -> code --install + 'extension name'

## React Extensions

- REACT VSCODE EXTENSION PACK `code --install-extension jawandarajbir.react-vscode-extension-pack`

- DOTENV `code --install-extension mikestead.dotenv`

- JS/JSX SNIPPETS `code --install-extension skyran.js-jsx-snippets`

- BABEL `code --install-extension mgmcdermott.vscode-language-babel`

- AUTO-CLOSE TAGS `code --install-extension formulahendry.auto-close-tag`

- AUTO-COMPLETE TAGS `code --install-extension formulahendry.auto-complete-tag`

- COLOR HIGHLIGHT `code --install-extension naumovs.color-highlight`

- NPM INTELLISENSE `code --install-extension christian-kohler.npm-intellisense`

- PATH INTELLISENSE `code --install-extension christian-kohler.path-intellisense`

- PRETTIER VSCODE `code --install-extension esbenp.prettier-vscode`

- SASS LINT `code --install-extension glen-84.sass-lint`

- VSCODE REDUX DEVTOOLS `code --install-extension jingkaizhao.vscode-redux-devtools`

## Extras

- IMPORT COST `code --install-extension wix.vscode-import-cost`

- BRACKET PAIR COLORIZER `code --install-extension CoenraadS.bracket-pair-colorizer`

- GIT LENS `code --install-extension eamodio.gitlens`
