# Basic structure of a test 

### Arrange, Act and Assert (AAA) Pattern:
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
