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
🏷  First use ```describe```to define the scope of the tests, this can contain one o more test, inside yo define the name of the class that you wanna test, next put a call back ```,() =>```

🌱 Now use ``it`` to define your test, inside describe the specific name of your test, and next put a call back ```,() =>```

🔍️️  The soul of your test is the ```assertion ```this is defined as ```expect()```follow of the variable that you want to improve.

🧪 All assertion is pair with a ```matcher``` with this you can evaluate the result of your variable, you can get all the matcher of Jest on this [link](https://jestjs.io/docs/using-matchers).
