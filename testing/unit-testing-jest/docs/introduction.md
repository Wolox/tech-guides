# Introduction
### General concept and benefits

Essentially, a unit test is a method that instantiates a small portion of our application and checks its behavior independently of other parts.

Testing is a method to check if the code is working as expected. Testing the code helps to detect bugs on time and prevent the appearance of new bugs in the future. Also, testing gives confidence to our code. We can expect that they don't find problems in QA tests.

* Fewer bugs in production
* Fewer code regressions
* More maintainable code
* Faster refactoring and upgrades
* Less dead code
* You can see more on this [article](https://jestjs.io/docs/using-matchers).


### Principles 

**Easy to write:**  It should be easy to code all of those test routines without enormous effort.

**Readable:** The intent of a unit test should be clear. A good unit test tells a story about some behavioral aspect of our application, so it should be easy to understand which scenario is being tested and — if the test fails — easy to detect how to address the problem. 

**Reliable:** Unit tests should fail only if there’s a bug in the system under test. Good unit tests should be reproducible and independent from external factors such as the environment or running order.

**Fast:** Developers write unit tests so they can repeatedly run them and check that no bugs have been introduced. Slow unit tests may also indicate that either the system under test, or the test itself, interacts with external systems, making it environment-dependent.

### Unit test structure (AAA pattern)
- Arrange: Initializes the objects and establishes the values of the data that we are going to use in the Test that contains it.
- Act: Makes the call to the method to be tested with the parameters prepared for this purpose.
- Assert: Checks that the executed test method behaves as we expected it to.

````ts
  🏷️ describe('Class, Module, Service or Component to test', () => {
    //test
    🌱️ it('should do ...', () => {
      // Arrange
      const service = new ServiceToTest();
      // Act
      const value = service.fn();
      // Assert
      🔍️️ expect(value)️.🧪toBe('expected value');
    });
  });
````
🏷  First use ```describe```to define the scope of the tests, this can contain one o more test, inside, define the name of the class that you wanna test, next put a call back ```,() =>```

🌱 Now use ``it`` to define your test, inside describe the specific name of your test, and next put a call back ```,() =>```

🔍️️  The soul of your test is the ```assertion ```, which is defined as ```expect()``` followed by the variable that you want to match.

🧪 Every assertion is paired with a ```matcher```. It allows you to evaluate the result of a variable. You can get all the matcher of Jest on this [link](https://jestjs.io/docs/using-matchers).
