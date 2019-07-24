# Frontend Style Guide

## Content

- [Guidelines](#guidelines)
  - [Javascript](#javascript)
    - [Angular](#angular)
  - [CSS/SASS](#csssass)
- [External Resources](#external-resources)
  - [Images Presentation](#images-presentation)
  - [Scrolling](#scrolling)
  - [Tooltips](#tooltips)
  - [Animations And Transitions](#animations-and-transitions)
  - [Loading](#loading)
  - [Modals](#modals)
  - [Gif Screen Recorders](#gif-screen-recorders)
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

## Gif Screen Recorders
- [Licecap](https://www.cockos.com/licecap/) (Windows/macOS)
- [Peak](https://github.com/phw/peek) (Linux)

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
