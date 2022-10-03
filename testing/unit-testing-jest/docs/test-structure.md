# Basic structure of a test 
````ts
  🏷️ describe('Class, Module, Service or Component to test', () => {
    //test
    🌱️ it('should do ...', () => {
      // setup
      const service = new ServiceToTest();
      // assertion and matcher
      🔍️️ expect(service.fn)️.🧪toBe('expected value');
    });
  });
````
🏷  First use ```describe```to define the scope of the tests, this can contain one o more test, inside, define the name of the class that you wanna test, next put a call back ```,() =>```

🌱 Now use ``it`` to define your test, inside describe the specific name of your test, and next put a call back ```,() =>```

🔍️️  The soul of your test is the ```assertion ```, which is defined as ```expect()``` followed by the variable that you want to match.

🧪 Every assertion is paired with a ```matcher```. It allows you to evaluate the result of a variable. You can get all the matcher of Jest on this [link](https://jestjs.io/docs/using-matchers).
