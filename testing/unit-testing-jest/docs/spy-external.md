# Spy external function
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

## Router
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
Sometimes we have private functions on our components, so to spy this functions you should:
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
````ts
it('should call the private function', () => {
    const spy = jest.spyOn(ExampleComponent.prototype as any, 'log');
    fixture.nativeElement.querySelector('.section').click();
    expect(fakeLogService.log).toHaveBeeCalledWith('test');
});
````
