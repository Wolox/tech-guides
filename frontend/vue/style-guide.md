# Vue Style Guide

## Table of contents

1. [Basic rules](#basic-rules)
2. [Folder structure](#folder-structure)
3. [Ordering](#ordering)
4. [Props](#props)

## Basic rules

* When using the data property on a component, it **must** be a function that return an object. The only exception to the rule is in a root Vue instance, since only a single instance will ever exist.

## Folder structure

```
src
|
├── assets // General app assets
|
├── components
|     |
|     ├ MyComponent.vue
|     |
|     └ RelatedComponents
|         |
|         ├ RelatedComponent1.vue
|         |
|         └ RelatedComponent2.vue
|
├── config
|     ├ api.js
|     |
|     └ i18n.js
|
├── mixins // Folder with js files
|
├── scss
|     ├ application.scss
|     |
|     ├ commons // Common styles, like display, margins, texts, etc.
|     |
|     └ variables // Common SCSS variables, like colors, sizes, etc.
|
├── services
|     |
|     └ MyService.js
|
├── store
|     ├ index.js
|     |
|     └ modules // Folder with js files that contains parts of the store.
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
   * `el`
2. Global Awareness
   * `name`
   * `parent`
3. Component Type
   * `functional`
4. Template Modifiers
   * `delimiters`
   * `comments`
5. Template Dependencies
   * `components`
   * `directives`
   * `filters`
6. Composition
   * `extends`
   * `mixins`
7. Interface
   * `inheritAttrs`
   * `model`
   * `props/propsData`
8. Local State
   * `data`
   * `computed`
9. Events
   * `watch`
   * Lyfecycle Events
     * `beforeCreate`
     * `created`
     * `beforeMount`
     * `mounted`
     * `beforeUpdate`
     * `updated`
     * `activated`
     * `deactivated`
     * `beforeDestroy`
     * `destroyed`
10. Non-Reactive Properties
   * `methods`
11. Rendering
   * `template` / `render`
   * `renderError`

## Props

### Prop name casing

As Vue separates the template from the script, we're going to follow the conventions of each language. HTML attribute names are case-insensitive, so browsers will interpret any uppercase characters as lowercase. That's why we're going to use kebab-case in the HTML. Within Javascript, lowerCamelCase is more natural.

```pug
// bad

<template lang='pug'>
   my-component(greetingText='hi')
</template>

<script>
props: {
  'greeting-text': String
}
</script>
```

```pug
// good

<template lang='pug'>
   my-component(greeting-text='hi')
</template>

<script>
   props: {
      greetingText: String
   }
</script>
```
|
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

When we wanna send a static value, we're going to avoid the **v-bind** directive.

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
// bad
my-component(
   :title='article.title'
   :stars='article.review'
   dark-theme
)
```