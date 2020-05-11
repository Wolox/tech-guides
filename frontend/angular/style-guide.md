# Angular style guide

## Table Of Contents

 1. Single responsibility
 2. Witout directly touching DOM
 3. Application structure
 4. Observables
 5. Resolver by Screen
 6. Aliasing inputs and outputs
 7. Small templates and styles

## Single responsibility

Apply the [_single responsibility principle_  (SRP)](https://wikipedia.org/wiki/Single_responsibility_principle) to all components, services, and other elements. This helps make the app cleaner, easier to read and maintain.

**Avoid**
```ts
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule, Component, OnInit } from '@angular/core';

interface Office {
  id: number;
  name: string;
  location: string;
  country: string;
}

@Component({
  selector: 'wlx-root',
  template:
    `<pre>{{ offices | json }}</pre>`,
  styleUrls:  ['app/app.component.css']
})
class AppComponent implements OnInit {
  offices: Office[] = [];

  ngOnInit()  {
    getHeroes().then(offices =>  this.offices = offices);
  }
}

@NgModule({
  imports: [BrowserModule],
  declarations: [AppComponent],
  exports: [AppComponent],
  bootstrap: [AppComponent]
})

export  class  AppModule  {  }

platformBrowserDynamic().bootstrapModule(AppModule);

const OFFICES: Office[]  =  [
  {
    id: 1,
    name: 'Güemes',
    location: 'Güemes 4673 CP: 1425',
    country: 'Argentina'
  },
  {
    id: 2,
    name: 'Malabia',
    location: 'Malabia 1720 CP: 1414',
    country: 'Argentina'
  },
  {
    id: 3,
    name: 'Azurduy',
    location: 'Juana Azurduy 2440 CP: 1429',
    country: 'Argentina'
  },
  {
    id: 4,
    name: 'Medellin',
    location: 'Carrera 30 # 7AA - 207',
    country: 'Colombia'
  },
  {
    id: 5,
    name: 'Santiago', location: 'Pérez Valenzuela 1635, piso 10 CP: 7500028',
    country: 'Chile'
  },
  {
    id: 6,
    name: 'Ciudad de México',
    location: 'Eugenio Sue 316',
    country: 'México'
  },
];

function getHeroes(): Promise<Office[]>  {
  return  Promise.resolve(OFFICES);
}

```

**Try** define one eleemnt, such as a service or component, per file.

```ts
/* Module  -> app.module.ts */.
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

```

```ts
/* Interface -> app.interface.ts */
export interface Office {
  id: number;
  name: string;
  location: string;
  country: string;
}
```

```ts
/* Mock Data -> mock-data.ts */
import { Office } from './app.interface';

export const OFFICES: Office[] = [
  {
    id: 1,
    name: 'Güemes',
    location: 'Güemes 4673 CP: 1425',
    country: 'Argentina'
  },
  {
    id: 2,
    name: 'Malabia',
    location: 'Malabia 1720 CP: 1414',
    country: 'Argentina'
  },
  {
    id: 3,
    name: 'Azurduy',
    location: 'Juana Azurduy 2440 CP: 1429',
    country: 'Argentina'
  },
  {
    id: 4,
    name: 'Medellin',
    location: 'Carrera 30 # 7AA - 207',
    country: 'Colombia'
  },
  {
    id: 5,
    name: 'Santiago', location: 'Pérez Valenzuela 1635, piso 10 CP: 7500028',
    country: 'Chile'
  },
  {
    id: 6,
    name: 'Ciudad de México',
    location: 'Eugenio Sue 316',
    country: 'México'
  },
];
```

```ts
/* Service -> app.service.ts */
import { Injectable } from '@angular/core';

import { OFFICES } from './mock-data';

@Injectable()
export class AppService {
  getOffices() Promise<Office[]>  {
    return Promise.resolve(OFFICES);
  }
}
```
```ts
/* Component -> app.component.ts */
import { Component, OnInit } from '@angular/core';

import { Office } from './app.interface';
import { AppService } from './app.service';

@Component({
  selector: 'wlx-root',
  template: `<pre>{{ offices | json }}</pre>`,
  styleUrls: ['./app.component.scss'],
  providers: [AppService],
})
export class AppComponent implements OnInit {
  offices: Office[] = [];

  constructor(private appService: AppService) {}

  ngOnInit() {
    this.appService.getOffices().then((offices) => (this.offices = offices));
  }
}
```

## Witout directly touching DOM

You will be able to manipulate the elements of your app in Angular with the help of the Renderer2 class.

Permitting direct access to the DOM with ElementRef API can make your application more vulnerable to XSS attacks.

**Avoid** 

```ts
import { Directive, ElementRef, OnInit } from '@angular/core';

@Directive({
  selector: '[addCSSStyle]'
})
export class addCSSStyle implements OnInit {
  constructor(readonly el: ElementRef) {}

  ngOnInit() {
    this.el.nativeElement.style.color = 'blue';
  }
}
```

We suggest use renderer2 for:

- Creating and appending DOM elements: createElement, createText and appendChild.

```ts
import { Directive, Renderer2, ElementRef, OnInit } from '@angular/core';

@Directive({
  selector: '[addNewElement]'
})
export class NewNodeDirective implements OnInit {
  constructor(
    private renderer2: Renderer2,
    private elementRef: ElementRef
  ) { }

  ngOnInit() {
    const pNode = this.renderer2.createElement('p');
    const txtNode = this.renderer.createText('A new text node');
    this.renderer2.appendChild(pNode, txtNode);
    this.renderer2.appendChild(this.elementRef.nativeElement, pNode);
  }
}
```

- Dynamically setting and removing DOM attributes --> setAttribute and removeAttribute.

```ts
import { Directive, Renderer2, ElementRef, OnInit } from '@angular/core';

@Directive({
  selector: '[addAttribute]'
})

export class AddAttributeDirective implements OnInit {
  constructor(
    private renderer2: Renderer2,
    private elementRef: ElementRef
  ) { }
  ngOnInit() {
    this.renderer2.setAttribute(this.elementRef.nativeElement, 'aria-hidden', 'true');
  }
}s
```

- Dynamically adding and removing classes: addClass and removeClass.

```ts
import { Directive, Renderer2, ElementRef, OnInit } from '@angular/core';

@Directive({
  selector: '[applyCSSClass]'
})

export class ApplyClassDirective implements OnInit {
  constructor(
    private renderer2: Renderer2, 
    private elementRef: ElementRef
  ) { }

  ngOnInit() {
    this.renderer2.addClass(this.elementRef.nativeElement, 'myClass')
  }

```

- Dyncamically setting and removing CSS styles: setStyle and removeStyle.

```ts
import { Directive, Renderer2, ElementRef, OnInit } from '@angular/core';

@Directive({
   selector: '[addCSSStyle]'
})

export class AddCSSStyleDirective implements OnInit {
  constructor(
    private renderer2: Renderer2,
    private elementRef: ElementRef
  ) { }

  ngOnInit() {
    this.renderer2.setStyle(
      this.elementRef.nativeElement,
      'background-color',
      'black'
    );
  }
}
```

- setProperty for setting DOM properties like href of `<a>` elements

```ts
import { Directive, Renderer2, ElementRef, OnInit } from '@angular/core';

@Directive({
  selector: '[setHrefProperty]'
})

export class SetHrefDirective implements OnInit {
  constructor(
  private renderer2: Renderer2,
  private elementRef: ElementRef
  ) { }

  ngOnInit() {
    this.renderer2.setProperty(
      this.elementRef.nativeElement,
      'href',
      'https://wolox.com.ar'
    );
  }
}
```

## Application structure
 
We recommend an application structure similar to next folder tree
**Try:** 
  - Make locating code intuitive, simple and fast
  - Create a module and routing for each screen (for lazy routing)
  - Each general component must have a module
  - Do not repeat elements like interfaces, enumerations or functions if they are used more than once, include them in the helpers folder

```
├── app
│   ├── components
│   │   ├── generic-component 
│   │   │   ├── generic-component.component.html
│   │   │   ├── generic-component.component.scss
│   │   │   ├── generic-component.component.ts
│   │   │   ├── generic-component.component.spec
│   │   │   └── generic-component.module.ts
│   │   ├── other-component
│   │   │   ├── other-component.component.html
│   │   │   ├── other-component.component.scss
│   │   │   ├── other-component.component.ts
│   │   │   ├── other-component.component.spec
│   │   │   └── other-component.module.ts
│   ├── helpers
│   │   ├── classes
│   │   ├── directives
│   │   ├── enums
│   │   ├── guards
│   │   ├── pipes
│   │   └── utilities
│   ├── interfaces
│   │   └── global.interface.ts
│   ├── screens 
│   │   └── Home
│   │       ├── components 
│   │       │   └── generic-component 
│   │       │       ├── generic-component.component.html
│   │       │       ├── generic-component.component.scss
│   │       │       ├── generic-component.component.ts
│   │       │       ├── generic-component.component.spec.ts
│   │       │       └── generic-component.module.ts
│   │       ├── interfaces 
│   │       │   └── specific.interface.ts
│   │       ├── home.component.html
│   │       ├── home.component.scss
│   │       ├── home.component.spec.ts
│   │       ├── home.component.ts
│   │       ├── home-routing.module.ts
│   │       └── home.module.ts
│   └── services
│       ├── api.service.ts
│       └── local-store.service.ts
├── app-routing.module.ts
├── app.component.html
├── app.component.scss
├── app.component.spec.ts
├── app.component.ts
├── assets
├── config
├── environments
└── styles 
    ├── global.sccs
    └── base
        ├── buttons.sccs
        └── forms.sccs
```

### Module and Routing by screen

A screen can contain some specific sections and components, so try to create module and routing.module by screen. Also remember in Angular the main concept is module.

Module for Home screen, this is very important for [loazy loading](https://angular.io/guide/lazy-loading-ngmodules) and [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)

```ts
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeComponent } from './home.component';
import { HomeRoutingModule } from './home-routing.module';

@NgModule({
  declarations: [ HomeComponent ],
  imports: [
    CommonModule,
    HomeRoutingModule
  ]
})
export class HomeModule {}
```

Routing module for Home screen
```ts
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from './home.component';
import { ResolverService } from './services/resolver.service'
const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    children: [
      {
        path: '**',
        redirectTo: ''
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }

```
## Observables

1. Try using finite observables (take, first, etc ...) you don't need unsubscribe them.
2. When use infinite observalbles to unsubscribe use the [takeUntil(this.ngUnsubscribe)](https://medium.com/@berrow/angular-rxjs-unsubscribe-from-observables-729e1f3c5559) pattern.
3. When using an api that returns Promises, convert them to observables first, using the [from](learnrxjs.io/learn-rxjs/operators/creation/from) operator.
4. Some nice [practices](https://medium.com/angular-in-depth/rx-js-best-practices-6a3b095ffb04) with **RxJS**


## Resolver by Screen

When you need call multiples endpoint for and screen

**Avoid** calling these endpoints from component

```ts
ngOnInit() {
  this.getOffices();
  this.getWoloxers();
  this.getDepartments();
  this.getTechs();
}

// call service and assign this.offices
private getOffices() {
  this.http.get(this.endpoints.office)
    .subscribe((data: Office[]) => this.offices = data);
}

// call service and assign this.woloxer
private getWoloxers() {
  this.http.get(this.endpoints.office)
    .subscribe((data: Woloxer[]) => this.woloxers = data);
}

// call service and assign this.departments
private getDepartments() {
  this.http.get(this.endpoints.office)
    .subscribe((data: Department[]) => this.departments = data);
}

// call service and assign this.techs
private getTechs() {
  this.http.get(this.endpoints.office)
    .subscribe((data: Tech[]) => this.techs = data);
}
```

**Try** using a resolver.

```ts
// resolver.service
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Resolve } from '@angular/router';
import { Observable, combineLatest } from 'rxjs';
import { map, take } from 'rxjs/operators';

import { endpoints } from '@environments/endpoints';

@Injectable()
export class ResolverService implements Resolve<any> {

  constructor(readonly http: HttpClient) {}

  resolve(): Observable<any> {
    const data = [
      this.http.get(endpoints.offices),
      this.http.get(endpoints.woloxers),
      this.http.get(endpoints.departments),
      this.http.get(endpoints.techs),
    ];

    return combineLatest(data).pipe(
      take(1),
      map(resolvedData => {
        const [offices, woloxers, departments, techs] = resolvedData;
        return { offices, woloxers, departments, techs };
      })
    );
  }
}
```

In your component.ts call resolver and un ngUnsubscribe pattern.
```ts
// component.ts
import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

import { Office, Woloxer, Department, Tech } from '@interfaces/generic.inteface';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit, OnDestroy {
  readonly ngUnsubscribe: Subject<void> = new Subject();
  offices: Office[] = [];
  woloxers: Woloxer[] = [];
  departments: Department[] = [];
  techs: Tech[] = [];
  constructor(readonly route: ActivatedRoute){ }

  ngOnInit() {
    this.getData();
  }

  ngOnDestroy() {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  private getData() {
    this.route.data.pipe(takeUntil(this.ngUnsubscribe)).subscribe(data => {
      const { offices, woloxers, departments, techs } = data;
      this.offices = offices;
      this.woloxers =  woloxers;
      this.departments = departments;
      this.techs = techs;
    });
  }
}
```

In routing.module add resolver
```ts
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from './home.component';
import { ResolverService } from './services/resolver.service' // new line
const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    children: [
      {
        path: '**',
        redirectTo: ''
      }
    ],
    resolve: { resolved: ResolverService }, // new linw
    runGuardsAndResolvers: 'always' // new line
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }

```

And finally provider service on Home.module
```ts
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeComponent } from './home.component';
import { HomeRoutingModule } from './home-routing.module';
import { ResolverService } from './services/resolver.service'; // new line

@NgModule({
  declarations: [ HomeComponent ],
  imports: [
    CommonModule,
    HomeRoutingModule
  ],
  providers: [ResolverService] // new linw
})
export class HomeModule {}
```

## Aliasing inputs and outputs

**Avoid** input and output aliases except when it serves an important purpose.

```ts
@Component({
  selector: 'wlx-btn',
  template: `<button>{{label}}</button>`
})
export class ButtonComponent {
  // Pointless aliases
  @Output('changeEvent') change = new EventEmitter<any>();
  @Input('labelAttribute') label: string;
}
```

**Try**

```ts
@Component({
  selector: 'wlx-nice-btn',
  template: `<button>{{label}}</button>`
})
export class ButtonComponent {
  // No aliases
  @Output() change = new EventEmitter<any>();
  @Input() label: string;
}
```

## Small templates and styles

**Avoid** create template or style file when content is less 5 lines

```html
// offices.component.html
<div class="office" *ngFor="let office of offices">
  <h3 class="office-name"> {{ office?.name }} - ({{ office?.country }}) </h3>
  <span class="office-location"> {{office?.location}} </span>
</div>
```

**Try**

```ts
@Component({
  selector: 'wlx-offices',
  template: `<div class="office" *ngFor="let office of offices">
              <h3 class="office-name"> {{ office?.name }} - ({{ office?.country }}) </h3>
              <span class="office-location"> {{ office?.location }} </span>
            </div>`
  styleUrls: ['./offices.component.scss'],
})
...
```
