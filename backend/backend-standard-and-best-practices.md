# Backend standards and best practices

- [1- Objective](#1--objective)
- [2- Naming Conventions](#2--naming-conventions)
  - [2.1- Input and output API parameters](#21--input-and-output-parameters-naming)
  - [2.2- Output parameters structure](#22--output-parameters-structure)
- [3- Response bodies](#3--response-bodies)
  - [3.1- Pagination](#31--pagination)
  - [3.2- Error forwarding](#32--error-forwarding)
- [4- API Versioning](#4--api-versioning)
- [5- Response Status Codes](#5--response-status-codes)
- [6- API Documentation ](#6--api-documentation)
- [7- Routes](#7--routes)


## 1- Objective

The purpose of this document is to present the standards we use in Wolox to work with APIs in the backend department.

## 2- Naming conventions

To keep consistency between all our projects we define a convention for different cases that we consider important. Most of the decisions were made to respect the **HTTP** and **database** standards, or to be consistent between technologies in our stack.

### 2.1- Input and output parameters naming

With the purpose of unifying the interfaces between techs and making things easier to the client who may consume any of our APIs, we decided to keep input and output API parameters in **snake_case**.

```json
{
  "id": 1,
  "first_name": "My first name",
  "last_name": "My last name",
  "email": "My email"
}
```

```json
{
  "data": [
    {
      "id": 1,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    },
    {
      "id": 2,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    },
    {
      "id": 3,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    }
  ]
}
```
### 2.2- Output parameters structure

If we need to return an object that represents a certain entity, for example an user, we should avoid to return it using a key in the body containing all its data; we should directly return the data in the body instead.

```json
{
  "id": 1,
  "first_name": "My first name",
  "last_name": "My last name",
  "email": "My email"
}
```

instead of:

```json
{
  "user": {
    "id": 1,
    "first_name": "My first name",
    "last_name": "My last name",
    "email": "My email"
  }
}
```

## 3- Response bodies

### 3.1- Pagination

All paginated lists requested to our APIs should be returned using the following structure:

```json
{
 "page": [
    {
      "id": 4,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    },
    {
      "id": 5,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    },
    {
      "id": 6,
      "first_name": "My first name",
      "last_name": "My last name",
      "email": "My email"
    }
 ],
 "count": 3,
 "limit": 3,
 "offset": 0,
 "total_pages": 4,
 "total_count": 12,
 "previous_page": 1,
 "current_page": 2,
 "next_page": 3,
 "previous_page_link": "domain.com/users?page=1&limit=3&offset=0",
 "current_page_link": "domain/com/users?page=2&limit=3&offset=3",
 "next_page_link": "domain.com/users?page=3&limit=3&offset=6",
 "first_page_link": "domain.com/users?page=1&limit=3&offset=0",
 "last_page_link": "domain.com/users?page=4&limit=3&offset=9",
 "n_page_link": "domain.com/users?page=X&limit=3&offset=Y"
}
```

Some clarifications about the pagination response:
- The starting page number should always be 1.
- When returning the first page, the *previous_page* property should be `NULL`.
- The parameters with the `_link` suffix are suggested when using link-oriented pagination; otherwise, they should not be included in the response body.

### 3.2- Error forwarding

When informing a client of a request error, the response body should be returned using the following structure:

```json
{
  "status_code": 422,
  "errors": [
    { "code": "111", "message": "age must be an int" }
    { "code": "112", "message": "email is mandatory" }
  ],
  "origin": "api-name",
  "stack_trace": "...",
  "timestamp": "2019-09-10 03:14:07"
}
```

Some clarifications about the error response:
- The `timestamp` field is not mandatory, but its use is recommended for logging purposes.
- Both the `origin` and `stack_trace` fields are considered sensitive information, and they should not be sent to a frontend or external client. Their use should be limited between internal APIs of the same application.
- The `code` field in the errors list is intended as a unique identifier of the returned error message, and a way of keeping an internal record of all errors handled by the application. Also, it should not be a random value, but instead follow a certain convention (for example, codes with format `W-4XX` could be used for invalid request errors, `W-5XX` for application errors, etc.)
- Depending on the case and the receiver of the response, it may not be necessary to send both the `code` and `message` parameters.

## 4- API Versioning

We decided to implement API versioning via the use of headers.


- Java example:
```java
/*
http://localhost:8080/person/header
headers=[X-API-VERSION=1]
http://localhost:8080/person/header
headers=[X-API-VERSION=2]
Implementations are shown below:
*/

  @GetMapping(value = "/student/header", headers = "X-API-VERSION=1")
  public StudentV1 headerV1() {
    return new StudentV1("Bob Charlie");
  }

  @GetMapping(value = "/student/header", headers = "X-API-VERSION=2")
  public StudentV2 headerV2() {
    return new StudentV2(new Name("Bob", "Charlie"));
  }

```

- Rails example (using [Versionist])
```ruby
MyApi::Application.routes.draw do
  api_version(:module => "V20120317", header: {name: "X-API-VERSION", value: "v20120317"}) do
    resources :bars
  end
end
```

- Node/Express example (using [Express Routes Versioning])
```javascript
var app = require('express')();
var versionRoutes = require('express-routes-versioning')();
app.listen(3000);
app.use(function(req, res, next) {
    //req.version is used to determine the version
   req.version = req.headers['X-API-VERSION'];
   next();
});
app.get('/users', versionRoutes({
   "1.0.0": respondV1,
   "~2.2.1": respondV2
}));

// curl -s -H 'accept-version: 1.0.0' localhost:3000/users
// version 1.0.0 or 1.0 or 1 !
function respondV1(req, res, next) {
   res.status(200).send('ok v1');
}

//curl -s -H 'accept-version: 2.2.0' localhost:3000/users
//Anything from 2.2.0 to 2.2.9
function respondV2(req, res, next) {
   res.status(200).send('ok v2');
}
```

### 5- Response Status Codes

There are many _status codes_ to use in request responses. \
Most commonly used are:

* **200 OK**: Basic successful response. Depends on currently used HTTP method.
* **201 CREATED**: Successful response meaning a new resource has been created. Most commonly used with POST and sometimes PUT.
* **204 NO CONTENT**: Successful response without content in body.
* **400 BAD REQUEST**: Request was not formatted correctly and the server cannot interpret it (syntax error).
* **401 UNAUTHORIZED**: The client must authenticate itself to get the requested response.
* **403 FORBIDDEN**: Incorrect level of authorization to use a specific resource.
* **404 NOT FOUND**: Specified resource was not found.
* **422 UNPROCESSABLE ENTITY**: Must be used when the server cannot handle the request as is. For example, a parameter image cannot be read correctly or some required parameters are missing.
* **500 INTERNAL SERVER ERROR**: An internal server error has occurred which it does not know how to handle. Avoid using this manually and use a more descriptive code instead.

You can read more about this and other status codes in [this link](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status).

## 6- API Documentation

There are lots of different tools in the market to document APIs. Here in Wolox we decided to use Openapi 3 (A.K.A Swagger) as a standard documentation tool in all of our techs. The reasons behind this decision were some of the advantages OpenApi prodvides:

* **Quick to use**: The properties that you need to fill in every endpoint are always the same and there are only a few. You can also frequently reuse components and the generic information is simple to provide.
* **Wide range of available features**: From describing parameters, making authentication and authorization schemes, to even using the generated documentation of an endpoint to mock test the endpoint in question.
* **Intuitive and easy to use interactive UI**: Swagger uses a GUI to show the user how to make requests to the API and what responses will look like. 
* **Maintainable and easily extendable**: Swagger allows using constants files from your API. 
* **Scan and auto-generate**: For typed languages, Swagger can scan and auto-generate documentation.  

You can read more a about Swagger in this [this link](https://swagger.io/docs/).

### 7- Routes

While it's impossible to define every single route name possibility, we chose a few examples to act as guidelines

#### Wrong
* *`GET /get_users`, `GET /get_user/:user_id`, `GET /get_user?user_id=1`, `GET /get?model=user&user_id=1`*: while we don't need to be 100% RESTful, we should use the basic idea of resources and verbs as separate things.
* *`GET /user_summary/1`*: use nested resources for cases where a resource is deeply linked to another resource.
* *`POST /create_user`*: a POST to a route named `create_X` is redundant, just make a POST to `/users/`
* *`DELETE /delete_user `*: likewise, a DELETE to a route named `delete_X` is redudant.
* *`POST /users/update`*: don't use post for an update. Use either patch or put depending on whether you need to pass the whole instance or just the updated fields. Use POST for more generic endpoints that escape the common RESTful resource logic though.
* *`GET /users/update?field1=a&field2=b&...`*: don't use a GET for an update with query params for fields.
* *Spanglish*: or any other combination of non-english terms unless it's strictly necessary.
* *Camel case*: the standard for Wolox backends is to use `lower_snake_case` for routes.
* *Restricting yourself to database models*: REST resources don't need to have a 1:1 relationship with database models. If it makes semantic sense to break one model up into multiple resources or to join multiple models using an abstract model, that's correct.

#### Right
* *`GET /users`*
* *`GET /users/:user_id`*
* *`PATCH /users/:user_id` and `PUT /users/:user_id`*
* *`POST /users`*
* *`DELETE /users/:user_id`*
* *`GET /users/1/summary`*

[//]: #

  [Versionist]: <https://github.com/bploetz/versionist>
  [Express Routes Versioning]: <https://www.npmjs.com/package/express-routes-versioning>
