
# **Spring Boot Revision Questions**

## **Section 1 — Basics (15 Questions)**

1. What is Spring Boot, and how is it different from the Spring Framework?
2. What are Spring Boot starters? Give three examples.
3. What is Spring Initializr, and when do we use it?
4. Explain the purpose of the `@SpringBootApplication` annotation.
5. What are the key advantages of using Spring Boot?
6. How does Spring Boot automatically configure beans?
7. What is the default embedded server used in Spring Boot?
8. How do you change the default server port in Spring Boot?
9. Explain the role of the `application.properties` file.
10. What is the difference between `application.properties` and `application.yml`?
11. What is the purpose of the `spring-boot-devtools` dependency?
12. What is the difference between `@Controller` and `@RestController`?
13. What are the three components of the `@SpringBootApplication` annotation?
14. What are Spring Boot starter dependencies? Why are they useful?
15. How do you run a Spring Boot application using Maven and using an executable JAR?

---

## **Section 2 — REST APIs & Annotations (15 Questions)**

1. What is the difference between `@RequestParam` and `@PathVariable`?
2. How do you handle GET, POST, PUT, and DELETE requests in Spring Boot?
3. Write an example using `@GetMapping` and `@PostMapping`.
4. What is the purpose of `@RequestBody` and `@ResponseBody`?
5. How do you return JSON responses in Spring Boot?
6. What is the role of `@Autowired` in Spring Boot?
7. Explain the difference between `@Component`, `@Service`, and `@Repository`.
8. What is dependency injection in Spring Boot? Give an example.
9. How do you handle custom exceptions in Spring Boot?
10. What is the purpose of the `@ExceptionHandler` annotation?
11. How do you define global exception handling in Spring Boot?
12. What is the difference between `@GetMapping` and `@RequestMapping`?
13. How do you enable CORS in Spring Boot REST APIs?
14. What is the purpose of the `produces` and `consumes` attributes in mapping annotations?
15. How do you implement request validation using `@Valid` and `@NotNull`?

---

## **Section 3 — Data Access & JPA (10 Questions)**

1. What is Spring Data JPA, and why is it used in Spring Boot?
2. How do you configure a database connection in `application.properties`?
3. What is the difference between `CrudRepository` and `JpaRepository`?
4. How do you define custom query methods in a repository interface?
5. What is the purpose of the `@Entity` annotation?
6. How do you map one-to-many and many-to-many relationships in Spring Boot JPA?
7. How do you handle transactions in Spring Boot?
8. What is the role of `@Transactional` annotation?
9. How do you execute native SQL queries in Spring Data JPA?
10. What is lazy loading vs. eager loading in JPA?

---

## **Section 4 — Asynchronous Programming & Microservices (10 Questions)**

1. How do you enable asynchronous processing in Spring Boot?
2. What is the purpose of the `@Async` annotation?
3. How does Spring Boot handle background tasks?
4. How do you create and consume REST APIs between microservices?
5. What is Spring Cloud, and how does it relate to Spring Boot?
6. How do you implement service discovery using Spring Boot?
7. What is the difference between synchronous and asynchronous communication in microservices?
8. What is Spring Boot Actuator, and why is it useful?
9. How do you enable health checks and metrics using Actuator?
10. What is the difference between `@EnableScheduling` and `@EnableAsync`?

---

## **Section 5 — Spring Boot Security (5 Questions)**

1. How do you secure a REST API in Spring Boot?
2. What is Spring Security, and how does it integrate with Spring Boot?
3. How do you configure basic authentication in Spring Boot?
4. How do you implement JWT authentication in Spring Boot?
5. How do you restrict access to specific endpoints based on user roles?

---

## **Section 6 — Hands-On Coding Practice (10 Problems)**

> For students to **revise concepts by coding**.

1. Create a **Spring Boot REST API** to manage a list of employees.
2. Implement an endpoint to fetch a student by **ID** using `@PathVariable`.
3. Build a **POST endpoint** that accepts JSON data and stores it in a list.
4. Create a **PUT endpoint** to update product details in memory.
5. Write code to handle a **custom exception** using `@ControllerAdvice`.
6. Configure an **in-memory H2 database** and fetch data using Spring Data JPA.
7. Implement an endpoint to **fetch all users from MySQL** using `JpaRepository`.
8. Enable **Actuator** and display health, metrics, and environment endpoints.
9. Create a **scheduled job** that runs every 5 seconds using `@Scheduled`.
10. Implement an **asynchronous task** using `@Async` and return results via REST API.

