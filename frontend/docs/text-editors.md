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

#### Atom Beautify
It sets identation configuration for many languages following its comunity standards.
```
apm install atom-beautify
```

#### Linter

It shows errors in real time. Linter provides and Api so the other linters can display the error messages. You have to install a diferent linter for each language.

![Image of Linter](https://i.github-camo.com/70b6e697c9d793642414b4ea6d08dbb9678877b3/687474703a2f2f672e7265636f726469742e636f2f313352666d6972507a322e676966)


```
apm install linter
apm install linter-htmlhint
apm install linter-csslint
apm install linter-sass-lint
apm install linter-pug-lint
apm install linter-eslint
apm install linter-scss-lint
```

To use the Rubocop and SCSS linter you need to install the following gems:
```
gem install scss_lint
```

#### Minimap

![Image of Minimap](https://i.github-camo.com/bb671dcf7706c32eb432472c2cd69d354f824661/68747470733a2f2f6769746875622e636f6d2f61746f6d2d6d696e696d61702f6d696e696d61702f626c6f622f6d61737465722f7265736f75726365732f73637265656e73686f742e706e673f7261773d74727565)

It allows you to preview the source code for easier navigation
```
apm install minimap
```
#### Color Picker
![Image of Color-Picker](https://i.github-camo.com/467c72e686f00893c3d36bf46499e76c10f31787/68747470733a2f2f6769746875622e636f6d2f74686f6d61736c696e647374726f6d2f636f6c6f722d7069636b65722f7261772f6d61737465722f707265766965772e676966)

```
apm install color-picker
```

#### Pigments

![Image of Pigments](https://i.github-camo.com/802d8b759d01e70861f95f99495731f19b145b03/687474703a2f2f61626533332e6769746875622e696f2f61746f6d2d7069676d656e74732f7069676d656e74732e6769663f7261773d74727565)
It display CSS colors in place
```
apm install pigments
```

#### node-requirer

![image of node-requirer](https://user-images.githubusercontent.com/25931366/28980572-b476c736-7924-11e7-8f81-9f53bf1c8c13.gif)

It lets you quickly add require/import statements to any files within your code.

```
apm install node-requirer
```

#### js-hyperclick

![image of js-hyperclick](https://user-images.githubusercontent.com/25931366/28981322-a7e89bfe-7927-11e7-9265-d2318ef0f22c.gif)

It lets you jump to where variables are defined. (JS only)

```
apm install js-hyperclick
```

#### React
React.js (JSX) language support, indentation, snippets, auto completion, reformatting


```
apm install react
```

#### Highlight-selected
Double click on a word to highlight it throughout the open file.

![image of highlight](https://user-images.githubusercontent.com/25931366/29073959-0120d44e-7c24-11e7-8bf1-ea2053820c96.gif)

```
apm install highlight-selected
```

#### tab-foldername-index
It replaces tab’s title if opened multiple files with the same name for more readability.

![image of tab-foldername](https://user-images.githubusercontent.com/25931366/29074125-85109a50-7c24-11e7-94ab-dc0488e56a3e.png)

```
apm install tab-foldername-index
```

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
