# CSS Style guide

## Purpose
The aim of this document is to show good practices and conventions while using CSS in Wolox S.A.. This document will be used in trainings as well as a reference for Code Reviewing.
This document must be reviewed and regularly updated.

## CSS Conventions

### Naming
- When naming a class, use names as short as possible, but large enough to be representative:

  For example: we consider that `.navigation` is too large, and we preffer to use `.nav` instead. On the other hand we think `.author` is more representative than naming your class `.atr`.

- If a class name has more than one word, they should be separated by hyphens (hyphen-case a.k.a. kebab-case or spinal-case). Use `.demo-image` instead of `.demo_image`, `.demoImage` or `.demoimage`

### ID usage

Using IDs in CSS (i.e.: `#navigation`) is not recommended since it makes selectors too specific. We always try to define the selectors as simple as possible so they can be easily overridden in the future.

There are particular cases where defining IDs in the HTML is ok (i.e.: You want to target an element from JS). It's also acceptable to use them to override a library that styles it's components with IDs.

### CSS and HTML tags
Avoid using HTML tags inside your CSS files:
- Instead of `p.error{ }` , use `.error{ }`
- Instead of `p {}`, add to your html a representative class name and target that class instead.

### Shorthands
Shorthands are used for margin, padding, border, etc. and their meaning depends on the amount of values listed. It's always preferred to use shorthands instead of multiple properties.

- If a shorthand has 4 values

```css
margin: 25px 50px 75px 100px;
```

  That means
```css
margin-top: 25px;
margin-right: 50px;
margin-bottom: 75px;
margin-left: 100px;
```
- If a shorthand has 3 values
```css
margin: 25px 50px 75px;
```
  That means
```css
margin-top: 25px;
margin-right: 50px;
margin-bottom: 75px;
margin-left: 50px;
```
- If a shorthand has 2 values
```css
margin: 25px 50px;
```
  That means
```css
margin-top: 25px;
margin-right: 50px;
margin-bottom: 25px;
margin-left: 50px;
```
- If a shorthand has 1 value
```css
margin: 25px;
```
  That means
```css
margin-top: 25px;
margin-right: 25px;
margin-bottom: 25px;
margin-left: 25px;
```

### Units
Avoid adding unit suffix when the value is `0`.

use:
```css
margin: 0;
```

Instead of:
```css
margin: 0px;
```

### Fonts
We try to always use fonts obtained from Google Fonts (designers are aware of this) and add a browser default font in case the other font doesn't load.

```scss
.caption {
  font-family: 'Open Sans', sans-serif;
}
```

If the browser can't load the first font, it will use the next one and so on.

### Colors
- every time a new color is going to be used, a variable of that color should be created in the `colors.scss` file and used instead.

```scss
// WRONG
color: #4285F4;

// RIGHT
color: $cornflower-blue;
```

  Then, in a file called `colors.scss`

```scss
$cornflower-blue: #4285F4;
```

- this color variables should describe how the color looks and not where it is used.

```scss
// WRONG
background-color: $table-header-color;
color: $main-title;
```

  To avoid color repetition (`$light-grey`, `$lighter-grey`, etc.) we use [Name that color](http://chir.ag/projects/name-that-color/).

- Use color abbreviations if possible, colors with this format `#AABBCC` can be shortened to `#ABC`.

```scss
// WRONG
$beauty-bush: #EEBBCC;

// RIGHT
$beauty-bush: #EBC;
```

- Color hex should be in uppercase for consistency amongst projects

```scss
// WRONG
$beauty-bush: #ebc;

// RIGHT
$beauty-bush: #EBC;
```

### Properties order
Properties must be alphabetically ordered, this makes it easier to find a property.

```scss
// WRONG
border: 1px solid $black;
text-align: center;
background: $fuchsia;

// RIGHT
background: $fuchsia;
border: 1px solid $black;
text-align: center;
```

### Indentation
- Indentation should be of 2 spaces each.
```scss
// WRONG
.book {
    display: block;
    padding: 10px;
}

// RIGHT
.book {
  display: block;
  padding: 10px;
}
```

- In case of nested blocks, they should be separed with one blank line and indented with 2 spaces

```scss
// WRONG
.book {
  display: block;
  padding: 10px;
  .caption {
    color: $cornflower-blue;
  }
}

// RIGHT
.book {
  display: block;
  padding: 10px;

  .caption {
    color: $cornflower-blue;
  }
}
```

### Text Formatting

- All properties should end with `;`

```scss
// WRONG
display: block
```
```scss
// RIGHT
display: block;
```

- Property names should be followed by one space
```scss
// WRONG
display:block;

// RIGHT
display: block;
```

- Selectors should be followed by one space before the curly brace

```scss
// WRONG
.video{
  margin-top: 10px;
}

// WRONG
.video
{
  margin-top: 10px;
}

// RIGHT
.video {
  margin-top: 10px;
}
```

### Multiple selectors per block

When many selectors have the same properties, it is recommended to use a single block with multiple selectors placing a single selector per line

```scss
// WRONG
.sale-option:focus, .sale-option:active {
  color: $green;
}

// RIGHT
.sale-option:focus,
.sale-option:active {
  color: $green;
}
```

### Selector separation

Selectors must be separated with a blank line

```scss
// WRONG
.container {
  background: $white;
}
.tile {
  margin: auto;
  width: 50%;
}

// RIGHT
.container {
  background: $white;
}

.tile {
  margin: auto;
  width: 50%;
}
```

### Pseudo-elements and pseudo-clases

If we have a class with properties and we need to add a pseudo-element or a pseudo-class, we use nesting

```scss
// WRONG
.my-class {
 ...
}

.my-class::before {
 ...
}

// RIGHT
.my-class {
  color: $white;
  
  &::before {
    content: '';
    ... 
  }
} 
```

### Quotes
We always try to avoid the use of double quotes to be consistent amongst projects.

```scss
// WRONG
.caption {
  font-family: “open sans”, sans-serif;
}

// RIGHT
.caption {
  font-family: 'open sans', sans-serif;
}
```

### Setting a fixed width

If you have a component that has an specific width and, in addition, this last is widder than 250px

```scss
// WRONG
.wide-component {
  width: 700px;
}

// RIGHT
.wide-component {
  width: 100%;
  max-width: 700px;
}

// OR
.wide-component {
  width: 700px;
  max-width: 100%;
}
```
This makes that if the viewport is less than 700px, the component will fit to the 100% of its fathers width
