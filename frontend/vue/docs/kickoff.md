# Vue Bootstrap

## Installing Vue CLI
Install the CLI using the npm package manager: ```npm install -g @vue/cli```

## Create a new Vue aplication

1. Download [.vuerc](./.vuerc) and place it in your root directory (`~/`).

2. Run ```vue create <project_name> -p wolox-vue``` and follow the instructions.

3. Configure eslint

Install `eslint-config-wolox-vue`

```bash
npm i -D eslint-plugin-prettier eslint-config-wolox eslint-config-wolox-vue
```

Modify the `.eslintrc.js`:

```diff
  extends: [
    'plugin:vue/essential',
-    '@vue/standard'
+    '@vue/standard',
+    'wolox-vue'
  ],
```

and

```diff
overrides: [
    {
      files: [
        '**/__tests__/*.{j,t}s?(x)',
-       '**/tests/unit/**/*.spec.{j,t}s?(x)'
+       '**/*.spec.{j,t}s?(x)'
      ],
      env: {
        jest: true
      }
    }
  ]
```

4. Modify the `jest.config.js` file

```diff
module.exports = {
-  preset: '@vue/cli-plugin-unit-jest'
+  preset: '@vue/cli-plugin-unit-jest',
+  testMatch: ['<rootDir>/(**/*.spec.(js|jsx|ts|tsx)|**/__tests__/*.(js|jsx|ts|tsx))']
}
```
