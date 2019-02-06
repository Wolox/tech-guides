# Vue Tech Guides

We use the [Official Vue linter](https://github.com/vuejs/eslint-plugin-vue) as reference for Javascript style.

## Table of Contents

  1. [Folder Structure](#folder-structure)
  1. [Component Structure](#component-structure)
  1. [Functional components](#functional-components)
  1. [Props](#props)
  1. [Slots](#slots)
  1. [Mixins](#mixins)
  1. [Vuex](#Vuex)
  1. [CSS Styles](#css-styles)
  1. [Testing](#testing)
  1. [Environments and deploy](#environments-and-deploy)

## Folder Structure

```
src  
│
└───components
│     └─── Loader.vue
│     └─── Sidebar.vue
│     └─── etc
└───views
│       └─── MyScreenComponent.vue
|
└───assets // General app assets
└───config
|   | api.js
│   └─── i18n
|   |    └─── TranslationScope  // This is commonly either a view or a component
|   |    |    | scope.js  // This is commonly either a view or a component
|
└───constants
└───store
│   | index.js
│   └───modules
│       | myModule.js
│
└───scss
│     └─── commons
|     |    | buttons.scss
|     |    | myComponents.scss
│     └─── variables
|     |    | _sizes.scss
|     |    | _colors.scss
|     |    | _myVariables.scss
│     | application.scss
|
└───services
|   | MyService.js
│
└───utils
│   App.vue
│   main.js
│   router.js
```