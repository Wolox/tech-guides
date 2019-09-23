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
     - [4.5- SWITCH vs Dictionary](#45--switch-vs-dictionary)
   - [5- Rest API](#5--rest-api)
     - [5.1- Best Practices](#51--best-practices)
     - [5.2- Response Status Codes](#52--response-status-codes)
   - [6- Functional Programming](#6--functional-programming)
     - [6.1- Introduction](#61--introduction)
     - [6.2- Map](#62--map)
     - [6.3- Reduce](#63--reduce)
     - [6.4- Filter](#64--filter)
     - [6.5- Some](#65--some)
     - [6.6- Every](#66--every)
     - [6.7- ForEach](#67--forEach)
   - [7- ES6](#7--es6)
     - [7.1- Arrow functions](#71--arrow-functions)
     - [7.2- Spread operator](#72--spread-operator)
     - [7.3- Destructuring](#73--destructuring)
     - [7.4- String interpolation](#74--string-interpolation)
   - [8- Code Style](#8--code-style)
     - [8.1- Line length limit](#81--line-length-limit)
     - [8.2- Requires](#82--requires)
     - [8.3- Destructuring](#83--destructuring)
     - [8.4- Implicit Return](#84--implicit-return)
     - [8.5- Truthy and Falsy values](#85--truthy-and-falsy-values)
   - [9- Promise vs Async/Await](#9--promise-vs-asyncawait)
     - [9.1- Promise](#91--promise)
     - [9.2- Async Await](#92--async-await)
     - [9.3- When to use which?](#93--when-to-use-which)
   - [10- Error handling](#10--error-handling)
     - [10.1- Throwing errors](#101--throwing-errors)
     - [10.2- Capturing errors](#102--capturing-errors)
   - [11- Utils](#11--utils)
   - [12- Useful Links](#12--useful-links)

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

Helpful tools with **absolutley no business logic**. This includes parsers, date formatters, etc. Keep in mind that helpers are just auxiliary tools, thus should be abstract enough to allow being implemented in other projects.

### 2.5- Serializers

Formats the response of a service or endpoint. These are used to avoid duplicated logic in response formatting.

### 2.6- Interactors

Utilized when business flows are too complex or are many of them. For _complex_ business flows we mean those which utilize many _services_ or perform various calculations. For these cases we create **interactors** and move the different interactions from the controller to it.

### 2.7- Middlewares

Abstraction layers set up before controllers usually, which allow us to perform certain validation steps, for example, authentication or schema validations.

### 2.8- Mappers

They are used to centralize the corresponding logic of converting the data that arrives to us into the objects we handle in our application. As an advantage we also have the reuse of them at the different entry points where it applies. The main difference between mappers and serializers is that mappers are used for IN data formatting whereas serializers should be used for OUT data formatting.

&nbsp;

## 3- Naming Conventions

To keep consistency between all our projects we define a convention for a sort of different cases that we consider important. Most of the decisions were made to respect the **HTTP** and **database** standards, or to be consistent with other technologies in our stack.

### 3.1- Files

File names must be **snake_case** and **plural**, with the exception of models, which will be in **singular**. We like to keep models singular, since they are representing a singular instance of that type of object, but the other type of files should be kept in plural since they usually handle collections of objects. Also we like to avoid adding the entity (model, controller, etc) of the file in the name itself.
For example:
- if we have a 'User' model, the file should be named **user.js** instead of **users.js**, **user.model.js** or **user_model.js**.
- if we have the cars controller, the file should be named **cars.js** instead of **car.js**, **cars.controller.js** or **cars_controller.js**

### 3.2- Routes, input and output API parameters

With the purpose of unifying the interfaces with other techs and making things easier to the client who may consume any other API, we decided to keep routes, input and output API parameters in **snake_case**.

Some clarifications about the responses:

If we need to return an object that represents a certain entity, for example an user, we must return it using a key in the body that describes it as such.

```javascript
{
  user: {
    id: 1,
    first_name: 'My first name',
    last_name: 'My last name',
    email: 'My email'
  }
}
```

instead of:

```javascript
{
  id: 1,
  first_name: 'My first name',
  last_name: 'My last name',
  email: 'My email'
}
```

If we need to return a list of objects, for example a list of users, we must return it in this way using a key in the body.

```javascript
{
  users: [
    {
      id: 1,
      first_name: 'My first name',
      last_name: 'My last name',
      email: 'My email'
    },
    {
      id: 2,
      first_name: 'My first name',
      last_name: 'My last name',
      email: 'My email'
    },
    {
      id: 3,
      first_name: 'My first name',
      last_name: 'My last name',
      email: 'My email'
    }
  ]
}
```

instead of

```javascript
[
  {
    id: 1,
    first_name: 'My first name',
    last_name: 'My last name',
    email: 'My email'
  },
  {
    id: 2,
    first_name: 'My first name',
    last_name: 'My last name',
    email: 'My email'
  },
  {
    id: 3,
    first_name: 'My first name',
    last_name: 'My last name',
    email: 'My email'
  }
]
```

### 3.3- Database

To respect the database conventions we decided to keep tables and columns in **snake_case**.

### 3.4- Code

To respect the JavaScript standards we leave all variables, functions and general code in **camelCase**.

&nbsp;

## 4- Conditionals

There are several Boolean contexts, to cover as much cases as possible we must use truthy/falsy values. To know what they are, go to section [7.5](#75--truthy-and-falsy-values).

### 4.1- IFs

Up to the possible extent, single statement `ifs` should be placed within the same line without using **{ }**.

```javascript
   if(!user) return next(errors.notFound('User not found');
```

Also, the `else` statement should be avoided when possible. In many cases, you can replace it using an early `return`:

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

This operator is convenient when the condition is not given directly by a truthy or falsy value or when we want to assign values other than _undefined_.

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

In the following example, `variable` will be set to `value` if `indicator` is truthy; if `indicator` is falsy, `variable` will be set to the falsy value inside `indicator`;

```javascript
   let variable = indicator && value;
```

Examples:

```javascript
let myObj;
const myValue = 1;

let value = myObj && myObj.myKey;
console.log(value) //undefined because myObj is a falsy value.

myObj = {};
let value = myObj && myObj.myKey;
console.log(value) //undefined because myObj is a truthy value, then the value of myObj.mykey is assigned which is undefined.

myObj.myKey = myValue;
let value = myObj && myObj.myKey;
console.log(value) //myValue because myObj is a truthy value, then the value of myObj.mykey is assigned and it's value is 1.
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

### 4.5- SWITCH vs Dictionary

The purpose of `SWTCH/CASE` is to execute code depending on the input. It evaluates its input against its cases and execute the block above the matching case. According to [Mozilla](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch) docs:


> The switch statement evaluates an expression, matching the
> expression's value to a case clause, and executes statements
> associated with that case, as well as statements in cases that follow
> the matching case.


```
switch (expr) {
  case 'Oranges':
    console.log('Oranges are $0.59 a pound.');
    break;
  case 'Mangoes':
  case 'Papayas':
    console.log('Mangoes and papayas are $2.79 a pound.');
    // expected output: "Mangoes and papayas are $2.79 a pound."
    break;

  default:
  console.log('Sorry, we are out of ' + expr + '.');
}

```

That would print Mangoes and papayas are $2.79 a pound.

The problem with this is that as it grows in complexity and in number of cases, it gets more and more difficult to understand and debug, and let’s not talk about what happens if you forget a `break` ([Click if you want to know](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch#What_happens_if_I_forgot_a_break)). Furthermore, since `SWITCH` needs to compare the input to each one of the cases until it hits a match, the bigger the number of cases, the more the performance will suffer.

A good solution, and the standard among Wolox NodeJs projects is to use a dictionary (object literal) instead. So let’s rewrite the same Mozilla example:


```
const getFruitPrice = fruit =>
  ({
    oranges: 0.59,
    mangoes: 2.79,
    papayas: 2.79
  }[fruit]);

console.log(getFruitPrice('apple') || 'Sorry, we are out of that');
```


An object literal is more flexible and permits us to return any kind of value (even functions) and to execute statements targeting directly the input value. You can read more about the topic in the [link](https://ultimatecourses.com/blog/deprecating-the-switch-statement-for-object-literals#Problems_with_switch).


&nbsp;


## 5- Rest API

Typically we use a RESTful design for our APIs. The concept of REST is to separate the API structure into logical resources. The HTTP methods **GET**, **DELETE**, **POST** and **PUT** are used to operate with those resources.

### 5.1- Best Practices

These are some of the best practices to design a clean RESTful API:

* **Use plural nouns instead of verbs**: To get all users perform a GET to _/users_ instead of _/getUsers_.
* **The following HTTP methods are typically used in a RESTful API**:
  * **GET**: Use GET requests to retrieve resource representation/information only – and not to modify it in any way. As GET requests do not change the state of the resource, these are said to be safe methods. Additionally, GET APIs should be idempotent, which means that making multiple identical requests must produce the same result every time until another API (POST or PUT) has changed the state of the resource on the server.
  * **POST**: Use POST APIs to create new subordinate resources, e.g. a file is subordinate to a directory containing it or a row is subordinate to a database table. Talking strictly in terms of REST, POST methods are used to create a new resource into the collection of resources. Ideally, if a resource has been created on the origin server, the response SHOULD be HTTP response code 201 (Created) and contain an entity which describes the status of the request and refers to the new resource, and a Location header.
  * **PUT**: Use PUT APIs primarily to update existing resource (if the resource does not exist then API may decide to create a new resource or not). If a new resource has been created by the PUT API, the origin server MUST inform the user agent via the HTTP response code 201 (Created) response and if an existing resource is modified, either the 200 (OK) or 204 (No Content) response codes SHOULD be sent to indicate successful completion of the request.
  * **DELETE**: DELETE APIs are used to delete resources (identified by the Request-URI). A successful response of DELETE requests SHOULD be HTTP response code 200 (OK) if the response includes an entity describing the status, 202 (Accepted) if the action has been queued, or 204 (No Content) if the action has been performed but the response does not include an entity.
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
* **401 UNAUTHORIZED**: The client must authenticate itself to get the requested response.
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

Returns a new array resulting of applying the function to each element of the original array.

```javascript
   const numbers = [1, 4, 9, 16];

   // pass a function to map
   const double = numbers.map(x => x * 2);

   console.log(double);
   // expected output: Array [2, 8, 18, 32]
```

### 6.3- Reduce

Reduces the array to one value, iterating through each element where acumulator is the result of the last call, which is also known as seed.
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

Returns an array with all the values from the original array for which the function returned a truthy value.

```javascript
   const isBigEnough = value => value >= 10;

   const filtered = [12, 5, 8, 130, 44].filter(isBigEnough);
   // filtered is [12, 130, 44]
```

### 6.5- Some

Returns true when at least one array's element evaluated by the function, returns a truthy value.

```javascript
   const isLegal = value => value >= 18;

   const anyCanDrive = [8, 37, 17, 62, 13].some(isLegal);
   // returned true because the elements 37 and 13 are greater than 18

```


### 6.6- Every

Returns true when all the elements within the array evaluated by the function, return a truthy value.

```javascript
   const isEven = value => !(value % 2);

   const areEven = [8, 5, 17, 40, 13].every(isEven);
   // returned false because the elements 5,17 and 13 are odd

```



### 6.7- forEach

Execute the function for each element without returning a value.
The forEach function doesn't modify the original array and create a new scope.

```javascript
   const tennisPlayers = ['Federer','Nalbandian','Nadal'];

   tennisPlayers.forEach(name => {
     const nameLength = name.length;
     //code that is will executed for each element
   })
   console.log(nameLength) // ReferenceError:nameLength is not defined

```

## 7- ES6

### 7.1- Arrow functions

Arrow functions are a new feature introduced by ES6 that allow build a function. Use token `=>` after params instead of `function`.

```javascript
   //ES5
   var nextNumber = function(x) {
    return x+1;
   }
   //ES6
   const nextNumber = x => {
    return x+1;
   }
   // Arrow functions use implicit return, which means you can do
   const nextNumber = (x) => x+1;
   // For one param the parenthesis are optional
   const nextNumber = x => x+1;
   // if you need to do another action before returning you should add { }
   const nextNumber = x => {
    console.log('Next number ready');
    return x+1;
   }

```

An important difference between classic functions and arrow functions is how `this` behaves in each case.

```javascript
   var friends = ['Joe', 'Paul'];
   const myLife = {
    age: 7,
    showFriends() {
     console.log(this.friends); //log undefined
     console.log(this.age); // log 7
    },
    arrowShowFriends: () => {
     console.log(this.friends); // log ['Joe', 'Paul']
     console.log(this.age); // log undefined
    }
   };
   myLife.showFriends();
   myLife.arrowShowFriends();

```
As you can see, in the classic function, `this` references the local context.
And in the arrow function, `this` references the global context.


### 7.2- Spread operator

The spread operator allows us to merge all properties from an object into a target object.
It's important to know that this operator creates a new object and doesn't exist
a reference to the original object.

```javascript
   const myHouse = { size: 30, age: 40, countFloors: 2, countEnvironments: 6 };
   const newHouseAge = { age: 44 };
   // classic solution
   const friendHouse = { size: 30, age: 25, countFloors: 2, countEnvironments: 6 };
   // but using the spread operator
   const friendHouse = {...myHouse, age: 25 };
   // keep in mind that the properties are applied in the order in which the objects are given
   const newHouse = {...friendHouse, ...newHouseAge };
   console.log(newHouse.age); // log 44
   // on the opposite
   const newHouse = {...newHouseAge, ...friendHouse };
   console.log(newHouse.age); // log 25

```


### 7.3- Destructuring

The destructuring assignment syntax is a expression that makes it possible to unpack values from arrays, or properties from objects, into distinct variables.

```javascript
   const getDataUser = () => ({
     id: 1,
     name: 'Steve',
     age: 24
   });
   const getUsers = () => [{ id: 1, name: 'Peter' }, { id: 2, name: 'Ben' }];

   const { name } = await getDataUser();
   const [ firstUser ] = await getUsers();

   console.log(name); // log 'Steve'
   console.log(firstUser.name); // log 'Peter'

```


### 7.4- String interpolation

The new string interpolation introducing a way more easy to log messages with vars.

```javascript
   const myDog = {
     name: 'Dynamite',
     age: 5,
     weight: 13.5
   };
   //ECMA 5
   console.log("My dog name is "+ myDog.name);
   //ECMA 6
   console.log(`My dog name is ${myDog.name}`);

```

&nbsp;

## 8- Code style

### 8.1- Line length limit

Line length limit should be between 80 and 100 characters.

### 8.2- Requires

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

### 8.3- Destructuring

This is really useful to refer specific values from modules.

```javascript
   const { create, update, delete } = require('../services/user');
```

A comprenhensive approach to destructuring may be found in the useful links section.

### 8.4- Implicit return

When using _arrow functions_ we can make the **return statement implicit** meaning that the result of evaluating the expression right of the arrow will be returned as a value. This saves writing **{}** and **return**.

Yes, code will be shorter and neater but for more complex code, changing or debugging is noticeably more prone to errors. This is why, we enforce the use of the **implicit return** only in simple or short functions.

### 8.5- Truthy and Falsy values

In JavaScript, a truthy value is a value that translates to true when evaluated in a Boolean context. All values are truthy unless they are defined as falsy which are **false**, **0**, **""**, **null**, **undefined** and **NaN**.

&nbsp;

## 9- Promise vs Async/Await

### 9.1- Promise

A _promise_ represents the eventual success or failure of an asynchronous operation. Promises have two methods:
* **then**: Takes a function as parameter which is executed once the promise is resolved with the result as parameter.
* **catch**: Takes a function as parameter which is executed once an exception is thrown with the exception as parameter.

There are many ways to handle correctly promises. Feel free to browse Maykol Purica's post about Promises in the useful links section.

### 9.2- Async Await

Promise's _syntactic sugar_.
Specifying any function or arrow function as **async** specifies that the return value is a Promise.
**await** may only be used inside **async** functions. Using **await** makes the code flow block until the promise is _resolved_ or _rejected_.
**await** statements are usually within **try/catch** blocks.

### 9.3- When to use which?

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

## 10- Error handling

### 10.1- Throwing errors

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

### 10.2- Capturing errors

A **catch** has to be used to handle the error.

In case you want to perform the response of the request with the error, you have to execute the _error middleware function_.

```javascript
   return next(errors.notFound('User not found'));
```
When a parameter is passed to the **next** function, Express already knows that it must go to the error middleware function, regardless of the other functions in between.

## 11- Utils

In this section we will leave a few **packages** that will help us solve many of our problems.

* **[LODASH][lodash]**: A modern JavaScript utility library delivering modularity, performance & extras.
* **[LODASH FP][lodash-fp]**: Lodash oriented to functional programming.
* **[RAMBDA][rambda]**: A practical functional library for JavaScript programmers.
* **[MOMENT][moment]**: Parse, validate, manipulate, and display dates and times in JavaScript.

## 12- Useful Links

- [Developing Better Node.js Developers][MaPiP] by Matias Pizzagalli.
- [Bootstrap][GEP] by Gonzalo Escandarani.
- [Promises][MaPuP] by Maykol Purica.
- [Destructuring][destructuring] Destructuring guide.
- [Status Codes][statusCodes] Status codes guide.
- [Error propagation in Javascript][errorPropagation] How errors propagate in Javascript.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [MaPiP]: <https://medium.com/wolox-driving-innovation/developing-better-node-js-developers-a176de770539>
   [GEP]: <https://medium.com/wolox-driving-innovation/nodejs-api-bootstrap-b598a2591a3b>
   [MaPuP]: <https://medium.com/wolox-driving-innovation/how-to-code-better-async-javascript-e59363883c84>
   [destructuring]: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment>
   [statusCodes]: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status>
   [errorPropagation]: <https://medium.com/front-end-weekly/error-propagation-in-javascript-with-error-translation-pattern-78cf7178fe92>
   [lodash]: <https://lodash.com/>
   [lodash-fp]: <https://github.com/lodash/lodash/wiki/FP-Guide>
   [rambda]: <https://ramdajs.com/>
   [moment]: <https://momentjs.com/>

## About

This documentation is maintained by [Wolox](https://github.com/wolox) and it was written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)
