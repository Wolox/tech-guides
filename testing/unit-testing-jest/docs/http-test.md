
## HttpClientTestingModule
To test services with the [HttpClient](https://angular.io/api/common/http/HttpClient) dependency, we can use the utilities of Angular testing. We don't need to use all the object utilities of HttpClient, so we use [HttpClientTestingModule](https://angular.io/api/common/http/testing/HttpClientTestingModule#description) to test, this is a soft module designed just for testing. For example:
```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Car } from '../models/cars';

@Injectable({ providedIn: 'root' })
export class CarService {
  constructor(private http: HttpClient) {}

  findCarById(carId: number): Observable<Car> {
    return this.http.get<Car>(`api/cars/${carId}`);
  }

  findAllCars(): Observable<Car[]> {
    return this.http.get('api/cars') as Observable<Car[]>;
  }

  saveCar(carId: number, changes: Partial<Car>): Observable<Car> {
    return this.http.put<Car>(`api/cars/${carId}`, changes);
  }
}
```

```ts
import { TestBed } from '@angular/core/testing';
import {
  HttpClientTestingModule,
  HttpTestingController,
} from '@angular/common/http/testing';
import { CARS } from '../data/data';
import { CarService } from './car.service';
import { of } from 'rxjs';

describe('CarService Using HttpClientTestingModule', () => {
  let service: CarService;
  let controller: HttpTestingController;
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [],
    });

    service = TestBed.inject(CarService);
    controller = TestBed.inject(HttpTestingController);
  });

  it('create', () => {
    expect(service).toBeTruthy();
  });
```
In this section, we configure the testing module with the dependency HttpClientTestingModule


```ts
it('return all cars', (done) => {
    service.findAllCars().subscribe((cars) => {
      expect(cars).toEqual(CARS);
      done();
    });
    const req = controller.expectOne('api/cars');
    expect(req.request.method).toEqual('GET');
    req.flush(CARS);
  });
```
In this test, we subscribe to ```findAllCars```. Then, inside we create the assertion to verify the response data. ```done()``` is used to indicate the successful finish of the subscription.

With the [controller](https://angular.io/api/common/http/testing/HttpTestingController) we can mock and flush the request.


```ts
it('Should return car with specific Id', (done) => {
    const car = CARS[0];
    service.findCarById(car.id).subscribe((selectedCar) => {
      expect(selectedCar).toEqual(car);
      done();
    }, done.fail);
    const req = controller.expectOne(`api/cars/${car.id}`);
    expect(req.request.method).toEqual('GET');
    req.flush(car);
  });

  it('should update car', (done) => {
    const car = CARS[0];
    car.info.name = 'Mazda';
    service.saveCar(car.id, car).subscribe((updatedCar) => {
      expect(updatedCar).toEqual(car);
      done();
    }, done.fail);
    const req = controller.expectOne(`api/cars/${car.id}`);
    expect(req.request.method).toEqual('PUT');
    expect(req.request.body.info.name).toEqual(car.info.name);

    req.flush(car);
  });

  afterEach(() => {
    controller.verify();
  });
});
```
Finally, in the afterEach we can verify that no unmatched requests are outstanding.
