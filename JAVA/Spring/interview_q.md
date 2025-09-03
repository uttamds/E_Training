Got it 🙂
You want **Java + Spring Boot interview questions** that are **practical**, **concept-oriented**, and **suitable for students or fresher-to-intermediate developers**.
I’ll prepare **50 interview questions** divided into **basic**, **intermediate**, and **scenario-based** levels with a mix of **theory**, **code-based**, and **real-world application** questions.

---

# **Java + Spring Boot Interview Questions**

---

## **A. Basic-Level (Java + Spring Boot Fundamentals)** *(15 Questions)*

**Q1.** What is Spring Boot, and how is it different from the Spring Framework?
**Answer:** Spring Boot simplifies Spring app development by providing **auto-configuration**, an **embedded server**, and **production-ready defaults**, whereas Spring Framework requires manual configuration.

---

**Q2.** What is the main purpose of the `@SpringBootApplication` annotation?
a) Enables component scanning
b) Enables auto-configuration
c) Enables configuration properties
d) **All of the above ✅**

---

**Q3.** What are **starters** in Spring Boot?
**Answer:** Starters are pre-configured dependencies, e.g., `spring-boot-starter-web` for REST APIs, reducing boilerplate Maven/Gradle setup.

---

**Q4.** What is the role of the **embedded Tomcat server** in Spring Boot?
**Answer:** Spring Boot applications run as standalone apps with **embedded servers** like Tomcat, Jetty, or Undertow, so no separate server deployment is needed.

---

**Q5.** Which annotation is used to expose a REST API in Spring Boot?
a) `@RestController` ✅
b) `@Controller`
c) `@RequestMapping`
d) `@GetMapping`

---

**Q6.** What is the purpose of the `application.properties` or `application.yml` file?
**Answer:** It is used for **external configuration** like database connections, logging levels, port numbers, etc.

---

**Q7.** How do you change the default port of a Spring Boot application?

* **Answer:** In `application.properties` →

  ```properties
  server.port=8085
  ```

---

**Q8.** Explain **Inversion of Control (IoC)** in Spring.
**Answer:** IoC means **Spring manages object creation and lifecycle** instead of manual instantiation via `new`.

---

**Q9.** What are **Beans** in Spring Boot?
**Answer:** Beans are **objects** managed by the **Spring IoC container**, created using annotations like `@Component`, `@Service`, `@Repository`, or via `@Bean` methods.

---

**Q10.** What is the difference between `@Controller` and `@RestController`?

* `@Controller` → Returns a **view (HTML/JSP)**.
* `@RestController` → Returns **JSON/XML** response.

---

**Q11.** What is **Spring Boot Auto-Configuration**?
**Answer:** Spring Boot automatically configures beans based on the classpath, starter dependencies, and settings in `application.properties`.

---

**Q12.** What are Profiles in Spring Boot?
**Answer:** Profiles allow environment-specific configurations (e.g., `dev`, `test`, `prod`) using:

```properties
spring.profiles.active=dev
```

---

**Q13.** Which annotation is used to bind configuration values from `application.properties`?
a) `@Value` ✅
b) `@Autowired`
c) `@PropertySource`
d) `@ConfigurationProperties`

---

**Q14.** What are the main advantages of Spring Boot?

* Less boilerplate code
* Embedded servers
* Production-ready features
* Microservices-friendly architecture ✅

---

**Q15.** What are Spring Boot Starters? Give examples.
**Answer:**
Starters simplify dependency management:

* `spring-boot-starter-web` → REST APIs
* `spring-boot-starter-data-jpa` → Database operations
* `spring-boot-starter-security` → Authentication & authorization

---

## **B. Intermediate-Level (Core Spring Boot + Java)** *(20 Questions)*

**Q16.** What is the difference between `@Component`, `@Service`, and `@Repository`?

* `@Component` → Generic Spring bean
* `@Service` → Business logic layer
* `@Repository` → DAO layer, adds database exception translation

---

**Q17.** What is the purpose of the `@Autowired` annotation?
**Answer:** Used for **dependency injection** automatically by Spring.

---

**Q18.** What are **Spring Boot Actuators**?
**Answer:** Production-ready endpoints to monitor app health, metrics, logs, etc.
Example: `http://localhost:8080/actuator/health`.

---

**Q19.** How do you handle **exception handling** in Spring Boot REST APIs?

* Use `@ControllerAdvice` + `@ExceptionHandler`.
  Example:

```java
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        return new ResponseEntity<>("Error: " + e.getMessage(), HttpStatus.BAD_REQUEST);
    }
}
```

---

**Q20.** What is Spring Boot DevTools used for?
**Answer:** Enables **automatic application restart** and **hot-reloading** during development.

---

**Q21.** What is the difference between `@RequestParam` and `@PathVariable`?

* `@RequestParam` → Query parameters
* `@PathVariable` → URL path variables

Example:

```java
@GetMapping("/user")
public String getUser(@RequestParam String name) {...}

@GetMapping("/user/{id}")
public String getUser(@PathVariable int id) {...}
```

---

**Q22.** What is the difference between **Spring Data JPA** and **Hibernate**?

* Hibernate → ORM framework.
* Spring Data JPA → Abstraction over Hibernate with **simpler repository APIs**.

---

**Q23.** How do you connect a Spring Boot app to a database?
In `application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/db
spring.datasource.username=root
spring.datasource.password=1234
spring.jpa.hibernate.ddl-auto=update
```

---

**Q24.** What is the use of `@Transactional` annotation?
**Answer:** Ensures **atomicity** for database operations, rolling back automatically on failure.

---

**Q25.** What is the difference between `@Configuration` and `@Bean`?

* `@Configuration` → Marks a class containing bean definitions.
* `@Bean` → Creates a bean explicitly inside a `@Configuration` class.

---

**Q26.** What is **Spring Boot Starter Test**?
**Answer:** A testing starter (`spring-boot-starter-test`) that includes JUnit, Mockito, and Spring Test for unit and integration testing.

---

**Q27.** How does Spring Boot manage logging?

* Uses **Spring Boot Logging** (based on Logback).
* Configurable via `application.properties`.

---

**Q28.** What are Spring Boot Filters and Interceptors?

* **Filters** → Pre/post-process **HTTP requests**.
* **Interceptors** → Pre/post-process **controller method calls**.

---

**Q29.** How do you secure a REST API in Spring Boot?

* Use **Spring Security** starter:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

* Configure `WebSecurityConfigurerAdapter`.

---

**Q30.** What are `CommandLineRunner` and `ApplicationRunner`?
**Answer:** They execute code after Spring Boot starts, often used for initializing data.

---

**Q31.** How do you enable CORS in Spring Boot?

```java
@CrossOrigin(origins = "http://localhost:3000")
@GetMapping("/data")
public List<Data> getData() { ... }
```

---

**Q32.** What are the different scopes of beans in Spring Boot?

* `singleton` (default) ✅
* `prototype`
* `request`
* `session`

---

**Q33.** What is the difference between `CrudRepository` and `JpaRepository`?

* `CrudRepository` → Basic CRUD only.
* `JpaRepository` → Extends CrudRepository + paging & sorting.

---

**Q34.** How does Spring Boot simplify testing REST APIs?

* `@SpringBootTest` for integration tests.
* `MockMvc` for simulating HTTP requests.

---

**Q35.** How do you schedule tasks in Spring Boot?

```java
@EnableScheduling
@Component
public class Scheduler {
    @Scheduled(fixedRate = 5000)
    public void task() { ... }
}
```

---

## **C. Scenario-Based + Advanced (Microservices, Real Projects)** *(15 Questions)*

**Q36.** How do you create a simple REST API in Spring Boot?
**Answer:**

```java
@RestController
@RequestMapping("/api")
public class HelloController {
    @GetMapping("/hello")
    public String sayHello() {
        return "Hello Spring Boot!";
    }
}
```

---

**Q37.** How does Spring Boot handle Microservices architecture?

* With **Spring Cloud** + **Eureka** + **Feign** + **API Gateway**.

---

**Q38.** How do you implement **pagination** in Spring Boot REST APIs?
Use `Pageable` with Spring Data JPA:

```java
@GetMapping("/users")
public Page<User> getUsers(Pageable pageable) {
    return userRepo.findAll(pageable);
}
```

---

**Q39.** How do you handle **global exceptions** in REST APIs?
Use `@ControllerAdvice` (see **Q19**).

---

**Q40.** How does Spring Boot support **asynchronous processing**?
Use `@EnableAsync` + `@Async` for non-blocking execution.

---

**Q41.** How do you configure Spring Boot for **multiple data sources**?

* Create two `DataSource` beans.
* Use `@Primary` and qualifiers to switch between them.

---

**Q42.** How do you deploy a Spring Boot app to production?

* Package as `.jar` → `java -jar app.jar`
* Or deploy to Docker, Kubernetes, or cloud platforms.

---

**Q43.** How do you enable API documentation in Spring Boot?

* Use **SpringDoc OpenAPI** or **Swagger**:

```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-ui</artifactId>
</dependency>
```

---

**Q44.** What is the difference between `RestTemplate` and `WebClient`?

* `RestTemplate` → Synchronous HTTP calls.
* `WebClient` → Asynchronous, non-blocking, and preferred in Spring WebFlux.

---

**Q45.** How does Spring Boot integrate with Kafka or RabbitMQ?

* Use starters like `spring-boot-starter-amqp` or `spring-kafka` for message queues.

---

**Q46.** What is the difference between Monolithic and Microservices architecture?

* Monolithic → One large deployable unit.
* Microservices → Small, independent services communicating via APIs.

---

**Q47.** How do you enable HTTPS in Spring Boot?

* Generate SSL cert → Configure in `application.properties`:

```properties
server.ssl.key-store=classpath:keystore.p12
server.ssl.key-store-password=secret
server.ssl.key-store-type=PKCS12
server.port=8443
```

---

**Q48.** How do you improve Spring Boot app performance?

* Use caching (`@Cacheable`)
* Enable query optimizations
* Use connection pooling
* Tune JVM parameters

---

**Q49.** How do you create custom starter dependencies in Spring Boot?

* Build a starter module with predefined configs and dependencies.

---

**Q50.** What’s new in Spring Boot 3 compared to Spring Boot 2?

* Native support for **Jakarta EE**
* Built-in **GraalVM Native Image**
* Improved observability via **Micrometer**
* Better container support

---
