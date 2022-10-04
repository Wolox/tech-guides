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
In this example the ```initUsersDB()``` function will be executed ***before*** each test case.

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
In this example the ```clearUsersDB()``` function will be executed ***after*** each test case.
 
## One time setUp
In case that you need to set data before or after of any test but this data will be same instance for all the test, you can use the ```beforeAll()``` and/or ```afterAll()```.

You can get more information of this Hooks on [JEST](https://jestjs.io/docs/setup-teardown#scoping).
