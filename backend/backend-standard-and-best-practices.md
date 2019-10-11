- [1- Objective](#1--objective)
- [2- Naming Conventions](#2--naming-conventions)
  - [2.1- Input and output API parameters](#21--input-and-output-parameters-naming)
  - [2.2- Output parameters structure](#22-output-parameters-structure)
- [3- Response bodies](#3-response-bodies)
  - [3.1- Pagination](#31-pagination)
- [4- API Versioning](#4-api-versioning)


## 1- Objective

The purpose of this document is to present the standards we use in Wolox to work with APIs in the backend department.

## 2- Naming conventions

To keep consistency between all our projects we define a convention for a sort of different cases that we consider important. Most of the decisions were made to respect the **HTTP** and **database** standards, or to be consistent between technologies in our stack.

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
"user_list": [
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
```
### 2.2 Output parameters structure

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

## 3 Response bodies

### 3.1 Pagination

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
 "previous_page_link": "domain.com/users?page=3&limit=6&offset=6",
 "current_page_link": "domain/com/users?page=1&limit=3&offset=0",
 "next_page_link": "domain.com/users?page=2&limit=3&offset=3",
 "first_page_link": "domain.com/users?page=1&limit=3&offset=0",
 "last_page_link": "domain.com/users?page=4&limit=3&offset=9",
 "n_page_link": "domain.com/users?page=X&limit=3&offset=Y"
}
```

Some clarifications about the pagination response:
- The starting page number should always be 1.
- When returning the first page, the *previous_page* property should be `NULL`.
- The parameters with the `_link` suffix are suggested when using link-oriented pagination; otherwise, they should not be included in the response body.

## 4 API Versioning

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
  api_version(:module => "V20120317", :header => {:name => "X-API-VERSION", :value => "v20120317"}) do
    match '/foos.(:format)' => 'foos#index', :via => :get
    match '/foos_no_format' => 'foos#index', :via => :get
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

[//]: #

  [Versionist]: <https://github.com/bploetz/versionist>
  [Express Routes Versioning]: <https://www.npmjs.com/package/express-routes-versioning>