# React Style Guide

## Table of Contents

  1. [Basic Rules](#basic-rules)
  1. [Folder Structure](#folder-structure)
  1. [Class vs `React.createClass` vs stateless](#class-vs-reactcreateclass-vs-stateless)
  1. [Mixins](#mixins)
  1. [Naming](#naming)
  1. [Import](#import)
  1. [Declaration](#declaration)
  1. [Alignment](#alignment)
  1. [Quotes](#quotes)
  1. [Spacing](#spacing)
  1. [Props](#props)
  1. [Refs](#refs)
  1. [Parentheses](#parentheses)
  1. [Tags](#tags)
  1. [Methods](#methods)
  1. [Ordering](#ordering)
  1. [`isMounted`](#ismounted)
  1. [HOCs](#hocs)
  1. [Typescript](#typescript)
  1. [React Query](#react-query)
  1. [Context](#context)

## Basic Rules

  - Only include one React component per file.
  - Always use JSX syntax.
  - Do not use `React.createElement` unless you're initializing the app from a file that is not JSX.
  - Always use export default for Components.
  - Use `export default` for reducers, actionCreators and services. As a general rule of thumb, use `export default` for all files that have a unique object to export.

## Folder Structure

```
src
├── assets // General app assets
│   └── logo.png
├── components
│   ├── App
│   │   ├── index.test.tsx
│   │   └── index.tsx
│   ├── MyComponent
│   │   ├── i18n.ts
│   │   ├── index.tsx
│   │   ├── styles.module.scss
│   │   └── types
│   │       └── myComponentProps.ts
│   ├── ProviderWrapper
│   │   └── index.tsx
│   ├── Spinner
│   │   ├── components
│   │   │   ├── constants.ts
│   │   │   └── loading.tsx
│   │   └── index.tsx
│   └── Suspense
│       └── index.tsx
├── config
│   ├── api.js
│   ├── context.test.ts
│   ├── context.ts
│   ├── i18n.js
│   └── routes.ts
├── constants
│   └── constants.ts
├── contexts
│   └── FooContext
│       ├── constants.ts
│       ├── index.test.ts
│       ├── index.ts
│       ├── reducer.test.ts
│       └── reducer.ts
├── hooks
│   ├── useMountedRef.test.ts
│   ├── useMountedRef.ts
│   ├── useRequest.test.tsx
│   └── useRequest.ts
├── mocks
│   ├── msw-server.ts
│   ├── msw-worker.ts
│   └── login.handlers.ts
├── screens
│   └── Home
│       ├── assets // Screen specific app assets
│       ├── components
│       ├── constants.js
│       ├── i18n.ts
│       ├── index.test.tsx
│       ├── index.tsx
│       └── styles.module.scss
├── scss
│   ├── application.scss
│   ├── components.scss
│   ├── layout.scss
│   ├── margins.scss
│   └── variables
│       ├── _colors.scss
│       └── _constants.scss
├── services
│   ├── MyService.test.ts
│   ├── MyService.ts
│   ├── LocalStorageService.ts
│   └── types
│       └── myServiceResponse.ts
├── types
│   └── myType.ts
└── utils
    ├── displayName.ts
    ├── inputValidations.js
    └── types.ts
```

## Class vs `React.createClass` vs stateless

  - Prefer normal function components (not arrow functions) over `class extends Component`. Only exception is usage of `componentDidCatch` and `getDerivedStateFromError` (which have no hooks support)

    ```jsx
    // bad
    class Listing extends Component {
      render() {
        return <div>{this.props.hello}</div>;
      }
    }

    // bad (relying on function name inference is discouraged)
    const Listing = ({ hello }) => (
      <div>{hello}</div>
    );

    // good
    function Listing({ hello }) {
      return <div>{hello}</div>;
    }
    ```

  - If you decide to use class component, prefer `class extends Component` over `React.createClass`. eslint: [`react/prefer-es6-class`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/prefer-es6-class.md) [`react/prefer-stateless-function`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/prefer-stateless-function.md)

    ```jsx
    // bad
    const Listing = React.createClass({
      // ...
      render() {
        return <div>{this.state.hello}</div>;
      }
    });

    // good
    class Listing extends Component {
      // ...
      render() {
        return <div>{this.state.hello}</div>;
      }
    }
    ```

  - Avoid using helper render methods when possible.

    ```jsx
    // bad
    function MyComponent extends Component {
      renderText = text => <span>text</span>;

      render() {
        return (
          <div>
            {this.renderText('aText')}
          </div>
        )
      }
    }

    // good
    function Text({ text }) {
      return <span>text</span>;
    }

    function MyComponent({ text }) {
      return (
        <div>
          <Text text={text} />
        </div>
      )
    }
    ```

## Mixins

  - [Do not use mixins](https://facebook.github.io/react/blog/2016/07/13/mixins-considered-harmful.html).

  > Why? Mixins introduce implicit dependencies, cause name clashes, and cause snowballing complexity. Most use cases for mixins can be accomplished in better ways via components, higher-order components, or utility modules.

## Naming

  - **Extensions**: Use `.js` extension for React components.
  - **Filename**: For component filenames and services use PascalCase. E.g., `ReservationCard/index.js`, `AuthService.js`.
  - **Reference Naming**: Use PascalCase for React components and camelCase for their associated elements. eslint: [`react/jsx-pascal-case`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-pascal-case.md)

    ```jsx
    // bad
    import reservationCard from './ReservationCard';

    // good
    import ReservationCard from './ReservationCard';

    // bad
    const ReservationItem = <ReservationCard />;

    // good
    const reservationItem = <ReservationCard />;
    ```
  - **Component Hierarchy**:
    - Component files should be inside folders that match the component's name.
    - Use index.js as the filename of a component.
    - If a component has its own child components, include a folder named components inside the parent component's folder.

    ```jsx
    // MyComponent/index.js
    function MyComponent() {
      return (
        // Some JSX
      )
    }
    ```

  - **Higher-order Component Naming**: Use a composite of the higher-order component's name and the passed-in component's name as the `displayName` on the generated component. For example, the higher-order component `withFoo()`, when passed a component `Bar` should produce a component with a `displayName` of `withFoo(Bar)`.

    > Why? A component's `displayName` may be used by developer tools or in error messages, and having a value that clearly expresses this relationship helps people understand what is happening.

    ```jsx
    // bad
    function withFoo(WrappedComponent) {
      return function WithFoo(props) {
        return <WrappedComponent {...props} foo />;
      }
    }

    export default withFoo;

    // good
    function withFoo(WrappedComponent) {
      function WithFoo(props) {
        return <WrappedComponent {...props} foo />;
      }

      const wrappedComponentName = WrappedComponent.displayName
        || WrappedComponent.name
        || 'Component';

      WithFoo.displayName = `withFoo(${wrappedComponentName})`;
      return WithFoo;
    }

    export default withFoo;
    ```

  - **Props Naming**: Avoid using DOM component prop names for different purposes.

    > Why? People expect props like `style` and `className` to mean one specific thing. Varying this API for a subset of your app makes the code less readable and less maintainable, and may cause bugs.

    ```jsx
    // bad
    <MyComponent style="fancy" />

    // bad
    <MyComponent className="fancy" />

    // good
    <MyComponent variant="fancy" />
    ```

## Import

  - Prefer wrapping the variables inside a file in an object and then import that object instead of using `import *`

    ```jsx
    // bad
    /* routes.js */
    const userListRoute = '/users';
    const itemListRoute = '/items';

    /* Another file */
    import * as Routes from './routes';

    // good
    /* routes.js */
    const Routes = {
      userListRoute: '/users',
      itemListRoute: '/items'
    }

    export default Routes;

    /* Another file */
    import Routes from './routes';

    ```

## Declaration

  - Do not use `displayName` for naming components. Instead, name the component by reference.

    ```jsx
    // bad
    export default React.createClass({
      displayName: 'ReservationCard',
      // stuff goes here
    });

    // good
    class ReservationCard extends Component {
      // stuff goes here
    }

    export default ReservationCard

    // better
    function ReservationCard() {
      return (
        // Some JSX
      )
    }

    export default ReservationCard
    ```

## Alignment

  - Follow these alignment styles for JSX syntax. eslint: [`react/jsx-closing-bracket-location`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-closing-bracket-location.md) [`react/jsx-closing-tag-location`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-closing-tag-location.md)

    ```jsx
    // bad
    <Foo superLongParam="bar"
         anotherSuperLongParam="baz" />

    // good
    <Foo
      superLongParam="bar"
      anotherSuperLongParam="baz"
    />

    // if props fit in one line then keep it on the same line
    <Foo bar="bar" />

    // children get indented normally
    <Foo
      superLongParam="bar"
      anotherSuperLongParam="baz"
    >
      <Quux />
    </Foo>
    ```

## Quotes

  - Always use double quotes (`"`) for JSX attributes, but single quotes (`'`) for all other JS. eslint: [`jsx-quotes`](https://eslint.org/docs/rules/jsx-quotes)

    > Why? Regular HTML attributes also typically use double quotes instead of single, so JSX attributes mirror this convention.

    ```jsx
    // bad
    <Foo bar='bar' />

    // good
    <Foo bar="bar" />

    // bad
    <Foo style={{ left: "20px" }} />

    // good
    <Foo style={{ left: '20px' }} />
    ```

## Spacing

  - Always include a single space in your self-closing tag. eslint: [`no-multi-spaces`](https://eslint.org/docs/rules/no-multi-spaces), [`react/jsx-tag-spacing`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-tag-spacing.md)

    ```jsx
    // bad
    <Foo/>

    // very bad
    <Foo                 />

    // bad
    <Foo
     />

    // good
    <Foo />
    ```

  - Do not pad JSX curly braces with spaces. eslint: [`react/jsx-curly-spacing`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-curly-spacing.md)

    ```jsx
    // bad
    <Foo bar={ baz } />

    // good
    <Foo bar={baz} />
    ```

## Props

  - Always use camelCase for prop names.

    ```jsx
    // bad
    <Foo
      UserName="hello"
      phone_number={12345678}
    />

    // good
    <Foo
      userName="hello"
      phoneNumber={12345678}
    />
    ```

  - Always use object destructuring to explicitly get props variables in Components:

    ```jsx
    // bad
    function MyComponent(props) {
      return <span>{this.props.foo}</span>;
    }

    // good
    function MyComponent({ foo }) {
      return <span>{foo}</span>;
    }
    ```

  - Omit the value of the prop when it is explicitly `true`. eslint: [`react/jsx-boolean-value`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-boolean-value.md)

    ```jsx
    // bad
    <Foo
      hidden={true}
    />

    // good
    <Foo
      hidden
    />

    // good
    <Foo hidden />
    ```

  - Explicitly `true` props should be passed last:

    ```jsx
    // bad
    <Foo
      hidden
      disabled
      aProp={aPropValue}
    />

    // good
    <Foo
      aPropValue={aPropValue}
      hidden
      disabled
    />
    ```

  - Avoid passing arrow functions in props when possible. Instead, create a reference to the function and pass that reference.

    > Why? Passing arrow functions as props in render creates a new function each time the component renders, which is less performant.

    ```jsx
    import OtherComponent from './otherComponent';

    // bad
    function MyComponent() {
      return <OtherComponent foo={bar => bar + 1} />;
    }

    // good
    function MyComponent() {
      const foo = bar => bar + 1;

      return <OtherComponent foo={foo} />;
    }
    ```


  - Always include an `alt` prop on `<img>` tags. If the image is presentational, `alt` can be an empty string or the `<img>` must have `role="presentation"`. eslint: [`jsx-a11y/alt-text`](https://github.com/evcohen/eslint-plugin-jsx-a11y/blob/master/docs/rules/alt-text.md)

    ```jsx
    // bad
    <img src="hello.jpg" />

    // good
    <img src="hello.jpg" alt="Me waving hello" />

    // good
    <img src="hello.jpg" alt="" />

    // good
    <img src="hello.jpg" role="presentation" />
    ```

  - Do not use words like "image", "photo", or "picture" in `<img>` `alt` props. eslint: [`jsx-a11y/img-redundant-alt`](https://github.com/evcohen/eslint-plugin-jsx-a11y/blob/master/docs/rules/img-redundant-alt.md)

    > Why? Screenreaders already announce `img` elements as images, so there is no need to include this information in the alt text.

    ```jsx
    // bad
    <img src="hello.jpg" alt="Picture of me waving hello" />

    // good
    <img src="hello.jpg" alt="Me waving hello" />
    ```

  - Use only valid, non-abstract [ARIA roles](https://www.w3.org/TR/wai-aria/roles#role_definitions). eslint: [`jsx-a11y/aria-role`](https://github.com/evcohen/eslint-plugin-jsx-a11y/blob/master/docs/rules/aria-role.md)

    ```jsx
    // bad - not an ARIA role
    <div role="datepicker" />

    // bad - abstract ARIA role
    <div role="range" />

    // good
    <div role="button" />
    ```

  - Do not use `accessKey` on elements. eslint: [`jsx-a11y/no-access-key`](https://github.com/evcohen/eslint-plugin-jsx-a11y/blob/master/docs/rules/no-access-key.md)

  > Why? Inconsistencies between keyboard shortcuts and keyboard commands used by people using screenreaders and keyboards complicate accessibility.

  ```jsx
  // bad
  <div accessKey="h" />

  // good
  <div />
  ```

  - Avoid using an array index as `key` prop when possible, prefer a unique ID. ([why?](https://medium.com/@robinpokorny/index-as-a-key-is-an-anti-pattern-e0349aece318))

  ```jsx
  // bad
  {todos.map((todo, index) =>
    <Todo
      {...todo}
      key={index}
    />
  )}

  // good
  {todos.map(todo => (
    <Todo
      {...todo}
      key={todo.id}
    />
  ))}
  ```

  - Always define explicit defaultProps for all undefined props.

  > Why? propTypes are a form of documentation, and providing defaultProps means the reader of your code doesn’t have to assume as much. In addition, it can mean that your code can omit certain type checks.

  ```jsx
  // bad
  function SFC({ foo, bar, children }) {
    return <div>{foo}{bar}{children}</div>;
  }
  SFC.propTypes = {
    foo: PropTypes.number.isRequired,
    bar: PropTypes.string,
    children: PropTypes.node,
  };

  // good
  function SFC({ foo, bar, children }) {
    return <div>{foo}{bar}{children}</div>;
  }
  SFC.propTypes = {
    foo: PropTypes.number.isRequired,
    bar: PropTypes.string,
    children: PropTypes.node,
  };
  SFC.defaultProps = {
    bar: '',
    children: null,
  };
  ```

  - Avoid spreading props.
  > Why? Otherwise you're more likely to pass unnecessary props down to components. And for React v15.6.1 and older, you could [pass invalid HTML attributes to the DOM](https://reactjs.org/blog/2017/09/08/dom-attributes-in-react-16.html).

  Exceptions:

  - HOCs that proxy down props and hoist propTypes

  ```jsx
  function HOC(WrappedComponent) {
    function Proxy(props) {
      return <WrappedComponent {...props} />
    }

    Proxy.propTypes = {
      text: PropTypes.string,
      isLoading: PropTypes.bool
    };

    return Proxy;
  }
  ```

  - Base smart components like Input, Button, etc. if it's clear that they will want to pass all its props:

  ```jsx
  function Button(props) {
    // do something smart

    return <button {...props} />;
  }
  ```

  - Spreading objects with known, explicit props. This can be particularly useful when testing React components with Mocha's beforeEach construct.

  ```jsx
  function Foo {
    const props = {
      text: '',
      isPublished: false
    }

    return <div {...props} />;
  }

  export default Foo;
  ```

  Notes for use:
  Filter out unnecessary props when possible. Also, use [prop-types-exact](https://www.npmjs.com/package/prop-types-exact) to help prevent bugs.

  ```jsx
  // good
  function Component(props) {
    const { irrelevantProp, ...relevantProps } = props;
    return <WrappedComponent {...relevantProps} />
  }

  // bad
  function Component(props) {
    return <WrappedComponent {...props} />
  }
  ```

## Refs

  - Always use ref callbacks. eslint: [`react/no-string-refs`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/no-string-refs.md)

    > Note: Only use refs for class components. Reasons in React docs: https://reactjs.org/docs/refs-and-the-dom.html#refs-and-functional-components

    ```jsx
    // bad
    <Foo
      ref="myRef"
    />

    // good
    setRef = ref => this.myRef = ref;

    <Foo
      ref={this.setRef}
    />

    // better
    this.setRef = createRef(); // This is put in the constructor

    <Foo
      ref={this.setRef}
    />

    ```
  - At present we use the "useRef" hook
    > Note: useRef is not only useful for save a DOM reference, you can also hold a plain JavaScript Object: https://es.reactjs.org/docs/hooks-reference.html#useref.
    > You need to review how [Refs and functional components](https://reactjs.org/docs/refs-and-the-dom.html#refs-and-function-components) work

    ```jsx
    const ref = useRef();
    <Foo
      ref={ref}
    />
    ```
  - Another useful hook to handle `refs` is named `useImperativeHandle`. This is useful when you don't have other way to handle the state of a component. The purpose of this is when you try to handle a component through a parent component. This offers an "api" to handle the state of the component from a unique "source of truth". It's advisable to learn how to use `forwardRef` because they work together.
    https://es.reactjs.org/docs/hooks-reference.html#useimperativehandle
    > Paraphrasing to React: This hook is useful because there should be a single “source of truth” for any data that changes in a React application.

    ```jsx

    // very bad
    const Input = (props) => {
      return <input ref={props.myRef} />
    }

    export const Comp = () =>{
      const ref = useRef()
      return <Input myRef={ref} />
    }

    // good
    const Input = forwardRef((props, ref) => {
      return <input ref={ref} />
    })

    export const Comp = () =>{
      const ref = useRef()
      return <Input ref={ref} />
    }

    // very good
    const Input = forwardRef((props, ref) => {
      const myRef = useRef()
      useImperativeHandle(ref, () => {
        return {
          fn: () => {
            // Do something
          }
        }
      })
      return <input ref={myRef} />
    });

    export const Comp = () =>{
      const ref = useRef()
      return <Input ref={ref} />
    }


    ```
## Parentheses

  - Wrap JSX tags in parentheses when they span more than one line. eslint: [`react/jsx-wrap-multilines`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-wrap-multilines.md)

    ```jsx
    // bad
    function Comp() {
      return <MyComponent variant="long body" foo="bar">
               <MyChild />
             </MyComponent>;
    }

    // good
    function Comp() {
      return (
        <MyComponent variant="long body" foo="bar">
          <MyChild />
        </MyComponent>
      );
    }

    // good, when single line
    function Comp() {
      const body = <div>hello</div>;
      return <MyComponent>{body}</MyComponent>;
    }
    ```

## Tags

  - Always self-close tags that have no children. eslint: [`react/self-closing-comp`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/self-closing-comp.md)

    ```jsx
    // bad
    <Foo variant="stuff"></Foo>

    // good
    <Foo variant="stuff" />
    ```

  - If your component has multi-line properties, close its tag on a new line. eslint: [`react/jsx-closing-bracket-location`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-closing-bracket-location.md)

    ```jsx
    // bad
    <Foo
      bar="bar"
      baz="baz" />

    // good
    <Foo
      bar="bar"
      baz="baz"
    />
    ```

## Methods

  - Implement all methods in classes as arrow functions, except for lifecycle methods.

    > Why? Lifecycle methods should be class functions, not instance functions.

    ```jsx
    // bad
    class MyComponent extends Component {
      componentDidMount = () => {
        // do something
      }

      foo() {
        // do something else
      }
    }

    // good
    class MyComponent extends Component {
      componentDidMount() {
        // do something
      }

      foo = () => {
        // do something else
      }
    }
    ```

  - Avoid using `bind` in class Components. You can instead use arrow functions. If for some reason you must do so, bind event handlers for the render method in the constructor. eslint: [`react/jsx-no-bind`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-no-bind.md)

    > Why? A bind call in the render path creates a brand new function on every single render.

    ```jsx
    // bad
    class extends Component {
      onClickDiv() {
        // do stuff
      }

      render() {
        return <div onClick={this.onClickDiv.bind(this)} />;
      }
    }

    // not that bad
    class extends Component {
      constructor(props) {
        super(props);

        this.onClickDiv = this.onClickDiv.bind(this);
      }

      onClickDiv() {
        // do stuff
      }

      render() {
        return <div onClick={this.onClickDiv} />;
      }
    }

    // good
    class extends Component {
      // No binding needed. onClickDiv has reference to `this` because it's an arrow function.

      onClickDiv = () => {
        // do stuff
      }

      render() {
        return <div onClick={this.onClickDiv} />;
      }
    }
    ```

  - Do not use underscore prefix for internal methods of a React component.
    > Why? Underscore prefixes are sometimes used as a convention in other languages to denote privacy. But, unlike those languages, there is no native support for privacy in JavaScript, everything is public. Regardless of your intentions, adding underscore prefixes to your properties does not actually make them private, and any property (underscore-prefixed or not) should be treated as being public. See issues [#1024](https://github.com/airbnb/javascript/issues/1024), and [#490](https://github.com/airbnb/javascript/issues/490) for a more in-depth discussion.

    ```jsx
    // bad
    function Comp() {
      const _onClickSubmit = () => {
        // do stuff
      }

      // other stuff
    }

    // good
    function Comp() {
      const onClickSubmit = () => {
        // do stuff
      }

      // other stuff
    }
    ```

  - Be sure to return a value in your `render` methods. eslint: [`react/require-render-return`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/require-render-return.md)

    ```jsx
    // bad
    render() {
      (<div />);
    }

    // good
    render() {
      return (<div />);
    }
    ```

## Ordering

  - Ordering for `class extends Component`:

  1. optional `static` methods
  1. `constructor`
  1. `getChildContext`
  1. `componentWillMount`
  1. `componentDidMount`
  1. `componentWillReceiveProps`
  1. `shouldComponentUpdate`
  1. `componentWillUpdate`
  1. `componentDidUpdate`
  1. `componentWillUnmount`
  1. `componentDidCatch`
  1. *clickHandlers or eventHandlers* like `onClickSubmit()` or `onChangeDescription()`
  1. *getter methods for `render`* like `getSelectReason()` or `getFooterContent()`
  1. *optional render methods* like `renderNavigation()` or `renderProfilePicture()`
  1. `render`
  1. prop types
  1. default props
  1. mapStateToProps (if using Redux)
  1. mapDispatchToProps (if using Redux)
  1. export default MyComponent

  - How to define `propTypes`, `defaultProps`, `contextTypes`, etc...

    ```jsx
    import React from 'react';
    import PropTypes from 'prop-types';

    class Link extends Component {
      static methodsAreOk() {
        return true;
      }

      render() {
        const { url, id, text } = this.props;
        return <a href={url} data-id={id}>{text}</a>;
      }
    }

    Link.propTypes = {
      id: PropTypes.number.isRequired,
      url: PropTypes.string.isRequired,
      text: PropTypes.string,
    };

    Link.defaultProps = {
      text: 'Hello World',
    };

    export default Link;
    ```

## `isMounted`

  - Do not use `isMounted`. eslint: [`react/no-is-mounted`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/no-is-mounted.md)

  > Why? [`isMounted` is an anti-pattern][anti-pattern], is not available when using ES6 classes, and is on its way to being officially deprecated.

  [anti-pattern]: https://facebook.github.io/react/blog/2015/12/16/ismounted-antipattern.html

## HOCs

  If the HOC you are creating requires some sort of configuration or extra parameters, don't pass them with the wrapped component. Make a function that receives the configuration and returns a HOC. You can then pass the wrapped component to that HOC.
  ```jsx
  //good HOC without configuration
  function withSomethingExtra(WrappedComponent){ }
  //good HOC with configuration
  function withSomethingExtra(config1, config2)(WrappedComponent){ }
  ```
  ```jsx
  //bad HOC
  function withSomethingExtra(WrappedComponent, config1, config2){ }
  function withSomethingExtra({component: WrappedComponent, config1, config2}){ }
  ```

  This way, we know exactly how to use each HOC and we can compose them with other libraries like `recompose`'s `compose`
  ```js
  const composedHoc = compose(hoc1(config1), hoc2, hoc3(config3));
  const WrappedComponent = composedHoc(Component);
  ```

## Typescript

- Useful links
  - https://github.com/typescript-cheatsheets/react-typescript-cheatsheet
  - https://www.typescriptlang.org/docs/home.html

- File extensions
  - Use `.tsx` extension for React components.
  - Use `.ts` extension for files that don't need react elements

- Creating a functional component
  ```tsx
    interface Props {
      prop1: string; //required prop
      prop2?: number; //optional prop
    }

    function CardLink({ prop1, prop2 = 5 }: Props) {
      // ...
    }
  ```

- Event handling for functional component
  ```tsx
    import React, { Component, MouseEvent } from 'react';

    function Button({ children }) {

      const handleClick = (event: MouseEvent) => {
        // ...
      }

      return (
        <button onClick={handleClick}>
          {children}
        </button>
      )
    }
    export default Button;
  ```

- Creating a class component
  ```tsx
    interface Props {
      prop1: string; //required prop
      prop2?: number; //optional prop
    }

    interface State {
      stateProperty: boolean;
    }

    class Breadcrumb extends Component<Props, State> {
      // ...
    }
  ```

- Default props for class component
  ```tsx
    interface Props {
      prop1: string;
      prop2?: number;
    }

    class Breadcrumb extends Component<Props> {
      static defaultProps = {
        prop2: 5
      };

      // ...
    }
  ```

- Event handling for class component
  ```tsx
    import React, { Component, MouseEvent } from 'react';

    export class Button extends Component {

      handleClick(event: MouseEvent) {
        // ...
      }

      render() {
        return (
          <button onClick={this.handleClick}>
            {this.props.children}
          </button>
        )
      }
    }
  ```

- Typing for npm packages
  TypeScript requires type informations about the package's code. The package can support typescript out of the box if it has a file like: `index.d.ts`, if that is not the case you'll have to install the types yourself, for example:

  ``` node
  npm install lodash
  npm install @types/lodash
  ```

- Creating a HOC

  ```tsx
  interface WithLoadingOptions {
    classNameContainer?: string;
  }

  interface WithLoadingProps {
    loading: boolean;
  }

  export function withSpinner({ classNameContainer }: WithLoadingOptions = {}) {
    return <P extends object>(WrappedComponent: React.ComponentType<P>) => {
      function Spinner({ loading, ...props }: P & WithLoadingProps) {
        return loading ? (
          <div className={classNameContainer}>
            <Loading className={classNameLoading} type={typeLoading} color={colorSpinner} />
          </div>
        ) : (
          <WrappedComponent {...props as P} />
        );
      }

      return Spinner;
    };
  }
  ```

## React Query
### Introduction
React Query is a data-fetching library for React. It helps with fetching, caching, synchronizing and updating server state in our React Applications.
>For advanced information on React-Query, check [here](https://tkdodo.eu/blog/practical-react-query).
>Official Documentation, check [here](https://tanstack.com/query/v4/docs/overview?from=reactQueryV3&original=https://react-query-v3.tanstack.com/overview)
### `QueryClientProvider`
First of all, we will need to use the `QueryClientProvider` component to connect and provide a `QueryClient` for our app. You will be required to pass an instance of `QueryClient` to provide.
```tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'

const queryClient = new QueryClient()

function App() {
  return <QueryClientProvider client={queryClient}>...</QueryClientProvider>
}
```
>For more information, check [here](https://tanstack.com/query/v4/docs/reference/QueryClientProvider)

### `useQuery`
Use to subscribe to a query in your components or custom hooks, with at least:
- A unique query **key**, that is used internally for refetching, caching and sharing queries throughout the application.
```tsx
// ✅ Good --> TODOs List
 useQuery('todos', ...) // queryKey === ['todos']

// ✅✅ Better --> TODOs List
 useQuery(['todos'], ...) // queryKey === ['todos']

// One TODO
useQuery(['todo', 5], ...) // queryKey === ['todo', 5]

// Every TODOs with "done" type
 useQuery(['todos', { type: 'done' }], ...) // queryKey === ['todos', { type: 'done' }]

// It will trigger a refetch whenever the query key changes
useQuery(['todos', todoId], () => fetchTodoById(todoId))
```
- A function that returns a promise that:
    - Resolves the data, or
    - Throws an error
```tsx
useQuery(['todos', todoId], fetchTodoById)

useQuery(['todos', todoId], () => fetchTodoById(todoId))

useQuery(['todos', todoId], async () => {
 if (somethingGoesWrong) {
   throw new Error('Oh no!')
 }
 return data
 })
```

>Check full useQuery documentation [here](https://tanstack.com/query/v4/docs/reference/useQuery).

### Parallel Queries
Use to execute queries at the same time so as to maximize fetching concurrency.

**Manual Parallel Queries**

Use when the number of parallel queries does not change. Just use any number of `useQuery` or `useInfiniteQuery` hook side by side.
```tsx
function App () {
// The following queries will execute in parallel due to number of parallel
// queries does not change. useQuery calls must be side-by-side.
  const usersQuery = useQuery(['users'], fetchUsers)
  const teamsQuery = useQuery(['teams'], fetchTeams)
  const projectsQuery = useQuery(['projects'], fetchProjects)
  ...
}
```
>When using React Query in [suspense mode](https://tanstack.com/query/v4/docs/guides/suspense), this pattern of parallelism does not work due to the first query would suspend the component before the other queries run. To avoid this behavior, use `useQueries`.

**Dynamic Parallel Queries**

Use when the number of queries you need to execute is changing from render to render.
>You cannot use manual querying since that would violate the rules of hooks.
```tsx
// ❌ Bad
function App () {
  const userQueries = users.map(user => {
    return useQuery(['user', user.id], () => fetchUserBy(user.id))
  })
}

// ✅ Good
function App({ users }) {
  const userQueries = useQueries({
    queries: users.map(user => {
      return {
        queryKey: ['user', user.id],
        queryFn: () => fetchUserById(user.id),
      }
    })
  })
}
```
>Check full useQueries documentation [here](https://tanstack.com/query/v4/docs/reference/useQueries).

### Data Transformation
Use the built-in **selectors** solution provided by React-Query. Take into account:
- Selector will only be called if data exists.
- Selectors will run on every render, because the functional identity changes. Memoize it either with useCallback, or by extracting it to a stable function reference.
- Selector can also be used to subscribe to **only** parts of the data.
```tsx
// ✅ Good
export const useTodosQuery = () =>
  useQuery(['todos'], fetchTodos, {
    select: (data) => data.map((todo) => todo.name.toUpperCase()),
  })

// ✅ ✅ Better
const transformTodoNames = (data: Todos) =>
  data.map((todo) => todo.name.toUpperCase())

export const useTodosQuery = () =>
  useQuery(['todos'], fetchTodos, {
    // ✅ uses a stable function reference
    select: transformTodoNames,
  })

export const useTodosQuery = () =>
  useQuery(['todos'], fetchTodos, {
    // ✅ memoizes with useCallback
    select: React.useCallback(
      (data: Todos) => data.map((todo) => todo.name.toUpperCase()),
      []
    ),
  })


// ✅ Partial Subscriptions
export const useTodosQuery = (select) =>
  useQuery(['todos'], fetchTodos, { select })

export const useTodosCount = () => useTodosQuery((data) => data.length)
export const useTodo = (id) =>
  useTodosQuery((data) => data.find((todo) => todo.id === id))
```

### `useMutation`
Use to create/update/delete data or perform server side-effects. Mutations don’t run instantly, React Query gives us a function to invoke whenever we want to make the mutation.
The **mutate** function is asynchronous, which means that It cannot be used directly in an event callback. Wrap it in another function due to `React Event Pooling`.
For example:
```tsx
// ❌ This will not work in React 16 and earlier
const CreateTodo = (event) => {
  const mutation = useMutation(data => {
    event.preventDefault()
    const api = create();
    return api.post('/api', data)
  })

  return <form onSubmit={mutation.mutate}>...</form>
}

// ✅ This will work
const CreateTodo = () => {
  const mutation = useMutation(formData => {
    const api = create();
    return api.post('/api', data)
  })
  const onSubmit = (data, event) => {
    event.preventDefault()
    mutation.mutate(data)
  }

  return <form onSubmit={onSubmit}>...</form>
}
```
- If you want to apply some side-effects at any stage during the mutation lifecycle, you should use `useMutation` helper functions.
```tsx
useMutation(addTodo, {
  onMutate: variables => {
    // Trigger when a mutation is about to happen.

    // Optionally return a context containing data to use when for example rolling back
    return { id: 1 }
  },
  onError: (error, variables, context) => {
    // Trigger when an error happened.
    console.log(`rolling back optimistic update with id ${context.id}`)
  },
  onSuccess: (data, variables, context) => {
    // Trigger when there is returning data.
  },
  onSettled: (data, error, variables, context) => {
    // Trigger when error or success exists.
  },
})
```
>These come in handy for both [invalidating and refetching queries after mutations](https://tanstack.com/query/v4/docs/guides/invalidations-from-mutations) and even [optimistic updates](https://tanstack.com/query/v4/docs/guides/optimistic-updates).

- If you return a promise on any of the callback functions, it will be awaited before the next callback is called:
```tsx
useMutation(addTodo, {
  onSuccess: async () => {
    console.log("I'm first!")
  },
  onSettled: async () => {
    console.log("I'm second!")
  },
})
```
- If you need to send more than one variable to mutations, use an object.
```tsx
// ❌ this is invalid syntax and will NOT work
const mutation = useMutation((title, body) => updateTodo(title, body))
mutation.mutate('hello', 'world')

// ✅ use an object for multiple variables
const mutation = useMutation(({ title, body }) => updateTodo(title, body))
mutation.mutate({ title: 'hello', body: 'world' })
```
>Check full useMutation documentation [here](https://tanstack.com/query/v4/docs/reference/useMutation).

### Hooks Destructuring
Both `useQuery` and `useMutation` provide us with many functionalities to manage all kinds of states that we can destruct from their hooks, below we will explain how to obtain them and we will review the most important ones:
```tsx
const { isLoading, isError, error, isSuccess, data, status, fetchStatus } = useQuery(queryKey, queryFn?);
```
- **`isLoading`** or **`status === 'loading'`** - The query has no data yet.
- **`isError`** or **`status === 'error'`** - The query encountered an error. The error is available via the **`error`** property.
- **`isSuccess`** or **`status === 'success'`** - The query was successful and data is available. The data is available via the **`data`** property.
- **`fetchStatus`** exists because together with **`status`** allow all combinations on background refetches and stale-while-revalidate logic. It has the following options:
    - **`fetchStatus === 'fetching'`** - The query is currently fetching.
    - **`fetchStatus === 'paused'`** - The query wanted to fetch, but it is paused.
    - **`fetchStatus === 'idle'`** - The query is not doing anything at the moment.
>As a rule of thumb:
  >- The **`status`** gives information about the **`data`**: Do we have any or not?
  >- The **`fetchStatus`** gives information about the **`queryFn`**: Is it running or not?


## Context

### Introduction
Context provides a way to share values like these between components without having to explicitly pass a prop through every level of the tree.
>For advanced information on Context, check [here](https://tkdodo.eu/blog/practical-react-query).
>Official Documentation, check [here](https://reactjs.org/docs/context.html)

### `contextFactory`
First of all we have a HOC called ProviderWrapper that we are going to use in the base component of our context. This component receives a context, a reducer and an initial state which we should create inside another file, where we will have everything related to this, with the help of the `contextFactory` function located in `config/context.ts`.

```tsx
import { createContext, useContext, Dispatch } from 'react';

export const contextFactory = <State, Action>(initialState: State) => {
  interface Store {
    state: State;
    dispatch: Dispatch<Action>;
  }

  const Context = createContext<Store>({
    state: { ...initialState },
    // eslint-disable-next-line @typescript-eslint/no-empty-function, no-empty-function
    dispatch: () => {}
  });

  const useSelector = <T>(selector: (arg: State) => T) => {
    const { state } = useContext(Context);
    return selector(state);
  };

  const useDispatch = () => {
    const { dispatch } = useContext(Context);
    return dispatch;
  };

  // eslint-disable-next-line @typescript-eslint/naming-convention
  return { useSelector, Context, useDispatch };
};
```

### `Reducer`
In this instance, we have to type the "global" variables that we plan to use, set their initial state and based on this, the types of actions that would modify them. A typical example is the case of a counter, the variable type would be number, the initial state could be 0 and the action types could be INCREASE_COUNT, DECREASE_COUNT, RESET_COUNT. Below you will find the general structure that you can adapt to any type of situation:

```tsx
import { contextFactory } from '~config/context';

export interface State {
  foo: string;
}

export const INITIAL_STATE = {
  foo: ''
};

enum ActionTypes {
  SET_FOO = 'SET_FOO',
  RESET_FOO = 'RESET_FOO'
}

interface SetFoo {
  type: ActionTypes.SET_FOO;
  payload: string;
}

interface ResetFoo {
  type: ActionTypes.RESET_FOO;
}

export type Action = SetFoo | ResetFoo;

export const actionCreators = {
  setFoo: (foo: string): SetFoo => ({ type: ActionTypes.SET_FOO, payload: foo }),
  resetFoo: (): ResetFoo => ({ type: ActionTypes.RESET_FOO })
};

export const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case ActionTypes.SET_FOO: {
      return { ...state, foo: action.payload };
    }
    case ActionTypes.RESET_FOO: {
      return { ...state, foo: '' };
    }
    default: {
      return state;
    }
  }
};

export const { useSelector, Context, useDispatch } = contextFactory<State, Action>(INITIAL_STATE);
```

### `Base component`
As it is a HOC, we have to think very carefully according to the type of component tree that our project has, which is a "parent" component that contains all the "child" components that need to have access to these global variables.

- If we need the entire application to have access to these variables, then our base component could be the App component.
- If the application has many screens but these variables are only used in one of them, we could use the screen in question. as a base component, which could be Home, About, or any other.

```tsx
import { Context, reducer, INITIAL_STATE } from './reducer';

export default withProvider({ Context, reducer, initialState: INITIAL_STATE })(Home);
```

### `Child components`
With `useSelector` we can extract the variable that we need to use within the child component, while with `useDispatch` we can make the modifications that we contemplate within our reducer, this function requires as an argument the actionCreator that, depending on the type of action in question, can contain a payload or not.

```tsx
import {useSelector, useDispatch, actionCreators } from '~contexts/FooContext'

const foo = useSelector(state => state.foo);
const dispatch = useDispatch();
dispatch(actionCreators.setFoo('foo')); 
```

## Translation

  This JSX/React style guide is also available in other languages:

  - ![cn](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/China.png) **Chinese (Simplified)**: [JasonBoy/javascript](https://github.com/JasonBoy/javascript/tree/master/react)
  - ![tw](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Taiwan.png) **Chinese (Traditional)**: [jigsawye/javascript](https://github.com/jigsawye/javascript/tree/master/react)
  - ![es](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Spain.png) **Español**: [agrcrobles/javascript](https://github.com/agrcrobles/javascript/tree/master/react)
  - ![jp](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Japan.png) **Japanese**: [mitsuruog/javascript-style-guide](https://github.com/mitsuruog/javascript-style-guide/tree/master/react)
  - ![kr](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/South-Korea.png) **Korean**: [apple77y/javascript](https://github.com/apple77y/javascript/tree/master/react)
  - ![pl](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Poland.png) **Polish**: [pietraszekl/javascript](https://github.com/pietraszekl/javascript/tree/master/react)
  - ![Br](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Brazil.png) **Portuguese**: [ronal2do/javascript](https://github.com/ronal2do/airbnb-react-styleguide)
  - ![ru](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Russia.png) **Russian**: [leonidlebedev/javascript-airbnb](https://github.com/leonidlebedev/javascript-airbnb/tree/master/react)
  - ![th](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Thailand.png) **Thai**: [lvarayut/javascript-style-guide](https://github.com/lvarayut/javascript-style-guide/tree/master/react)
  - ![tr](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Turkey.png) **Turkish**: [alioguzhan/react-style-guide](https://github.com/alioguzhan/react-style-guide)
  - ![ua](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Ukraine.png) **Ukrainian**: [ivanzusko/javascript](https://github.com/ivanzusko/javascript/tree/master/react)

**[⬆ back to top](#table-of-contents)**
