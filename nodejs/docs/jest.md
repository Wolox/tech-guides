# Getting started with Jest 🃏

## What is Jest?

Jest is an open-source Javascript Testing Framework created by Facebook. **It has a task runner, assertion library, and good mocking support**.

It allows you to write tests with an approachable, familiar and feature-rich API that gives you results quickly. Jest is well-documented and requires little configuration.

## Why Jest?

- 🤖 **All-in-one tool:** Jest comes with built-in matchers, spies, and its own extensive mocking library.
- 🤟 **Zero config:** Jest aims to work out of the box, config free, on most JavaScript projects.
- 🤯 **Easy to use:** Jest has the entire toolkit in one place, well documented and well maintained.
- ⚙️ **Isolated:** Tests are parallelized by running them in their own processes to maximize performance.

## Working with Jest

### Implementation

To implement Jest in your project, simply follow the instructions indicated in its documentation: [Jest - Getting Stated](https://jestjs.io/docs/en/getting-started).

### Assertions

When you're writing tests, you often need to check that values meet certain conditions. `expect` gives you access to a number of "matchers" that let you validate different things.

For example:

```js
test('Maths work', () => {
  expect(2 + 2).toBe(4);
});
```

Full list of basic Jest matchers is available here: [Jest Docs - Expect](https://jestjs.io/docs/en/expect). For additional Jest matchers maintained you can check out [jest-extended](https://github.com/jest-community/jest-extended).

#### Extend Jest matchers

You can create your own test matchers using [expect.extend](https://jestjs.io/docs/en/expect#expectextendmatchers). For example:

```js
expect.extend({
  toBeVowel(char) {
    return /[aeiou]/i.test(char);
});

test('vowel check', () => {
  expect('a').toBeVowel();
  expect('p').not.toBeVowel();
});
```

### Mocking

Mocking allows you to replace dependencies for custom code. When we have methods that make external calls (API calls or accessing any remote resource), we isolate test subjects by providing fake data. **The goal for mocking is to replace something we don’t control with something we do.**

The Mock Function provides features to:

- Capture calls
- Set return values
- Change the implementation

The way to create a Mock Function instance is with `jest.fn()`. You can find more information about mocking in Jest docs: [Jest - Mock functions](https://jestjs.io/docs/en/mock-functions.html).

#### Hoisting

Jest will automatically hoist `jest.mock` calls to the top of the module ([hoisting](https://developer.mozilla.org/en-US/docs/Glossary/Hoisting)). Since calls to `jest.mock()` are hoisted to the top of the file, it's not possible to first define a variable and then use it. An exception is made for variables that start with the word _'mock'_.

If you are testing a file that returns a function then the order of execution from within the test file would be:

1. Load Jest mocks.
2. Load import modules.
3. Replace test subject by the Jest mock and instantiate it.
4. Declare variable `mockFunction`.
6. Call test using instantiated test subject.

As you can see at the time the mock is used within the test subject the `mockFunction` has not been declared, it is `undefined`. However, if the test subject is a class, this becomes:

1. Load Jest mocks.
2. Load import modules.
3. Replace test subject by the Jest mock.
4. Declare variable `mockFunction`.
5. Instantiate test subject inside test.
6. Call test using instantiated test subject.

As this happens after `mockFunction` is declared then the class instance has access to its value. The difference here is the instantiation.

### Code coverage

It's important to mention that test coverage does not define your tests quality but it just is a measure used to describe the degree to which the source code of a program is executed when a particular test suite runs.

Jest has built-in coverage reports,  to generate a coverage by passing `--coverage` to the Jest script.

#### Coverage Threshold

This will be used to configure minimum threshold enforcement for coverage results, making your tests fail if they do not meet the defined limits. In the following link you can find more ingormation about this config: [Jest Docs - coverageThreshold](https://jestjs.io/docs/en/configuration.html#coveragethreshold-object).  

### Watcher

Jest can run in **[watch mode](https://jestjs.io/docs/en/cli#watch)**, where it runs the tests automatically whenever you change the code. You run it with the `--watchAll` command-line argument, and it will monitor your application for changes. I ran jest in watch mode and introduced a bug on purpose to palindrome.js, and here is the result:

## Resources

### Docs

- [Jest Docs - Getting started](https://jestjs.io/docs/en/getting-started).
- [Jest Docs - Configuration](https://jestjs.io/docs/en/configuration).
- [Jest Docs - Expect](https://jestjs.io/docs/en/expect).
- [Jest Docs - Watch](https://jestjs.io/docs/en/cli#watch).
- [Jest Docs - API](https://jestjs.io/docs/en/api).
- [Jest Docs - coverageThreshold](https://jestjs.io/docs/en/configuration.html#coveragethreshold-object).
- [jest-extended](https://github.com/jest-community/jest-extended)

### Recommended posts

- [Mocking ES and CommonJS modules with jest.mock()](https://medium.com/codeclan/mocking-es-and-commonjs-modules-with-jest-mock-37bbb552da43).
- [Understanding Jest Mocks](https://medium.com/@rickhanlonii/understanding-jest-mocks-f0046c68e53c)
- [Jest cheatsheet](https://github.com/sapegin/jest-cheat-sheet)
