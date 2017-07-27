CSS Style guide
===============

## Purpose
The aim of this document is to show good practices and conventions while using CSS in Wolox S.A.. This document will be used in trainings and as a reference in Code Reviewing.
This document must be reviewed and regularly updated.


## Style
#### Naming:
When naming a class, use names as short as possilbe, but large enough to be representative:

**.navigation** is too large, when we consider that **.nav** is representative enough

**.atr** is very short and not representative enough to name **.author**

Using ids in css (i.e.: _#navigation_) is not recommended.

There are particular ocassions where using ids is the only choice (i.e.: You want to override some rules from a component).

If a classname should have 2 words, they must be separed only by a middle dash (hyphen-case a.k.a. kebab-case)

**.demo-image** instead of **.demo_image**, nor **.demoImage** nor **.demoimage**

#### CSS and HTML tags:
Avoid using HTML tags en css:
Instead of **p.error{ }** , use **.error{ }**
Instead of **p {}**, include in your html **p.caption** and use **.caption{}**

#### Shorthands:
Shorthands use is expected

    margin: 0 10px 20px;

Shorthands (used for margin, padding, border, etc.) depends on the amount of values listed.

If a shorthand has 4 values

    margin: 25px 50px 75px 100px;

That means

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 75px;
    margin-left: 100px;

If a shorthand has 3 values

    margin: 25px 50px 75px;

That means

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 75px;
    margin-left: 50px;

If a shorthand has 2 values

    margin: 25px 50px;

That means

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 25px;
    margin-left: 50px;

If a shorthand has 1 value

    margin: 25px;

That means

    margin-top: 25px;
    margin-right: 25px;
    margin-bottom: 25px;
    margin-left: 25px;


#### Units:
Avoid adding unit suffix when the value is **“0”**.

    margin: 0;

Instead of

    margin: 0px;

#### Fonts:
Web safe fonts (A.K.A. callback fonts) are recommended

    .caption {
        font-family: 'Times New Roman', Times, serif;
    }

If the browser couldn't load the first font, it would use the next one and so on.

#### Colors:
Color variables must be used

    color: #4285F4; //wrong
    color: $cornflower-blue; //right

Then, in a file called **\_colors.scss**

    $cornflower-blue: #4285F4;

Color name should describe the color as it is and not where is used.

Avoid:

    background-color: $table-header-color;

Avoid:

    color: $main-title;

Instead, use:

    color: $cornflower-blue;

To avoid color repetition (Ej: _$light-grey_, _$lighter-grey_) we use [Name that color](http://chir.ag/projects/name-that-color/).

Use color abbreviations if possible, changing

    $beauty-bush: #EEBBCC;

for

    $beauty-bush: #EBC;

Color hex should not be in lowercase, changing

    $beauty-bush: #ebc;

for

    $beauty-bush: #EBC;

#### Properties order:
Properties must be alphabetically ordered

    background: fuchsia;
    border: 1px solid;
    border-radius: 4px;
    color: black;
    text-align: center;
    text-indent: 2em;

#### Indentation:
Property should be indented with 2 spaces respect from its containing block

    .test {
      display: block;
      height: 100px;
    }

In case of nested blocks, they should be separed with one blank link  and indented with 2 spaces

    .test {

      .caption {
        color: $cornflower-blue;
      }
    }

#### Declaration stop:
Declarations should end with “;”

    .test {
      display: block;
      height: 100px;
    }

Avoid lines with no declarations stop such as:

    .test {
      display: block;
      height: 100px
    }

#### Propery names:
Property names should be followed by one space

    display:block; //Wrong
    display: block; //Right

#### Block names:
Block names should be followed by one space

    .video{  //Wrong
      margin-top: 10px;
    }

    .video
    {  //Wrong
      margin-top: 10px;
    }

    .video {  //Right
      margin-top: 10px;
    }

#### Multiple selectors per block:
When many selectos has the same properties, it is recommended to use a single block with multiple selectors

    .sale-option:focus,
    .sale-option:active {
      color: $green;
    }

Multiple selectors must not be written in the same line

    .sale-option:focus, .sale-option:active {  //Incorrecto
      color: $green;
    }

#### Rules separation
Rules must be separated with a blank line

    .container {
      background: $white;
    }
    .tile { // No blank line, wrong
      margin: auto;
      width: 50%;
    }

    .container {
      background: $white;
    }

    .tile { // Blank line, right
      margin: auto;
      width: 50%;
    }


#### Quotes
Use single quotes

    .caption {
      font-family: “open sans”, arial, sans-serif; // Wrong
    }

    .caption {
      font-family: 'open sans', arial, sans-serif; // Right
    }

##  Naming:
There are many different approaches to css naming (expressive, atomic, object-oriented). The most important thing (in case of maintaining existing css) is to create classes that matches the style and approach already implemented.

#### Expressive approach:

    .home-container { // Not recommended (Based on expressive css)
      padding: 10px;
    }

    .padding-10 { // Recommended (Based on expressive css)
      padding: 10px;
    }
** Note: ** Remember that naming recomendations are flexible and depends on the naming approach.

#### Naming in Slim:
Put the id (if there is one) before the classname

    // Wrong
    .class-name#container-home

    // Right
    #container-home.class-name

** Avoid using br tag:**
When breaking containers, paddin or margin should be used.

