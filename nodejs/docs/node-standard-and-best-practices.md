# Wolox NodeJS Standards and best practices

<h1 align="center">
  <img src="https://raw.githubusercontent.com/arinaldi118/documentacion/master/assets/images/banner.png" alt="Node.js Best Practices">
</h1>

   - [1- Objective](#1--objective)
   - [2- APP Structure](#2--app-structure)
     - [2.1- Controllers](#21--controllers) 
     - [2.2- Services](#22--services)
     - [2.3- Models](#23--models)
     - [2.4- Helpers](#24--helpers)
     - [2.5- Serializers](#25--serializers)
     - [2.6- Interactors](#26--interactors)
     - [2.7- Middlewares](#27--middlewares)
     - [2.8- Mappers](#28--mappers)
   - [3- Naming Conventions](#3--naming-conventions)
     - [3.1- Files](#31--files)
     - [3.2- Routes, input and output API parameters](#32--routes-input-and-output-api-parameters)
     - [3.3- Database](#33--database)
     - [3.4- Code](#34--code)
   - [4- Conditionals](#4--conditionals)
     - [4.1- IFs](#41--ifs)
     - [4.2- Ternary Operator](#42--ternary-operator)
     - [4.3- AND Operator](#43--and-operator)
     - [4.4- OR Operator](#44--or-operator)
   - [5- Rest API](#5--rest-api)
     - [5.1- Best Practices](#51--best-practices)
     - [5.2- Response Status Codes](#52--response-status-codes)
   - [6- Functional Programming](#6--functional-programming)
     - [6.1- Introduction](#61--introduction)
     - [6.2- Map](#62--map)
     - [6.3- Reduce](#63--reduce)
     - [6.4- Filter](#64--filter)
     - [6.5- Others](#65--others)
   - [7- Code Style](#7--code-style)
     - [7.1- Line length limit](#71--line-length-limit)
     - [7.2- Requires](#72--requires)
     - [7.3- Destructuring](#73--destructuring)
     - [7.4- Implicit Return](#74--implicit-return)
     - [7.5- Truthy and Falsy values](#75--truthy-and-falsy-values)
   - [8- Promise vs Async/Await](#8--promise-vs-asyncawait)
     - [8.1- Promise](#81--promise)
     - [8.2- Async Await](#82--async-await)
     - [8.3- When to use which?](#83--when-to-use-which)
   - [9- Error handling](#9--error-handling)
     - [9.1- Throwing errors](#91--throwing-errors)
     - [9.2- Capturing errors](#92--capturing-errors)
   - [10- Utils](#10--utils)
   - [11- Useful Links](#11--useful-links)

## 1- Objective

The purpose of this document is to present the standards we use in Wolox to work with NodeJS. 
It's recommended to read Matias Pizzagalli's post whose link is in the section of useful links.

&nbsp;

## 2- APP Structure

The structure that will be used includes, at least, these folders: (models and interactors if they are necessary for the API). For more information is Gonzalo Escandarani's post in the section of useful links.

### 2.1- Controllers

Every exported controller method should receive a request, a response and the next parameters from express. Its responsibility is validating and formatting the request, calling the services, modeling methods and returning the response formatting if it is necessary. Also, handling errors should be done here. The controllers are grouped by resource such as users, albums and so on.  In the case that there are too many complex parts you should abstract part of the logic to an **interactor**.

### 2.2- Services

Our services are responsible for interacting with external services and database management. Usually we have one file per external service and should be as simple as possible. The services shouldn't interact with each other.

### 2.3- Models

The model should be as simple as possible, just fields and Sequelize configurations. We try to not put logic here but it is permitted to do some specific model validations such as user password validation.

### 2.4- Helpers

Helpful tools with **absolutley no business logic**. These include parsers, date formatters, etc. These are just auxiliary tools and should be able to be used in other projects.

### 2.5- Serializers

Formats the response of a service or endpoint. These are used when there is too much complexity or repetition.

### 2.6- Interactors

Utilized when business flow is too complex or are many of them. For _complex_ business flows we mean those which utilize many _services_ or perform various calculations. For these cases we create **interactors** and move the different interactions from the controller to it.

### 2.7- Middlewares

Abstraction layers set up before controllers usually, which allow us to perform certain validation steps, for example, authentication or schema validations.

### 2.8- Mappers

They are used to centralize the corresponding logic of converting the data that arrives to us into the objects we handle in our application. As an advantage we also have the reuse of them at the different entry points where it applies.

&nbsp;

## 3- Naming Conventions

To keep consistency between all our projects we define a convention for a sort of different cases that we consider important. Most of the decisions were made to respect the **HTTP** and **database** standards, or to be consistent with other technologies in our stack.

### 3.1- Files

File names must be **snake_case** and **plural** except models, which will be in **singular**. We like to keep models singular, since they are representing a singular instance of that type of objects, but the other type of files in plural since they usually handle collections of objects. Also we like to avoid the entity (model, controller, etc) of the file in the name itself.
For example:
- if we have the model user, the file should be named **user.js** instead of **users.js** **user.model.js** or **user_model.js**.
- if we have the cars controller, the file should be named **cars.js** instead of **car.js**, **cars.controller.js** or **cars_controller.js**

### 3.2- Routes, input and output API parameters

With the purpose of unifying the interfaces with other techs and making things easier to the client who will consume other API, we decide to keep routes, input and output API parameters in **snake_case**.

### 3.3- Database

To respect the database conventions we decide to keep tables and columns in **snake_case**.

### 3.4- Code

To respect the JavaScript standards we leave all other variables, functions and general code in **camelCase**.

&nbsp;

## 4- Conditionals

There are several Boolean contexts, to make the most of them we must use thuthy/falsy values. To know what they are you should read section 7.5.

### 4.1- IFs

Up to the possible extent, single statement `ifs` should be placed within the same line without using **{ }**.

```javascript
   if(!user) return next(errors.notFound('User not found');
```

Likewise, the if statement should be wisley selected to avoid using the else statement, for example use early return instead of else statement:

```javascript
   if(!user) return next(errors.notFound('User not found');
    ..
    ..
    ....
    .
    ....
    ..
```
instead of

```javascript
    if(user){
        ..
        ..
        ....
        .
        ....
        ..
    } else {
        next(errors.notFound('User not found');
    };
```
### 4.2- Ternary Operator

When a value should be chosen using a binary condition it is useful to use the ternary operator. 

```javascript
   let variable = condition ? value_if_condition_is_true : value_if_condition_is_false;
```

This operator is convenient when the condition is not given directly by a Truthy or falsy value or when we want to assign values other than _undefined_.

```javascript
  const age = 26;
  const beverage = age >= 21 ? 'Beer' : 'Juice';
  console.log(beverage); // "Beer"

  const isStudent = true;
  const price = isStudent ? 8 : 12;
  console.log(price); // 8
```

Instead, when we have these cases it is convenient to use the **AND** operator or the **OR** operator.

```javascript
  let myObj;
  let value = myObj ? myObj.myKey : undefined; // Here you should use the AND operator.

  let myVar1;
  let myVar2;
  let myVar3 = 'myVar';
  let value = myVar1 ? myVar1 : myVar2 ? myVar2 : myVar3 ? myVar3 : undefined; // Here you should use the OR operator.

```

### 4.3- AND Operator

A simple way to avoid the ternary operator is using the **AND** operator. 

In the following example variable will be set to value if indicator is truthy, if indicator is falsy variable will be set to value;

```javascript
   let variable = indicator && value;
```

Examples:

```javascript
let myObj;

let value = myObj && myObj.myKey;
console.log(value) //undefined because myObj is a falsy value.

myObj = {};
let value = myObj && myObj.myKey;
console.log(value) //undefined because myObj is a truthy value, then the value of myObj.mykey is assigned which is undefined.

myObj.myKey = myValue;
let value = myObj && myObj.myKey;
console.log(value) //myValue because myObj is a truthy value, then the value of myObj.mykey is assigned which is myValue.
```

### 4.4- OR Operator

When using OR operator between diferent values, the result of evaluation will be the first truthy value from left to right. 

In this example variable will be set to option_1 if its not falsy, in that case it will be set to option_2 value if its not falsy, and on until the last value.

```javascript
   let variable = option_1 || option_2 || option_3;
```

Example:

```javascript
  let foo, bar, baz;
  const name = foo || bar || baz || 'Sunshine';
  console.log(name); // Sunshine because foo, bar and baz are undefined.
```

This example could be written with `if/else` and we note that it is much longer.

```javascript
  let foo, bar, baz, name;

  if (foo) name = foo;
  else if (bar) name = bar;
  else if (baz) name = baz;
  else name = 'Sunshine';

  console.log(name); // Sunshine because foo, bar and baz are undefined.
```

&nbsp;


## 5- Rest API

Typically we use a RESTful design for our web APIs. The concept of REST is to separate the API structure into logical resources. There are used the HTTP methods **GET**, **DELETE**, **POST** and **PUT** to operate with the resources.

### 5.1- Best Practices

These are some of the best practices to design a clean RESTful API:

* **Use plural nouns instead of verbs**: To get all cars perform a GET to _/users_ instead of _/getUsers_.
* **GET methods must not alter states**: Must return stuff, not modify it.
* **Use sub-resources for relations**: To obtain driver number 2 of car number 4 use GET _/cars/4/drivers/2_
* **Provide filtering, sorting, field selection and paging for collections**: Use query params to apply different options to alter data retrieval through GET methods.
* **API Version**: API's must be versioned always.

### 5.2- Response Status Codes

There are many _status codes_ to use in request responses. \
Most commonly used are:

* **200 OK**: Base successful response. Depends on currently used HTTP method. 
* **201 CREATED**: Successful response meaning a new resource has been created. Most commonly used with POST and sometimes PUT.
* **204 NO CONTENT**: Successful response without content in body.
* **400 BAD REQUEST**: Request was not formatted correctly and the server cannot interpret it.
* **401 UNAUTHORIZED**: Unauthorized attempt to use a specific resource.
* **403 FORBIDDEN**: Incorrect level of authorization to use a specific resource.
* **404 NOT FOUND**: Specified resource was not found.
* **422 UNPROCESSABLE ENTITY**: Must be used when the server cannot handle the request as is. For example may be a parameter image cannot be read correctly or some parameters are missing.
* **500 INTERNAL SERVER ERROR**: An internal server error has ocurred which it does not know how to handle.

Useful links will include more information about status codes.

## 6- Functional Programming

To the extent to which it can be applied, use fuctional primitives as **Map, Reduce, Filter, etc.**.

### 6.1- Introduction

Functional programming is a _declarative_ paradigm, whilst prodedural and OOP (object oriented programming) are _imperative_ paradigms.

The _declarative_ paradigm, as opposed to _imperative_, avoids describing the **control flow** (loops, conditionals, etc.) and focuses on describing **what** are we doing instead of **how** are we doing it (_imperative_ approach).

### 6.2- Map

Returns a new array resulting of applying the a function to each element of the original array.

```javascript
   const numbers = [1, 4, 9, 16];

   // pass a function to map
   const double = numbers.map(x => x * 2);
   
   console.log(double);
   // expected output: Array [2, 8, 18, 32]
```

### 6.3- Reduce

Effectively reduces the array to one value, iterating through each element where acumulator is the result of the last call.
The starting value of the acumulator is passed a second parameter and the last value returned is effectively the result of the reduce operation.

```javascript
   const numbers = [1, 2, 3, 4];
   const reducer = (accumulator, currentValue) => accumulator + currentValue;

   // 1 + 2 + 3 + 4
   console.log(numbers.reduce(reducer));
   // expected output: 10

   // 5 + 1 + 2 + 3 + 4
   console.log(numbers.reduce(reducer, 5));
   // expected output: 15
```

### 6.4- Filter

Returns an array with all the values from the original array for which the function retured a truthy value.

```javascript
   const isBigEnough = value => value >= 10;
    
   const filtered = [12, 5, 8, 130, 44].filter(isBigEnough);
   // filtered is [12, 130, 44]
```

### 6.5- Others

Other useful methods for a _declarative_ approach.

* **some()**.
* **every()**.
* **forEach()**.
* **split()**.

&nbsp;

## 7- Code style

### 7.1- Line length limit

Line length limit should be between 80 and 100 characters.

### 7.2- Requires

The format we'll adopt for **requires** will be:
* **const** for each require.
* They will be separated in two blocks:
  * The first one will refer to external dependencies.
  * The second one will refer to internal dependencies.

```javascript
   const moment = require('moment');
   const lodash = require('lodash');

   const userService = require('../services/users');
   const userMapper = require('../mappers/users');

```

### 7.3- Destructuring

The destructuring assignment syntax is a JavaScript expression that makes it possible to unpack values from arrays, or properties from objects, into distinct variables.

This is really useful to refer specific values from modules.

```javascript
   const { create, update, delete } = require('../services/user');
```

A comprenhensive approach to destructuring may be found in the useful links section.

### 7.4- Implicit return

When using _arrow functions_ we can make the **return statement implicit** meaning that the result of evaluating the expression right of the arrow will be returned as a value. This saves writing **{}** and **return**.  

Yes, code will be shorter and neater but for more complex code, changing or debugging is noticeably more prone to errors. This is why, we enforce the use of the **implicit return** only in simple or short functions.

### 7.5- Truthy and Falsy values

In JavaScript, a truthy value is a value that translates to true when evaluated in a Boolean context. All values are truthy unless they are defined as falsy which are **false**, **0**, **""**, **null**, **undefined** and **NaN**.

&nbsp;

## 8- Promise vs Async/Await

### 8.1- Promise

A _promise_ represents the eventual success or failure of an asynchronous operation. Promises have two methods:
* **then**: Takes a function as parameter which is executed once the promise is resolved with the result as parameter.
* **catch**: Takes a function as parameter which is executed once an exception is thrown with the exception as parameter.

There are many ways to handle correctly promises. Feel free to browse Maykol Purica's post about Promises in the useful links section.

### 8.2- Async Await

Promise's _syntactic sugar_.
Specifying any function or arrow function as **async** specifies that the return value is a Promise.
**await** may only be used inside **async** functions. Using **await** makes the code flow block until the promise is _resolved_ or _rejected_.
**await** statements are usually within **try/catch** blocks.

### 8.3- When to use which?

Always prioritize the use of **promises**.  
A convenient case for using async/await is when a promise is executed conditionally without altering main flow. 
Using promises we would have:

```javascript
  if (order.state === CANCELLED) {
    return deleteProduct(order.product)
      .then(() => sendEmail({
        id: order.id,
        state: order.state
      }))
      .then(response => ...)
  }
 
  return sendEmail({
    id: order.id,
    state: order.state
  })
    .then(response => ...)
```

Notice the promises chain was repeated. As it grows, the duplicate code will get bigger and bigger.  
Instead, using **async/await**:

```javascript
  if (order.state === CANCELLED) {
    try {
      await deleteProduct(order.product);
    } catch (e) {
      ...
    }
  }
 
  return sendEmail({
    id: order.id,
    state: order.state
  })
    .then(response => ...)
```

When using this approach, we await all of the promises so the code is uniform.

```javascript
  try {
    if (order.state === CANCELLED) {
      await deleteProduct(order.product);
    }
 
    const response = await sendEmail({ id: order.id, state: order.state });
    ...
  } catch (e) {
    ...
  }
```

&nbsp;

## 9- Error handling

### 9.1- Throwing errors

There are two ways of doing it. They are almost identical except for what is mentioned [here](https://stackoverflow.com/questions/33445415/javascript-promises-reject-vs-throw).

```javascript
   throw errors.notFound('User not found');
```
or
```javascript
   return Promise.reject(errors.notFound('User not found'));
```

When throwing errors within promises we must return the exception using **Promise.reject**.  
Be uniform with an option to achieve the prolixity of the code.

### 9.2- Capturing errors

A **catch** has to be used to handle the error.

In case you want to perform the response of the request with the error, you have to execute the _error middleware function_.

```javascript
   return next(errors.notFound('User not found'));
```
When a parameter is passed to the **next** function, Express already knows that it must go to the error middleware function, regardless of the other functions in between.

## 10- Utils

In this section we will leave a few **packages** that will help us solve many of our problems.

* **[LODASH][lodash]**: A modern JavaScript utility library delivering modularity, performance & extras.
* **[LODASH FP][lodash-fp]**: Lodash oriented to functional programming.
* **[RAMBDA][rambda]**: A practical functional library for JavaScript programmers.
* **[MOMENT][moment]**: Parse, validate, manipulate, and display dates and times in JavaScript.

## 11- Useful Links

- [Developing Better Node.js Developers][MaPiP] Post by Matias Pizzagalli's post.
- [Bootstrap][GEP] Post by Gonzalo Escandarani.
- [Promises][MaPuP] Post by Maykol Purica.
- [Destructuring][destructuring] Destructuring guide.
- [Status Codes][statusCodes] Status codes guide.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [MaPiP]: <https://medium.com/wolox-driving-innovation/developing-better-node-js-developers-a176de770539> 
   [GEP]: <https://medium.com/wolox-driving-innovation/nodejs-api-bootstrap-b598a2591a3b>
   [MaPuP]: <https://medium.com/wolox-driving-innovation/how-to-code-better-async-javascript-e59363883c84>
   [destructuring]: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment>
   [statusCodes]: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status>

## About

This documentation is maintained by [Wolox](https://github.com/wolox) and it was written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)