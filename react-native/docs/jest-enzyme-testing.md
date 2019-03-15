# Testing with Jest and Enzyme

## Introduction

This guide will show you how to creat tests for React using Jest and Enzyme. Asuming you've used [React Bootstrap](http://www.github.com/wolox/react-bootstrap) the libraries will be already installed, so we'll go directly to the test creation.

## Where to create tests

The project file tree used at Wolox contains all of it's components under the `src/app/` path. For every JS file under this path, there should be a test file (there are some particular cases where we exclude some specific files because it's code is not relevant to test but in general you'll have this 1:1 relation).

To keep tests separated from the rest of the files we'll have a folder called `tests` next to the files and inside of it there will be files named `file_name.test.js` where `file_name` should be each file in the original folder.

For Example if we have this folder structure:

```
registration
|
|_ components
|  |_ registrationSteps
|  | |_ index.js
|  |
|  |_ step1
|  | |_ index.js
|  |
|  |_ step2
|    |_ index.js
|
|_ index.js
|_ layout.js
```

after adding the tests you'll have:

```
registration
|
|_ components
|  |_ registrationSteps
|  | |_ index.js
|  | |_ tests
|  |   |_index.test.js
|  |
|  |_ step1
|  | |_ index.js
|  | |_ tests
|  |   |_index.test.js
|  |
|  |_ step2
|    |_ index.js
|    |_ tests
|      |_index.test.js
|
|_ index.js
|_ layout.js
|_ tests
  |_ index.test.js
  |_ layout.test.js
```
## Writing tests

First of all we should import from Enzyme the way we want our component to be rendered, the most common way is to use `shallow` but other options can be `mount` or `render`. For more information on render options check [this](https://github.com/airbnb/enzyme#basic-usage) page. 

```js
import { shallow } from 'enzyme';
```

To organize the tests there are a lot of functions that can help you and can be found [here](http://facebook.github.io/jest/docs/en/api.html). 
The most common functions you'll use are:

- **describe**: it's used to group tests related to the same particular case, they can be nested to separate groups into even more specific groups.

- **it**: contains the specific functionality to be tested and an expectation of what the result should be.
The expectation is created using [this](https://facebook.github.io/jest/docs/en/expect.html) functions.

An example could be:

```jsx
import { shallow } from 'enzyme';
import { React } from 'enzyme';
import Carousel from '../';

describe('<Carousel />', () => {
  const renderedComponent = shallow(
    <Carousel
      photos={[{
        id: 1,
        url: 'url',
      }, {
        id: 2,
        url: 'url',
      },]}
      imagesToShow={1}
    />
  );

  describe('onPreviousPressed', () => {
    describe('when currentIndex is greater than 0', () => {
      it('decrements the currentIndex', () => {
        renderedComponent.setState({
          currentIndex: 1,
        });
        renderedComponent.instance().onPrevPressed();
        expect(renderedComponent.state('currentIndex')).toEqual(0);
      });
    });

    describe('when currentIndex equals 0', () => {
      it('does not decrement the currentIndex', () => {
        renderedComponent.setState({
          currentIndex: 0,
        });
        renderedComponent.instance().onPrevPressed();
        expect(renderedComponent.state('currentIndex')).toEqual(0);
      });
    });
  });

  ...
});

```

## More specific cases

Although what you've learned here applies for the most common test cases and you'll be able to create lot's of tests this way there are some more complex cases where you'll need to learn other stuff too. Some of them are:

- [test functions](http://facebook.github.io/jest/docs/en/mock-functions.html)
- [snapshot testing](https://medium.com/@luisvieira_gmr/snapshot-testing-react-components-with-jest-best-practices-dd1585b2b93d)
- [creating mocks for functions](http://facebook.github.io/jest/docs/en/manual-mocks.html)
- [async testing](http://facebook.github.io/jest/docs/en/timer-mocks.html)
- [API testing](https://github.com/ctimmerm/axios-mock-adapter)
