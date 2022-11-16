## Angular default test configuration
When you create a new component, directive, service, etc. The default configuration of the tests file should be something like this.

```ts
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ExampleComponent } from './example.component';

describe('ExampleComponent', () => {
  let component: ExampleComponent;
  let fixture: ComponentFixture<ExampleComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ExampleComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ExampleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

This is the default configuration of a test file. As you can see, it uses a lot of what we already got on the top theory. Now let's understand the TestBed.

### Understanding TestBed :test_tube:
[TestBed](https://angular.io/api/core/testing/TestBed) is a utility of Angular. With this, we can configure all the environments of our tests.

Configure a testing module
With this we can set all the dependencies for our tests, for example:
```ts
TestBed.configureTestingModule(
    {
        declarations: [ ExampleComponent, OtherComponents ... ],
        imports: [ PipesModule, RouterTestingModule, OtherModules... ],
        providers: [ ExampleService, DecimalPipe, OtherProviders... ],
    },
    schemas: [CUSTOM_ELEMENTS_SCHEMA],
);
```
As you can see, is equal to any angular module configuration

### Fixture and Component :statue_of_liberty: 
Usually, when we need to test the render of the application, we declare fixture to get access to the render HTML and component to get the control of our class.

### Init the fixture
```ts
fixture = TestBed.createComponent(ExampleComponent);
```
This creates a background render of our component and is stored on fixture.

### Init the component
```ts
component = fixture.componentInstance;
```
In component, we store an instance of the class. Now, we can access the properties and methods of our class.

### fixture.detectChanges()
Works like the OnPush detection strategy. With this function, we can update the render of our test, in case we need to use it.
Moreover, when working with tests on Angular you must tell the `TestBed` to perform data binding by calling `fixture.detectChanges()` in 
order to update the DOM with the expected information.

### But why?
According to Angular docs: 
> [Delayed change detection is intentional and useful. It gives the tester an opportunity to inspect and change the state of the component before Angular initiates data binding and calls lifecycle hooks.](https://angular.io/guide/testing-components-scenarios#detectchanges)
