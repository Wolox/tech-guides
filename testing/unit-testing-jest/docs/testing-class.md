## Testing a class
To test a class, we need to instance it with the dependencies. Then, we can call methods and add assertions, for example:

```ts
import { Injectable } from '@angular/core';
import { LoggerService } from './logger.service';
@Injectable({
  providedIn: 'root',
})
export class CalculatorService {
  constructor(private readonly logger: LoggerService) {}

  add(n1: number, n2: number) {
    this.logger.log('Addition operation called');
    return n1 + n2;
  }

  subtract(n1: number, n2: number) {
    console.log('Subtraction operation called');
    return n1 - n2;
  }
}
```

```ts
class FakeService {
  log() {}
}

describe('Calculator service', () => {
  it('should call addition function', () => {
    const service = new CalculatorService(fakeObj);
    const result = service.add(2, 3);
    expect(result).toBe(2 + 3);
  });
});
```
See more on [kavak-test-cap](https://github.com/CrisVega08/kavak-test-cap).
