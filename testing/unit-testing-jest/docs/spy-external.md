# Spy external function
An external function could be an custom helper function in our application, which lives in another file (module).
Therefore, our unit test shouldn't test external functionalities, but, at the same time we need to inject the external
dependency in order to make it works. 

So, what can we do?. Let's see the following example.

Component
````ts
@Component({
  selector: 'app-example',
  templateUrl: `
    <div class="section" (click)="log('test')">
        Click me
    </div>
  `
})
export class ExampleComponent {
  constructor(private logService: LogService){}

  log(message: string): void {
    this.logService.log(message); 
  }
}
````

As you can see, the `logService` is an external function injected in the constructor of this component.

Next, on the test file, let's create a `fakeLogService` in order to fake the external functionality.

Test
````ts
const fakeLogService = {
  log: jest.fn()
}

describe('ExampleComponent', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ExampleComponent],
      providers: [
        {
          provide: LogService,
          useValue: fakeLogService
        }
      ]
    });
  })
  
  it('should call log function', () => {
    fixture.nativeElement.querySelector('.section').click();
    expect(fakeLogService.log).toHaveBeeCalledWith('test');
  });
}
````

Finally, we need to provide the fake function on the `providers` array, then, we'll be allowed to
work with the fake function and not with the real function.



Now, let's review som external function from angular.
## Router
The `navigate` function is part of the `Router` module of angular. Therefore, in order to test
a navigate action, we need to fake the navigate functionality, like this:

You can spy the functions of the ``Router`` as follows:
Test
````ts
const fakeRouter = {
  navigate: jest.fn()
}

describe('ExampleComponent', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ExampleComponent],
      providers: [
        {
          provide: Router,
          useValue: fakeRouter
        }
      ]
    });
  });
  
  it('should redirect to page', () => {
    fixture.nativeElement.querySelector('.link').click();
    expect(fakeRouter.navigate).toHaveBeeCalledWith(['/page']);
  });
}
````

Note that we are only faking the `navigate` function in our `fakeRouter` object. Nevertheless, we could add
more functions to this object, like: 
-  navigateByUrl
-  serializeUrl
-  parseUrl
-  isActive
-  etc...

Review more Router function [here](https://angular.io/api/router/Router)

## ActivatedRouter
Many components has resolver files to get the data before to navigate to the view, and in the ```ngOnInit()``` is common to see something like this:
``` this.data = this.route.snapshot.data.resolved; ``` son we need the mock the resolver data on this way:

````ts
const fakeActivatedRouter = {
  snapshot: {
    data: {
      resolved: {
        // your resolved data here
      }
    }
  }
}

describe('ExampleComponent', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ExampleComponent],
      providers: [
        {
          provide: ActivatedRoute,
          useValue: fakeActivatedRouter
        }
      ]
    });
  });
}
````

## Private functions
Sometimes we have private functions on our components, and maybe we need to test the operations inside of a 
private function. However, we should be allowed to reach al high coverage metrics without directly testing
the private functions but testing the result states of the private functions operations.

However, in the case that you need to test an private function, you could do it like this:

Component
````ts
@Component({
  selector: 'app-example',
  templateUrl: `
    <div class="section" (click)="log('test')">
        Click me
    </div>
  `
})
export class ExampleComponent {
  constructor(private logService: LogService){}

  private log(message: string): void {
    this.logService.log(message); 
  }
}
````
Test


1. Using a typed spy (recommended):
````ts
it('should call the private function', () => {
  const spy = jest.spyOn<any, string>(component, 'log');
  fixture.nativeElement.querySelector('.section').click();
  expect(fakeLogService.log).toHaveBeeCalledWith('test');
});
````

2. Using an assertion function
````ts
it('should call the private function', () => {
  const spy = jest.spyOn(ExampleComponent.prototype as any, 'log');
  fixture.nativeElement.querySelector('.section').click();
  expect(fakeLogService.log).toHaveBeeCalledWith('test');
});
````

3. Using the ts-ignore flag:
````ts
it('should call the private function', () => {
  // @ts-ignore
  const spy = jest.spyOn(component, 'log');
  fixture.nativeElement.querySelector('.section').click();
  expect(fakeLogService.log).toHaveBeeCalledWith('test');
});
````
