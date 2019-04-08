# Spring reference

## Troubleshooting

In this section you will find a list of some common issues that can occur during development, along with possible ways to fix them. 

#### `Failed to load application context`
Possible solutions: 
* Remove @Repository` annotations. 
* Add this annotation in the testcase: `@AutoconfigureTestDatabase(replace = NONE)`
* Check inner exceptions for clear problems that could be causing the issue.
* Verify that the configuration class is properly defined. 
* Add the `@Component` annotation in classes that will be Autowired.

#### `401 / 403 unauthorized error`
Possible solutions: 
* Add `@WebMvcTest(secure = false)` in the test annotation. This will isolate the test, focusing on the functionality rather than the security layer. 
* Add `.with(csrf())` in the methods that perform an HTTP request on the mockMvc (use the following library: `org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf)`). 
* Add `.with(testUser())` in methods that perform an HTTP request on the mockMvc.  

#### `Found multiple declarations of @BootstrapWith`
Possible solutions: 
* Make sure that there is one and only one annotation related to test boot. For example, `@RunWith(SpringRunner.class)` and `@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)` cannot be used simultaneously. 

#### `At least one JPA metamodel must be present!` or `No bean named ‘entityManagerFactory’ available`
Possible solutions: 
* Make sure that the annotations `@EntityScan` and `@EnableJpaRepositories` haven't been used. 

#### `Tests are not injected` 
Possible solutions: 
* Make sure that you're not using the Jupiter junit dependency, but that of springboot: `org.springframework.boot:spring-boot-starter-test`. 

#### `NullpointerException when trying to use @Autowired`
Possible solutions: 
* Make sure you haven't manually instantiated the class you're trying to autowire. 
* Make sure you've properly set the annotations `@Component`, `@Service`, `@Repository`, `@Controller` in the class that you're trying to autowire. 

