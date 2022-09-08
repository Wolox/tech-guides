# Jest hooks

## Repeating setUp
You can use ```beforeEach()``` and/or ```afterEach()``` if you need to set or clear data for each test.

```beforeEach``` example:
```ts
    describe('UsersClass', () => {
        beforeEach(() => {
            initUsersDB();
        });
        
        it('should test1', () => {...})
    });
```
in this example the Users **DB** will be initialized before the execution of any test

****************

```afterEach``` example:
```ts
    describe('UsersClass', () => {
        afterEach(() => {
            clearUsersDB();
        });
        
        it('should test2', () => {...})
    });
```
in this example the Users **DB** will be cleared after the execution of any test.
 
## One time setUp
In case that you need to set data before or after of any test but this data will be same instance for all the test, you can use the ```beforeAll()``` and/or ```afterAll()```.

You can get more information of this Hooks on [JEST](https://jestjs.io/docs/setup-teardown#scoping).
