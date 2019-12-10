# External libraries and type definition (.d.ts files)

TypeScript is a superset of JavaScript, thus we should be able to use the same packages for both. Some of them are already written in TypeScript and expose their types for us to use.

But, what happens with libraries that are not written in TypeScript? TypeScript uses `.d.ts` files to provide types for JavaScript libraries. The community actively shares all of the most up-to-date .d.ts files for popular libraries on a GitHub repository called [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped). 

> **Note!** Since project has `noImplicitAny` option enabled, it is required to have type definitions for **every** library. So, you must write a `.d.ts` file for each library that doesn't provide its own types.

## DefinitelyTyped
The TypeScript community actively shares all of the most up-to-date `.d.ts` files for popular libraries on a GitHub repository called [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types). These `.d.ts` files can be easily installed into your project using, for example: `npm install --save-dev @types/jest`.

> **Note!** Use flag `--save-dev` (or `-D`) in order to save `.d.ts` as dev dependencies. They are only used at compile time.

## Your Library isn't on DefinitelyTyped?

If library you are looking for isn't available on DefinitelyTyped then you will want to create your own `.d.ts` file.

Compiler look for type definition files in `node_modules/@types` by default. But we will want to help it find our own `.d.ts` files, in order to accomplish this we have to configure [path mapping](https://www.typescriptlang.org/docs/handbook/module-resolution.html#path-mapping) in our `tsconfig.json`.

Path mapping could get pretty confusing, but the basic idea is that the compiler will look in specific places, in a specific order when resolving modules, and we can tell the compiler exactly how to do it.

In the tsconfig.json for this project you'll see the following:

```json
"paths": {
  "*": [
    "node_modules/@types/*",
    "types/*"
  ]
},
```

This instruct TypeScript compiler to first look in `node_modules/@types` and then, when it doesn't find one, look on our own `.d.ts` files located on the folder `./types`.

### Using dts-gen

Unless you are familiar with `.d.ts` files, it is recommended to use a tool to generate `.d.ts` files for this libraries. [dts-gen](https://github.com/Microsoft/dts-gen) is a tool that generates TypeScript definition files (.d.ts) from any JavaScript object.

This trade-off comes with a price -- you'll see a lot of anys in function parameters and return types. You may also see properties that are not intended for public use. dts-gen is meant to be a starting point for writing a high-quality definition file.