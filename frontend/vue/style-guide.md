# Vue Style Guide

## Table of contents

- [Vue Style Guide](#vue-style-guide)
  - [Table of contents](#table-of-contents)
  - [Basic rules](#basic-rules)
  - [Folder structure](#folder-structure)
  - [Ordering](#ordering)
  - [Props](#props)
    - [Prop types](#prop-types)
    - [Passing props to children component](#passing-props-to-children-component)
    - [Prop name casing](#prop-name-casing)
  - [Alignment](#alignment)
  - [Quotes and Case styles](#quotes-and-case-styles)
  - [Spacing](#spacing)
  - [Routing](#routing)
  - [State management](#state-management)
  - [Functional Components](#functional-components)
    - [For Vue 2.x](#for-vue-2x)
    - [For Vue 3.x](#for-vue-3x)
  - [v-model](#v-model)
    - [For Vue 2.x](#for-vue-2x-1)
    - [For Vue 3.x](#for-vue-3x-1)
  - [Fragments](#fragments)
    - [Only Vue 3.x](#only-vue-3x)
  - [Emits](#emits)
    - [For Vue 2.x](#for-vue-2x-2)
    - [For Vue 3.x](#for-vue-3x-2)
  - [Mixins](#mixins)
    - [For Vue 2.x](#for-vue-2x-3)
    - [For Vue 3.x](#for-vue-3x-3)
  - [Filters](#filters)
    - [For Vue 2.x](#for-vue-2x-4)
    - [For Vue 3.x](#for-vue-3x-4)
  - [Options API](#options-api)
  - [Composition API](#composition-api)
    - [Only Vue 3.x](#only-vue-3x-1)
  - [Reactivity API](#reactivity-api)
    - [Only Vue 3.x](#only-vue-3x-2)
  - [Provide and Inject](#provide-and-inject)
    - [Only Vue 3.x](#only-vue-3x-3)

## Basic rules

* When using the data property on a component, it **must** be a function that return an object. The only exception to the rule is in a root Vue instance, since only a single instance will ever exist.

* Always use v-bind shortcut `:` instead of the whole directive `v-bind:`. E.g.: Do `:value="someValue"` instead of `v-bind:value="someValue"`.

* Always use v-on shortcut `@` instead of the whole directive `v-on:`. E.g.: Do `@click="handleClick"` instead of `v-on:click="handleClick"`.




## Folder structure

```
src
|
├── assets // General app assets
|
├── components
|    ├ MyComponent.vue // Simple component
|    ├ RelatedComponents // Similar or related components
|      ├ RelatedComponent1.vue
|      └ RelatedComponent2.vue
|    └ OtherComponent // Complex component
|      ├ index.js
|      ├ constants.js
|      └ utils.js
|
├── composables
|    └ useSomething.js // Must follow the format 'use#{Something}.js'
|
├── config
|    ├ api.js
|    ├ i18n // Folder with all the translations
|    ├ i18n.js
|    └ router.js
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
|    ├ SomeView.vue
|    └ OtherView
|      ├ index.js
|      ├ composables
|        └ useSomething.js // Must follow the format 'use#{Something}.js'
|      └ components
|        ├ ChildComponent1.vue
|        └ ChildComponent2.vue
|      ├ constants.js
|      └ utils.js
|
├── App.vue
|
├── main.js
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
        * <span style='color: orangered'>beforeDestroy (Vue2) / beforeUnmount (Vue3)</span>
        * <span style='color: orangered'>destroyed (Vue2) / unmounted (Vue3)</span>
10. Non-Reactive Properties
    * <span style='color: orangered'>methods</span>
11. Rendering
    * <span style='color: orangered'>template / render</span>
    * <span style='color: orangered'>renderError</span>

The order of tags in single file components ([SFC](https://v3.vuejs.org/api/sfc-spec.html)) will be:
1. Template
2. Script
3. Style


## Props

### Prop types

We're going to use the object syntax for the **props** option. This is in order to always specify the data type.

```js
// bad
props: ['title', 'isSelected', 'amount', 'onSelect']
```

```js
// good
props: {
  title: { type: String, required: true },
  isSelected: { type: Boolean, required: true },
  amount: { type: Number, required: true },
  onSelect: { type: Function, required: true }
}
```

Additionally, we're going to write the required props in the top. For those that aren't required, we're going to avoid specifying this attribute and we must set a default value for them.

```js
// bad
props: {
  title: { type: String, required: true },
  amount: { type: Number },
  isSelected: { type: Boolean, required: true },
  onSelect: { type: Function, required: false },
  text: { type: String },
  list: { type: Array,  },
  info: { type: Object, required: false }
}
```

```js
// good
props: {
  title: { type: String, required: true },
  isSelected: { type: Boolean, required: true },
  amount: { type: Number, default: 0 }
  info: { type: Object, default: () => ({}) },
  list: { type: Array, default: () => ([]) },
  onSelect: { type: Function, default: () => null }
  text: { type: String, default: '' }
}
```

### Passing props to children component

When we wanna send a static string value, we're going to avoid the **v-bind** directive and the double use of quotation marks.

```pug
// bad
my-component(:title='"This is my title!"')
my-component(:title="'This is my title!'")
```

```pug
// good
my-component(title='This is my title!')
```

When we wanna send a number, we must bind that value. Even if we're going to send a static number, we need to do this in order to tell Vue this is not a string.

```pug
// bad
my-component(stars='4') // Here we're sending the string '4'
my-component(stars='article.reviews') // Here we're sending the string 'article.reviews'
```

```
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

### Prop name casing

This topic is discussed [in this section](#quotes-and-case-styles).
As Vue separates the template from the script, we're going to follow the conventions of each language. HTML attribute names are case-insensitive, so browsers will interpret any uppercase characters as lowercase. That's why we're going to use kebab-case in the HTML. Within Javascript, lowerCamelCase is more natural.


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

## Quotes and Case styles

The quotation mark we will use will depend on the language we're using. The idea is to keep the standard for that language. Same goes for the case styles.

| Language | Primary quotes | Secondary quotes | Case style |
| -------- | -------------- | ---------------- | ---------- |
|HTML|Double|Single|kebab-case|
|Pug|Single|Double|kebab-case|
|JavaScript|Single|Double|camelCase|
|TypeScript|Single|Double|camelCase|
|SCSS|Single|Double|kebab-case|

Exceptions:
- When sending props to an element, if the value comes from JavaScript, then, we have to use the case style from JavaScript for that value.
- We recommend the use of kebab-case for SCSS, but if you're going for an approach like BEM, you're free to do it as long as you keep it consistent along the project.
- Despite the use of single quotes as the main ones for SCSS is not the standard, it is the one we have adopted at Wolox.

```pug
// bad
<template lang='pug'>
.container
  label(:class="{ activeLabel: 'is-active-block' }")
    | {{ name-label }}
  input(v-model="name" type="filters.name")
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

<style lang='scss' scoped>
.container {
  font-family: 'Lato';
}

.active-label {
  border: 1px solid blue;
}
</style>
```

```pug
// good
<template lang="pug">
.container
  label(:class='{ "active-label": isActiveBlock }')
    | {{ nameLabel }}
  input(v-model='name' type='filters.name')
<template>

<script>
export default {
  data() {
    return {
      filters: {
        name: ''
      }
    }
  },
  computed: {
    isActiveBlock() {
      ...
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  font-family: 'Lato';
}

.active-label {
  border: 1px solid blue;
}
</style>
```


## Spacing

- Always add spaces around the braces.
- Always leave an empty line between template, script and style tags.

## Routing

We use [vue-router](https://router.vuejs.org/), the official router for Vue.js

## State management

We use Vuex for the state management

- For Vue2: [Vuex3](https://vuex.vuejs.org/)
- For Vue3: [Vuex4](https://next.vuex.vuejs.org/)

Additionally in Vue3, for component state management without much complexity, we prefer the use of [Provide and Inject](#provide-and-inject)

## Functional Components

### For Vue 2.x
```js
// bad
<template>
<div>
  <span>{{ title }}</span>
  <span>{{ $t('key') }}</span>
</div>
</template>

<script>
export default {
  props: {
    title: { type: String, default: '' }
  }
}
</script>
```

```js
// good
<template functional>
<div>
  <span>{{ props.title }}</span>
  <span>{{ parent.$t('key') }}</span>
</div>
</template>
```

### For Vue 3.x
Performance gains from 2.x for functional components are now negligible in 3.x, so we recommend just using stateful components.

## v-model

### For Vue 2.x
See https://vuejs.org/v2/api/#v-model
### For Vue 3.x
Now we can pass an argument to v-model:

```pug
<template>
<child-component v-model:title="pageTitle" />
</template>

<!-- Shorthand for -->
<child-component :title="pageTitle" @update:title="pageTitle = $event" />
```

See https://v3.vuejs.org/guide/migration/v-model.html

## Fragments
### Only Vue 3.x
In Vue 3, components now have official support for multi-root node components, i.e., fragments!
See https://v3.vuejs.org/guide/migration/fragments.html#overview

## Emits
### For Vue 2.x
See https://vuejs.org/v2/guide/components.html#Emitting-a-Value-With-an-Event
### For Vue 3.x
https://v3.vuejs.org/guide/component-custom-events.html#event-names
## Mixins
### For Vue 2.x
See https://vuejs.org/v2/guide/mixins.html
### For Vue 3.x
See https://v3.vuejs.org/guide/mixins.html

## Filters
### For Vue 2.x
In a project you can define all the filters that you think are convenient.

In general, the recommendation is that if we see that a calculation is repeated or is going to be repeated a lot in several transversal components, it is convenient to evaluate if it is created as a filter.

See https://vuejs.org/v2/guide/filters.html
### For Vue 3.x
Filters are removed from Vue 3.0 and no longer supported. Instead, we recommend replacing them with method calls or computed properties.

## Options API
See https://v3.vuejs.org/api/options-api.html

## Composition API
### Only Vue 3.x
See https://v3.vuejs.org/api/composition-api.html

## Reactivity API
### Only Vue 3.x
See https://v3.vuejs.org/api/reactivity-api.html

## Provide and Inject
### Only Vue 3.x
See https://v3.vuejs.org/guide/composition-api-provide-inject.html