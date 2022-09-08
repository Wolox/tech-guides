
# How to get elements from the DOM on testing
Check if an element render the correct information on the page is very important to test and more if we are frontend developers, so to test the elements you need to access to the elements and also call his events.

## Getting element
Consider the next element
test.html
```html
<button class="btn_login" (click)="login()">Login</button>
```

test.spect.ts
```ts
it('should call login function', () => {
    // as nativeElement
    const button = fixture.debugElement.nativeELement.querySelector('.btn_login');
    button.click();
    
    ...
    
    // as debugElement
    const button = fixture.debugElement.query(By.css('.btn_login'));
    button.triggerEventHandler('click', null);
    
});
```
You can see more about ```nativeElement vs debugElement``` on this [link](https://angular.io/guide/testing-components-basics), also note that in debugElemente we use the css class from ```By``` to use this you need to import from ```import { By } from '@angular/platform-browser';``` an you can see more info abput ```By``` on this [link](https://angular.io/api/platform-browser/By)

Consider the nexts elements
test.html
```html
<app-header-proccess
    [tabs]="data.tabs"
    (goTo)="goToPage($event)">
</app-header-proccess>

<h1 class="title">{{data.title}}</h1>

<ul>
    <li class="list-item-data" *ngFor="let items from data.list">
        <p class="item-title">{{item.title}}</p>
    </li>
</ul>
```
To get any of this elements we can use:
test.spec.ts
```ts
it('should render information', () => {
    // get component
    const header = fixture.debugElement.query(By.css('app-header-proccess'));
    header.triggerEventHandler('goTo', '/main');
    expect(goToPage).toHaveBeenCalledWith('/main');
    
    // get Texts elements
    const title = fixture.debugElement.query(By.css('.title'));
    expect(title.nativeElement.textContent).toBe('any text');
    
    // get Iterable Elements
    const liItems = fixture.debugElement.queryAll(By.css('.list-item-data'));
    expect(liItems.length).toBe(5);
    
});
```
