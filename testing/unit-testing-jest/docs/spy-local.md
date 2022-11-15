# How to spy functions calls
When we are testing we can spy the call of an specific function, the function to spy can be of the same component or another external dependency.

## Spy local function
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
  log(message: string): void {
    console.log(message); 
  }
}
````

Test
````ts
describe('ExampleComponent', () => {
  let component: ExampleComponent;
  let fixture: ComponentFixture<ExampleComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ ExampleComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ExampleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('Should call log function when div is clicked', () => {
    const spy = jest.spyOn(component, 'log');
    fixture.nativeElement.querySelector('.section').click();
    expect(spy).toHaveBeeCalledWith('test');
  });
});
````
