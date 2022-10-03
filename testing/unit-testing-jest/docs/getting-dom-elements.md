# How to get elements from the DOM on testing
In order to create the most complete tests in our applications, we should include not only the logic functions but the
DOM rendering as well. Therefore, we must know how to get access to the DOM elements in our test cases.
So, les's see how it works:

## Getting element
Consider the next element
<br>
test.html
```html
<button class="btn_login" (click)="login()">Login</button>
```

test.spec.ts
```ts
it('should call login function', () => {
    // as nativeElement
    const button = fixture.debugElement.nativeELement.querySelector('.btn_login');
    button.click();
    
    ...
    
    // as debugElement
    const button = fixture.debugElement.query(By.css('.btn_login'));
    button.triggerEventHandler('click', {});    
});
```

When using `triggerEventHandler` note that the second parameter is the actual event object that will pass to the handler.

You can see more about ```nativeElement vs debugElement``` on this [link](https://angular.io/guide/testing-components-basics), also note that in debugElement we use the css class from ```By``` to use this you need to import from ```import { By } from '@angular/platform-browser';``` an you can see more info about ```By``` on this [link](https://angular.io/api/platform-browser/By)

Consider the next elements
test.html
```html
<app-header-process
    [tabs]="data.tabs"
    (goTo)="goToPage($event)">
</app-header-process>

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
    const header = fixture.debugElement.query(By.css('app-header-process'));
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
