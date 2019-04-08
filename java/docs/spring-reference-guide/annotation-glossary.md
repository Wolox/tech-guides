# Spring reference

## Annotations

Annotations are tags that are used as indicators or instructions for the compiler. In this section you will find a list of the most used spring annotations and brief descriptions for each of them. 

### Generic annotations 

#### `@Autowired`
It declares an attribute, constructor, setter or configuration method that generates automatically (one that doesn't need to be instantiated). 

#### `@Component`
Generic for any Spring component (controller, repository, etc.). It needs to be applied to classes that will be autowired. 

#### `@Controller`
It identifies an MVC controller. 

#### `@Qualifier`
It's used along with the `@Autowired` annotation in order to guide the autoconfiguration based on parameters other than the type (e.g.: name). 

#### `@Repository`
It identifies an MVC repository.  

#### `@RequestMapping`
It maps a URL or HTTP method to a method or controller. 

#### `@RequestParam`
It binds the parameter of a request to a method parameter. 

#### `@Service`
It identifies a service. 

#### `@Value`
It injects a value into an attribute. Said value can be set in the `application.properties` file. 

### Test annotations 

#### `@BootstrapWith`
It is used to configure how the TestContext framework boots. 

#### `@ContextConfiguration`
It defines a metadata (class-level) that determines how an ApplicationContext is loaded and configured for integration tests. It declares the context and placement of application resources (.xml files, Groovy classes, @Configuration annotated classes). 

#### `@TestPropertySource`
It is used at class-level to configure the route where the property files will be placed. 

#### `@WebAppConfiguration`
It is used at class-level to declare that the ApplicationContext is a WebApplicationContext. 

### Persistency annotations 

#### `@Column`
It identifies an attribute as a column of said table. 

#### `@Entity` 
It defines a class that can be mapped to a table. 

#### `@GeneratedValue`
It is used along with the `@Id` annotation in order to specify the generation strategy of the id. 

#### `@Id` 
It indicates that an attribute is a Primary Key in said table. 

#### `@JoinTable`, `@JoinColumn` 
They are used to indicate the relationship between tables of different entities (it specifies which attribute they have in common). 

#### `@ManyToMany`, `@OneToOne`, `@OneToMany`, `@ManyToOne` 
They are used to indicate the quantity relationship between different entities. 

--------------- 
For more information on this subject, please visit the following resources: 


* [Test annotations](https://docs.spring.io/spring/docs/current/spring-framework-reference/testing.html#integration-testing-annotations-spring)  
* Annotations in general: [1](https://www.baeldung.com/spring-core-annotations), [2](https://dzone.com/articles/a-guide-to-spring-framework-annotations) 