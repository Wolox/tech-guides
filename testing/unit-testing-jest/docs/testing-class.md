## Testing a class
To test a class, we need to instance it with the dependencies. Then, we can call methods and add assertions, for example:

```ts

export class Calculator {
  constructor() { }
  
  add(n1: number, n2: number) {
    return n1 + n2;
  }

  subtract(n1: number, n2: number) {
    return n1 - n2;
  }
}
```

```ts

describe('Calculator Class', () => {
  it('Should add the two parameters.', () => {
    const calculator = new Calculator();
    const result = calculator.add(2, 3);
    expect(result).toBe(2 + 3);
  });
});
```
See more on [angular-testing-cap](https://github.com/CrisVega08/angular-testing-cap).
