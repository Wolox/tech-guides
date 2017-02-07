## Modelos VS ViewModels

**Modelos**

Son objetos de datos, sin ningún tipo de lógica. Suelen provenir de la comunicación con APIs, dado que suelen representar conceptos del negocio de la aplicación.

```
struct Dog {
  let id: UInt
  let name: String
  let dob: NSDate
  let picture: NSURL
}
```

**ViewModels**

Contienen la lógica para manejar los modelos. Pueden incluir cualquier procesamiento necesario para mostrar, buscar, ordenar, etc. la información. Es la capa que traduce los datos a lo que sea que se necesite de ellos para su uso contextual. Esto quiere decir que un viewModel puede contener tanto modelos como a otros viewModels más "pequeños" (en el sentido de cantidad de lógica que incluyen). Para llegar al comportamiento que se quiere sobre los datos, usualmente los ViewModels relacionan otros objetos que se encargan de distintas cosas para obtener un resultado final. Suelen usar Repositorios o Servicios (vistos más adelante) para obtener o enviar modelos y hacer sobre ellos el procesamiento necesario.

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

## Servicios VS Repositorios

**Repositorios**

Son objetos que exponen los métodos para obtener (`.GET`), modificar (`.PUT`), eliminar (`.DELETE`) o agregar (`.POST`) modelos. Son aquellos que permiten guardar el estado de la aplicación y que se mockean en los tests. Son la forma de comunicarse con alguna API, en cada repositorio se intenta que haya una relación entre los modelos que se gestionan y el uso que les da cada contexto. Por ejemplo:
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

**Servicios**

Son objetos que se usan para realizar alguna tarea auxiliar en el sistema. Un ejemplo de un servicio podría ser un administrador de la geolocalización del dispositivo (un wrapper de `CLLocation`), un encargado de fetchear imagenes dada una URL, etc.

Para el segundo ejemplo tendríamos:
```
  class ImageFetcher {

    func fetchImage(url: NSURL) -> UIImage

  }
```

## Controllers VS ViewModels

Todos los datos que los controllers necesitan deben ser obtenidos mediante un view model. Aún si un controller precisara crear a otro controller, sólo un view model puede crear a otro view model. Esto es porque los controllers no pueden conocer la información necesaria para crear a otro view model.
Los controllers sólo necesitan información para comunicar a la interfaz visual o viceversa (es decir, los eventos que produce el usuario y los datos que se muestran en la vista).

## Extensiones VS Subclases

Si bien ambas se encargan de ampliar la funcionalidad de una clase, la herencia es restrictiva en cuanto a las posibles direcciones de crecimiento de la misma. Es por esto que se busca delegar o aplicar protocolos en lugar de hacer subclases.
Sin embargo, cuando es mucha la lógica a reusar, necesita estado y la funcionalidad a agregar no es una simple función autocontenida/autosuficiente es necesaria la herencia.

Ejemplos de extensión
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
Un buen ejemplo de subclase son los repositorios (que heredan de `BaseRepository`).
