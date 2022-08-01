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

## Basic Rules

  - Only include one React component per file.
  - Always use JSX syntax.
  - Do not use `React.createElement`.
  - Always use export default for Components.
  - Use `export default` for reducers, actionCreators and services. As a general rule of thumb, use `export default` for all files that have a unique object to export. 

## Folder Structure

```
src  
│
└───app
│   │
│   └───components
│   |   └───FormInput
│   |   └───SearchBar
│   |   └───Table
│   |   └───etc
|   |
│   └───screens
│       └───MyScreenComponent
│           └───assets # Screen specific app assets
│           └───context
|             | index.ts
│             | actions.ts
│             | reducer.ts
│           └───components # Screen specific components
│           | constants.ts
│           | i18n.ts
│           | index.tsx
│           | styles.scss
│           | utils.ts
│
└───assets # General app assets
└───config
    | api.ts
    | i18n.ts
└───constants
└───types # Custom global TypeScript classes
└───contexts # Global contexts
│   └───Auth
│       | index.ts
|       | reducer.ts
|       | actions.ts
│   
└───scss
└───services
│   │ serializers.ts
│   └───Model
│        | ModelService.ts
│        | serializers.ts
│
└───utils
│   index.tsx
```

## Class vs `React.createClass` vs stateless

  - Avoid `React.createClass`. eslint: [`react/prefer-es6-class`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/prefer-es6-class.md) [`react/prefer-stateless-function`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/prefer-stateless-function.md)
  - Prefer normal functions (not arrow functions) over classes:

    ```jsx
    // bad
    const Listing = React.createClass({
      // ...
      render() {
        return <div>{this.state.hello}</div>;
      }
    });

    // good
    function Listing({ hello }) {
      return <div>{hello}</div>;
    }
    ```
  - Prefer normal function components (not arrow functions) over `class extends Component`. Only exception is usage of `componentDidCatch` and `getDerivedStateFromError` (which have no hooks support)

    ```jsx
    // bad
    class Listing extends Component {
      state = { foo: 1 };

      render() {
        return <div>{this.state.hello}</div>;
      }
    }

    // bad
    const Listing = ({ hello }) => {
      const [foo, setFoo] = useState(1);
      return <div>{hello}</div>;
    }

    // good
    function Listing({ hello }) {
      const [foo, setFoo] = useState(1);
      return <div>{hello}</div>;
    }
    ```

  - Avoid using helper render methods when possible. Functions that return JSX elements should probably be components themselves.

    ```jsx
    // bad
    function TextContainer({ text }) {
      renderText = text => <span>text</span>;

      return (
        <div>
          {this.renderText(text)}
        </div>
      )
    }

    // good
    function Text({ text }) {
      return <span>text</span>;
    }

    function TextContainer({ text }) {
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

  - **Extensions**: Use `.ts` extension for React components.
  - **Filename**: For services use PascalCase. E.g., `ReservationCard.ts` or a folder with the service name and `index.tsx` as filename. For React components, there must be a folder in PascalCase with its name and the component file should be `index.tsx`
  - **Reference Naming**: Use PascalCase for React components and camelCase for their associated elements. eslint: [`react/jsx-pascal-case`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-pascal-case.md)

    ```jsx
    // bad
    import myService from './MyService';
    import myComponent from './MyComponent/index.tsx';

    // good
    import MyService from './MyService'; # webpack infers index.tsx
    import MyComponent from './MyComponent'; # webpack infers index.tsx

    // bad
    const MyComponent = <MyComponent />;

    // good
    const myComponent = <MyComponent />;
    ```
  - **Component Hierarchy**: 
    - Component files should be inside folders that match the component's name.
    - Use index.tsx as the component filename.

    
    ```jsx
    // MyComponent/index.tsx

    function MyComponent() {
      // Do smart stuff

      return <MyComponent />
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
    /* routes.ts */
    const userListRoute = '/users';
    const itemListRoute = '/items';

    /* Another file */
    import * as Routes from './routes';

    // good
    /* routes.ts */
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
  - Always use object destructuring to explicitly get props variables in the render function of class Components:

    ```jsx
    import Child from './components/Child';

    // bad
    function MyComponent(props) {
      return <Child foo={props.foo} bar={props.bar} />
    }

    // good
    function MyComponent({ foo, bar }) {
      return <Child foo={foo} bar={bar} />
    }
    ```

  - Always use object destructuring to explicitly get props variables:

    ```jsx
    // bad
    function MyComponent(props) {
      return <span>{this.props.foo}</span>
    }

    // good
    function MyComponent({ foo }) {
      return <span>{foo}</span>
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

  - Only use inline arrow functions when the arrow function is simple
  - If the function is complex, define it as a const beforehand. If you are passing it to a child component. you may use `useCallback` for memoization as well.

    > Why? Passing arrow functions as props in render creates a new function each time the component renders, which is less performant.

    ```jsx
    // bad
    function MyComponent() {
      return <button onClick={event => {
        let baz = "Hello World";
        console.log(event.target.value + baz)
      }} />
    }

    // good
    function MyComponent() {
      const foo = event => {
        let baz = "Hello World";
        console.log(event.target.value + baz)
      };

      return <button onClick={foo} />
    }

    // better when passing it to a child component
    import Child from './components/Child';

    function MyComponent() {
      const foo = useCallback(event => {
        let baz = "Hello World";
        console.log(event.target.value + baz)
      }, []);

      return <Child onClick={foo} />
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
    return class Proxy extends Component {
      Proxy.propTypes = {
        text: PropTypes.string,
        isLoading: PropTypes.bool
      };

      render() {
        return <WrappedComponent {...this.props} />
      }
    }
  }
  ```

  - HTML element wrappers (Button, Input, Image, etc.)

  ```jsx
    function Input(props) { 
      return <input {...props} />
    }
  ```


## Refs

  - Always use ref [`useRef`](https://reactjs.org/docs/hooks-reference.html#useref) for function components and [`createRef`](https://reactjs.org/docs/refs-and-the-dom.html#creating-refs) for class components.


    ```jsx
    // bad
    <Foo ref="myRef" />

    // bad
    setRef = ref => this.myRef = ref;

    <Foo ref={this.setRef} />

    // good
    function Bar() {
      const myRef = useRef(null);
      return <Foo ref={myRef}/>
    }

    // good
    class Bar extends Component() {
      myRef = createRef();
      render() {
        return <Foo ref={myRef}/>
      }
    }
    
    ```

## Parentheses

  - Wrap JSX tags in parentheses when they span more than one line. eslint: [`react/jsx-wrap-multilines`](https://github.com/yannickcr/eslint-plugin-react/blob/master/docs/rules/jsx-wrap-multilines.md)

    ```jsx
    // bad
    return <MyComponent variant="long body" foo="bar">
             <MyChild />
           </MyComponent>;

    // good
    return (
      <MyComponent variant="long body" foo="bar">
        <MyChild />
      </MyComponent>
    );

    // good, when single line
    const body = <div>hello</div>;
    return <MyComponent>{body}</MyComponent>;
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

    }
    ```

  - Do not use underscore prefix for internal methods of a React component.
    > Why? Underscore prefixes are sometimes used as a convention in other languages to denote privacy. But, unlike those languages, there is no native support for privacy in JavaScript, everything is public. Regardless of your intentions, adding underscore prefixes to your properties does not actually make them private, and any property (underscore-prefixed or not) should be treated as being public. See issues [#1024](https://github.com/airbnb/javascript/issues/1024), and [#490](https://github.com/airbnb/javascript/issues/490) for a more in-depth discussion.

    ```jsx
    // bad
    class MyComponent extends Component {
      _onClickSubmit() {
        // do stuff
      },

      // other stuff
    };

    // good
    class MyComponent extends Component {
      onClickSubmit() {
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

  1. `getDerivedStateFromProps`
  1. `getDerivedStateFromError`
  1. optional `static` methods
  1. `constructor` # Although it shouldn't be necessary
  1. `componentDidMount`
  1. `shouldComponentUpdate`
  1. `componentDidUpdate`
  1. `getSnapshotBeforeUpdate`
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

  - How to define `propTypes` and `defaultProps`.

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

- Creating a functional component
  ```tsx
    interface Props {
      prop1: string; //required prop
      prop2?: number; //optional prop
    }

    function CardLink({ prop1, prop2 }: Props) {
      // ...
    }
  ```

- Default props
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

- Event handling
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
