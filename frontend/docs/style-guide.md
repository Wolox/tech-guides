# Frontend Style Guide

## Content

- [Guidelines](#guidelines)
  - [Javascript](#javascript)
    - [Angular](#angular)
  - [CSS/SASS](#csssass)
    - [General](#general)
- [Text editors](#text-editors)
  - [Atom](#atom)
    - [Installation](#installation)
    - [Packages](#packages)
      - [Atom Beautify](#atom-beautify)
      - [Linter](#linter)
      - [Minimap](#minimap)
      - [Color picker](#color-picker)
      - [Pigments](#Pigments)
- [Browser Extensions](#browser-extensions)
  - [Chrome](#chrome)
  - [Firefox](#firefox)
- [External Resources](#external-resources)
  - [Images Presentation](#images-presentation)
  - [Scrolling](#scrolling)
  - [Tooltips](#tooltips)
  - [Animations And Transitions](#animations-and-transitions)
  - [Loading](#Loading)
  - [Modals](#Modals)
- [Learning Resources - Frontend](#learning-resources---frontend)
  - [Books](#books)
  - [Articles](#articles)
  - [Channels](#channels)
  - [Tutorials](#tutorials)
- [Learning Resources - Design - UI/UX](#learning-resources---design---uiux)
- [Wolox Codepen](http://codepen.io/collection/DgkEWk/)


## Guidelines
  This section contains styleguides that every woloxer should know when developing html/css/js user interfaces.
  Some of these are opinionated guides widely accepted by the dev community and some were developed
  by us (Wolox team) considering some usual use cases faced during the development of our projects.

# Javascript
  - [Airbnb Javascript Styleguide](https://github.com/airbnb/javascript/tree/master/react)
    - General rules for writing javascript code.
  - [Lodash](https://lodash.com/docs)
    - Javascript utility library
  - [Eslint](http://eslint.org/)
    - Javascript syntax and style checker. Check our current rules [here](https://github.com/Wolox/frontend-bootstrap/blob/master/.eslintrc)

# Angular
  - [Papa's Styleguide](https://github.com/johnpapa/angular-styleguide)
    - Specific conventions for syntax and structuring angular applications and why you should follow them.
  - Angular code snippets
    - [Fetch data from API: Infinite scroll](https://codepad.co/snippet/b27gCGTJ)

# CSS/SASS

## Nested rules
Nested rules are used to avoid repetition of parent selectors. Just try to don't use IDs. They make all the thing slower.
#### Basic example:
```scss
.paragraph {
  color: $red;

  .important-text {
    font-weight: bold;
  }
}
```
#### Using parent
Another great thing is to refer to parent. Rember, using `&` is like copy-pasting the parent selector. If the selector is actually a list, the `&` will be also a list, containing the selectors strings.
```scss
.awesome-button {
  &:hover {
    background-color: $red;
  }

  &--hidden {
    display: none;
  }
}
```

## Variables

Variables can store any data type, and they should begin with a `$`. Their scope is restricted to their nesting level, and to any level deeper.
```scss
$black: #000;
$green: #0F0;

.big-footer {
  color: $black;

  .footer-text {
    color: $green;
  }
}
```

## import

You can serve a single css file by using `@import`. This way you won't need to make multiple requests.
```scss
@import 'reset';

body {
  font-family: sans-serif;
  background-color: $blue;
}
```
there a file named `reset.scss` would be included.

## comments

Comments in sass are written with `//` instead of `/* ... */`. It's convinient to use sass comments because this ones are removed when creating the css file which makes the file smaller.

## Extends & Placeholders

In sass you can reuse class properties by declaring that a certain property extends another.

```scss
.icon {
  transition: background-color ease .2s;
  margin: 10px;
}

.error-icon {
  @extend .icon;
  ...
}

.info-icon {
  @extend .icon;
  ...
}
```
Placeholders are used when you want to extend a selector that won't be used in the css. In the previous case if we don't use `.icon` in our website we can declare it as a placeholder and use it in the other classes.

```scss
%icon {
  transition: background-color ease .2s;
  margin: 10px;
}

.error-icon {
  @extend %icon;
  ...
}

.info-icon {
  @extend %icon;
  ...
}
```

## Mixins
In Sass you can generate functions called mixins that can receive parameters and are used inside selectors to add attributes inside of it.

```scss
@mixin border-radius($radius) {
  -webkit-border-radius: $radius;
  -moz-border-radius: $radius;
  -ms-border-radius: $radius;
  border-radius: $radius;
}

.box {
  @include border-radius(10px);
}
```

### CSS style guide
To know more about CSS conventions and best practices, check [this document](./css-style-guide.md).

# Text editors

## Atom

[Atom](https://atom.io/) is a highly customizable text editor. It's open source, developed by github and has tons of Packages to extend its functionality.

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

# Browser Extensions

## Chrome

### Design & components
 - [Muzli](http://muz.li/join/)

### Responsiveness
 - [Window resizer] (https://chrome.google.com/webstore/detail/window-resizer/kkelicaakdanhinjdeammmilcgefonfh?hl=en)

### Proportions & alignment
 - [Page Ruller] (https://chrome.google.com/webstore/detail/page-ruler/jlpkojjdgbllmedoapgfodplfhcbnbpn)
 - [Dimensions] (http://felixniklas.com/dimensions/)

## Firefox

# External Resources

## Images Presentation
### General Stuff

 - [Favicomatic](http://www.favicomatic.com/)

### Libraries

 - [RetinaJs](https://imulus.github.io/retinajs/)
 - [iPhone inline video](https://github.com/bfred-it/iphone-inline-video)
 - [Cleave](http://nosir.github.io/cleave.js/)
 - [ngDialog](http://likeastore.github.io/ngDialog)
 - [Hyphenator.js](https://github.com/mnater/Hyphenator)

### Images Presentation
  - [Multi Layout Slideshow](http://tympanus.net/Development/MultiLayoutSlideshow/)
  - [Image Grid Effects](http://tympanus.net/Development/ImageGridEffects/)
  - [Polaroid Stack Grid](http://tympanus.net/Tutorials/PolaroidStackGrid/)
  - [Image hover](http://imagehover.io/)
  - [Filters](http://www.cssco.co/)

## Scrolling
  - [Scrollanim](http://scrollanim.kissui.io/)
  - [Scrollorama](http://scrollmagic.io/)
  - [Page transition effect](http://tympanus.net/Tutorials/PageRevealEffects)
  - [scrollReveal](https://scrollrevealjs.org/)

## Tooltips
  - [Tooktik](https://eliorshalev.github.io/tootik/)
  - [Baloon](http://kazzkiq.github.io/balloon.css/)

## Animations And Transitions
  - [Wait](http://waitanimate.eggbox.io/#/)
  - [Shift](http://shift.octavector.co.uk/)
  - [Heat distortion](http://tympanus.net/Tutorials/HeatDistortionEffect)

## Loading
  - [emerge](http://ilyabirman.net/projects/emerge/)
  - [spinner](http://tympanus.net/Tutorials/SpringLoaders)

## Modals
  - [modal with css only](http://www.webdesignerdepot.com/2012/10/creating-a-modal-window-with-html5-and-css3/)

# Learning Resources - Frontend

## Books
  - [You Don't Know JS](https://github.com/getify/You-Dont-Know-JS)
    - Series of books diving deep into the core mechanisms of the JavaScript language. Ask for them in the Wolox's library!

## Articles
  - [Learning JS in 2016](https://medium.com/@_cmdv_/i-want-to-learn-javascript-in-2015-e96cd85ad225#.dc14xnd8w)
    - Step by step guide from zero to master knowledge in JS. Mentions useful links and courses to properly learn the language tools and frameworks.

## Channels

## Tutorials
  - [Angular begginer's tutorial](https://www.codeschool.com/courses/shaping-up-with-angular-js)
    - A starter guide to angular

# Learning Resources - Design - UI/UX
