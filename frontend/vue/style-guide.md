# Vue Style Guide

## Table of contents

1. [Basic rules](#basic-rules)
2. [Folder structure](#folder-structure)
3. [Ordering](#ordering)
4. [Props](#props)
5. [Alignment](#alignment)
6. [Quotes](#quotes)
7. [Spacing](#spacing)
8. [Vue-Router](#vue-router)

## Basic rules

* When using the data property on a component, it **must** be a function that return an object. The only exception to the rule is in a root Vue instance, since only a single instance will ever exist.

* Always use v-bind shortcut `:` instead of the whole directive `v-bind:`. E.g.: Do `:value="someValue"` instead of `v-bind:value="someValue"`.




## Folder structure

```
src
|
├── assets // General app assets
|
├── components
|    ├ MyComponent.vue
|    └ RelatedComponents
|      ├ RelatedComponent1.vue
|      └ RelatedComponent2.vue
|
├── config
|    ├ api.js
|    ├ i18n // folder with all the translations.
|    └ i18n.js
|
├── constants // Folder with js files
|
├── mixins // Folder with js files
|    ├ userRoles.js
|    └ statistics.js
|
├── scss
|    ├ application.scss
|    ├ commons // SASS Component and common styles (display, margins, texts, etc.)
|    └ variables // SASS variables (colors, sizes, etc.)
|
├── services
|    └ UserService.js // Must follow the format '#{Something}Service.js'
|
├── store
|    ├ index.js
|    └ modules // Folder with js files that contains parts of the store.
|
├── utils // Folder with js files
|
├── views // Main views
|
├── App.vue
|
├── main.js
|
└── router.js

```

## Ordering

Component/instance options should be ordered consistently. Here at Wolox, we have opted for the recommended way from the Vue's official site.

1. Side Effects
    * <span style='color: orangered'>el</span>
2. Global Awareness
    * <span style='color: orangered'>name</span>
    * <span style='color: orangered'>parent</span>
3. Component Type
    * <span style='color: orangered'>functional</span>
4. Template Modifiers
    * <span style='color: orangered'>delimiters</span>
    * <span style='color: orangered'>comments</span>
5. Template Dependencies
    * <span style='color: orangered'>components</span>
    * <span style='color: orangered'>directives</span>
    * <span style='color: orangered'>filters</span>
6. Composition
    * <span style='color: orangered'>extends</span>
    * <span style='color: orangered'>mixins</span>
7. Interface
    * <span style='color: orangered'>inheritAttrs</span>
    * <span style='color: orangered'>model</span>
    * <span style='color: orangered'>props/propsData</span>
8. Local State
    * <span style='color: orangered'>data</span>
    * <span style='color: orangered'>computed</span>
9. Events
    * <span style='color: orangered'>watch</span>
    * <span style='color: orangered'>Lyfecycle Events</span>
        * <span style='color: orangered'>beforeCreate</span>
        * <span style='color: orangered'>created</span>
        * <span style='color: orangered'>beforeMount</span>
        * <span style='color: orangered'>mounted</span>
        * <span style='color: orangered'>beforeUpdate</span>
        * <span style='color: orangered'>updated</span>
        * <span style='color: orangered'>activated</span>
        * <span style='color: orangered'>deactivated</span>
        * <span style='color: orangered'>beforeDestroy</span>
        * <span style='color: orangered'>destroyed</span>
10. Non-Reactive Properties
    * <span style='color: orangered'>methods</span>
11. Rendering
    * <span style='color: orangered'>template / render</span>
    * <span style='color: orangered'>renderError</span>

## Props

### Prop name casing

As Vue separates the template from the script, we're going to follow the conventions of each language. HTML attribute names are case-insensitive, so browsers will interpret any uppercase characters as lowercase. That's why we're going to use kebab-case in the HTML. Within Javascript, lowerCamelCase is more natural.

```pug
// bad
<template lang="pug">
  my-component(greetingText="hi")
</template>

<script>
  props: {
    'greeting-text': { type: String }
  }
</script>
```

```pug
// good
<template lang="pug">
  my-component(greeting-text="hi")
</template>

<script>
  props: {
    greetingText: { type: String }
  }
</script>
```

### Prop types

We're going to use the object syntax for the **props** option. This is in order to always specify the data type.

```js
// bad
props: ['title', 'isSelected', 'amount', 'onSelect']
```

```js
// good
props: {
  title: { type: String },
  isSelected: { type: Boolean },
  amount: { type: Number },
  onSelect: { type: Function }
}
```

Additionally, we're going to write in the top the required props, and we're also going to avoid specifiying this attribute when it's not required.

```js
// bad
props: {
  title: { type: String, required: true },
  isSelected: { type: Boolean, required: false },
  amount: { type: Number },
  onSelect: { type: Function, required: true }
}
```

```js
// good
props: {
  title: { type: String, required: true },
  onSelect: { type: Function, required: true },
  isSelected: { type: Boolean },
  amount: { type: Number }
}
```

### Passing props to children component

When we wanna send a static string value, we're going to avoid the **v-bind** directive.

```pug
// bad
my-component(:title='"This is my title!"')
```

```pug
// good
my-component(title='This is my title!')
```

When we wanna send a number, we must bind that value. Even if we're going to send a static number, we need to do this in order to tell Vue this is not a string.

```pug
// good
my-component(:stars='4')
my-component(:stars='article.reviews')
```

When sending explicitly `true` props, omit the value. It also must be passed last.

```pug
// bad
my-component(
  :title='article.title'
  :dark-theme='true'
  :stars='article.review'
)
```

```pug
// good
my-component(
  :title='article.title'
  :stars='article.review'
  dark-theme
)
```

## Alignment

* The content of the template, the script and the style sections must be align on the left, without any indentation for the first level.
```pug
// bad
<template lang="pug">
  .container
    my-component
</template>

<script>
  import MyComponent from '../components/MyComponent'
</script>

<style lang="scss" scoped>
  .container {
    width: 100%;
  }
</style>
```
```pug
// good
<template lang="pug">
.container
  my-component
</template>

<script>
import MyComponent from '../components/MyComponent'

export default {
  
}
</script>

<style lang="scss" scoped>
.container {
  width: 100%;
}
</style>
```

* Closing parenthesis, brackets and braces should be aligned at the same indentation than the opening ones.

```js
// bad
export default {
  methods: {
    generateOptions() {
      this.myArray.map((element, idx) => (
        { value: element.id, label: element.name }))}
  }
}
```

```js
// good
export default {
  methods: {
    generateOptions() {
      this.myArray.map((element, idx) => (
        { value: element.id, label: element.name }
      ))
    }
  }
}
```

## Quotes

In the template and html tags, always use double quotes (`"`) as the main quotation mark, and single ones (`'`) as secondary. On the contary, in the script and the style sections use single quotes as the main quotation mark and double as secondary.

```pug
// bad
<template lang="pug">
.container
  input(v-model='name' type='filters.name')
<template>

<script>
export default {
  data() {
    return {
      filters: {
        name: ""
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  font-family: "Lato";
}
</style>
```

```pug
// good
<template lang="pug">
.container
  input(v-model="name" type="filters.name")
<template>

<script>
export default {
  data() {
    return {
      filters: {
        name: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  font-family: 'Lato';
}
</style>
```


## Spacing

Always add spaces around the braces.

## Vue-Router

