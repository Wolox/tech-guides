## Models VS ViewModels

**Models**

They are data objects, without any type of logic. They usually come from the communication to APIs, since they normally represent business concepts from the app.

```
struct Dog {
  let id: UInt
  let name: String
  let dob: NSDate
  let picture: NSURL
}
```

**ViewModels**

They contain the necessary logic for handling the models. They can include any type of processing necessary to show, search, order, and more, the information. It's the layer that translate data into whatever needed for its specific contextual use. This means that a view model can handle other "smaller" viewModels as well as models (smaller in the sense of how much logic they cover). To obtain the behaviour wanted over the data, usually view models relate other objects that handle different things so as to get the final unique wanted result. These other objects can be found to be
Repositories or Services (seen afterwards), from which to obtain or send models and be able to do some processing over them.

```
class DogViewModel {

  let dog: Dog

  init(dog: Dog) {
    self.dog = dog
  }

  var ageInYears: UInt {
    let now = NSDate.now()
    return now.yearsSince(dog.dob) // this is a custom func which returns how many years
                                   // passed between the parameter and self
  }

}

```

```
class DogHouseViewModel {

  let dogRepository: DogRepository

  func getDogsYoungerThan(years: UInt) -> [DogViewModel] {
    return dogRepository.fetchAllDogs()
                         .map { DogViewModel(dog: $0) }
                         .filter { dogVM in return dogVM.ageInYears < years }
  }

}
```

## Repositories VS Services

**Repositories**

They are objects that expose methods for getting (`.GET`), modifying (`.PUT`), deleting (`.DELETE`) or adding (`.POST`) models. They are the ones that allow for the app to have a state, and they are the ones to be mocked in tests. Repositories are the way of communicating with an API: in each repository we try to have only one relation between the models handled and the use the context gives them. For example:

```
  class DogRepository {

    func fetchAllDogs() -> [Dog]
    func enrollDog(dog: Dog)
    func releaseDog(dog: Dog)

  }

```


```
  class AdoptionRepository {

    func requestAdoption(adoption: Adoption) -> AdoptionRequest
    func approveAdoption(adoptionRequest: AdoptionRequest)
    func rejectAdoption(adoptionRequest: AdoptionRequest)

  }

```

**Services**

They are the objects used for handling any auxiliary task int he system. An example of a service may be a device geolocation administrator (a wrapper to `CLLocation`), an image fetcher, and more things that are not directly related to the app business.

For the second example, we'd have:
```
  class ImageFetcher {

    func fetchImage(url: NSURL) -> UIImage

  }
```

## Controllers VS ViewModels

All the data that controllers need must come from a view model. Even if a controller needed to create another controller, the information that new controller would need can't come from this father controller itself: only a view model can create another view model, a controller doesn't know (and doesn't care) what information that new controller and view model need.
Controllers only need the information that concerns communication to and from the visual interface (this means, what to do to react to user triggered events and what data to show on the screen).

## Extensions VS Subclasses

Even if both take care of enlarging a class functionality, subclassing is more restrictive of the possible directions in which that class may grow. This is why delegation or protocol conformance is preferred to subclassing.
However, when the logic that we want to reuse is a lot, or is complex and needs state, when the functionality to add isn't a simple self-contained/self-dependent function, subclassing may become necessary.

Extension examples:
```
protocol AdopterType {
  var fullName: String
  func getBackgroundCheck() -> BackgroundCheck

}

extension AdopterType {

  func getBackgroundCheck() -> BackgroundCheck {
    // Checks full name in reliable databases and gets info
  }

}

class RegisteredAdopter: AdopterType {
   let fullName: String
   let ssn: String

   init(name: String, ssn: String) {
       self.fullName = name
       self.ssn = ssn
   }

   func getBackgroundCheck() -> BackgroundCheck {
    // Checks ssn in national database
   }

}

class UnregisteredAdopter {
  let fullName: String

  init(name: String) {
    self.fullName = name
   }

}
```

A great example on subclassing are the Repositories, which will inherit from `BaseRepository`.
