
## HttpClientTestingModule
To test services with the [HttpClient](https://angular.io/api/common/http/HttpClient) dependency, we can use the utilities of Angular testing. We don't need to use all the object utilities of HttpClient, so we use [HttpClientTestingModule](https://angular.io/api/common/http/testing/HttpClientTestingModule#description) to test, this is a soft module designed just for testing. For example:
```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { User } from '../models/user';

@Injectable({ providedIn: 'root' })
export class UserService {
  constructor(private http: HttpClient) {}

  findUserById(userId: number): Observable<User> {
    return this.http.get<User>(`api/users/${userId}`);
  }

  findAllUsers(): Observable<User[]> {
    return this.http.get('api/users') as Observable<User[]>;
  }

  saveUser(useId: number, changes: Partial<User>): Observable<User> {
    return this.http.put<User>(`api/user/${useId}`, changes);
  }
}
```

```ts
import { TestBed } from '@angular/core/testing';
import {
  HttpClientTestingModule,
  HttpTestingController,
} from '@angular/common/http/testing';
import { of } from 'rxjs';
import { USERS } from '../data/data';
import { UserService } from './user.service';

describe('UserService Using HttpClientTestingModule', () => {
  let service: UserService;
  let controller: HttpTestingController;
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [],
    });

    service = TestBed.inject(UserService);
    controller = TestBed.inject(HttpTestingController);
  });

  it('create', () => {
    expect(service).toBeTruthy();
  });
```
In this section, we configure the testing module with the dependency HttpClientTestingModule.
Moreover, we don't need a fixture on this configuration due to the fact tha this is just a service 
and not a layout.

So, first of all we need to init the following variables:

1. The service
   a. `let service: UserService;`
   b. `service = TestBed.inject(userService);`

When using the `TestBed.inject` we are getting the instance of the injected dependency. This **doesn't** mean that
we are injecting this dependency twice. 

2. The controller
   a. `let controller: HttpTestingController;`
   b. `controller = TestBed.inject(HttpTestingController);`

In fact, the controller variable is optional, however, this dependency will help us to create more complete
tests cases.


```ts
it('return all users', (done) => {
  service.findAllUsers().subscribe((users) => {
    expect(users).toEqual(USERS);
    done();
  });
  const req = controller.expectOne('api/users');
  expect(req.request.method).toEqual('GET');
  req.flush(USERS);
});
```
In this test, we subscribe to ```findAllUsers```. Then, inside we create the assertion to verify the response data. ```done()``` is used to indicate the successful finish of the subscription.

With the [controller](https://angular.io/api/common/http/testing/HttpTestingController) we can mock and flush the request.


```ts
it('Should return user with specific Id', (done) => {
    const user = USERS[0];
    service.findUserById(user.id).subscribe((selectedUser) => {
      expect(selectedUser).toEqual(user);
      done();
    }, done.fail);
    const req = controller.expectOne(`api/user/${user.id}`);
    expect(req.request.method).toEqual('GET');
    req.flush(user);
  });

  it('should update user', (done) => {
    const user = USERS[0];
    user.info.name = 'Andres';
    service.saveUser(user.id, user).subscribe((updatedUser) => {
      expect(updatedUser).toEqual(user);
      done();
    }, done.fail);
    const req = controller.expectOne(`api/user/${user.id}`);
    expect(req.request.method).toEqual('PUT');
    expect(req.request.body.info.name).toEqual(user.info.name);

    req.flush(user);
  });

  afterEach(() => {
    controller.verify();
  });
});
```
Finally, in the afterEach we can verify that no unmatched requests are outstanding.
