# Angular style guide

## Table Of Contents

 1. Single responsibility
 2. Witout directly touching DOM

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
  selector: 'app-root',
  template:
    `<h1>{{title}}</h1>
    <pre>{{offices | json}}</pre>`,
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
  selector: 'app-root',
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
    this.renderer2.setProperty(this.elementRef.nativeElement, 'href', 'https://wolox.com.ar');
  }
}
```

## Avoid aliasing inputs and outputs

Avoid input and output aliases except when it serves an important purpose.

```ts
@Component({
  selector: 'toh-hero-button',
  template: `<button>{{label}}</button>`
})
export class HeroButtonComponent {
  // Pointless aliases
  @Output('changeEvent') change = new EventEmitter<any>();
  @Input('labelAttribute') label: string;
}
```

**Try**

```ts
@Component({
  selector: 'toh-hero-button',
  template: `<button>{{label}}</button>`
})
export class HeroButtonComponent {
  // No aliases
  @Output() change = new EventEmitter<any>();
  @Input() label: string;
}
```

## TypeScript

**Avoid** use the return type any for callbacks whose value will be ignored

```ts
function fn(x: () => any) {
  x();
}
```
**Try to** use the return type void for callbacks whose value will be ignored:

```ts
function fn(x: () => void) {
  x();
}
```
