Absolutely 🙂
Instead of a **Student Management System**, we can choose a **different, slightly complex, real-world use case** that better demonstrates **Spring Boot’s `@Service` annotation** and multi-layered architecture.

I’ll propose **three alternative use cases** and then detail **one** into a full-fledged lab for students.

---

## **Alternative Use Case Options**

### **Option 1 — Online Bookstore API** 📚 *(Recommended)*

* **Description:**
  Build a REST API to manage books, customers, and orders.
* **Key Features:**

  * Add, update, and delete books
  * Search books by title/author
  * Place an order for one or more books
  * Fetch customer orders
* **Why it’s good:**
  Involves multiple entities and relationships, perfect for understanding `@Service`.

---

### **Option 2 — Employee Payroll Management** 💼

* **Description:**
  Build an application to manage employees, departments, and salary slips.
* **Key Features:**

  * Add employees and assign them to departments
  * Calculate monthly salaries based on grade and attendance
  * Generate payslips
* **Why it’s good:**
  Demonstrates business logic in the service layer (salary calculations, tax deductions).

---

### **Option 3 — Movie Ticket Booking System** 🎟️

* **Description:**
  Build an app to handle movie listings, seat bookings, and ticket payments.
* **Key Features:**

  * Add movies and show timings
  * Book seats for a movie
  * Generate booking confirmations
* **Why it’s good:**
  Allows students to work on **transactional operations** in the `@Service` layer.

---

Since we want a **fairly complex but manageable** lab, I recommend **Option 1: Online Bookstore API**.
I’ll now design the complete **lab** around it.

---

## **Lab Title**

**Building an Online Bookstore REST API Using `@Service` in Spring Boot**

---

## **Use Case Scenario** 🎯

You’re developing a **Bookstore Management API** for **Crux Books**.
The API will:

* Manage **books**
* Allow **customers** to register
* Let customers **place orders**
* Fetch customer details along with their **order history**

---

## **Entities**

1. **Book**

   * `id`, `title`, `author`, `price`, `stock`
2. **Customer**

   * `id`, `name`, `email`
3. **Order**

   * `id`, `customerId`, `bookId`, `quantity`, `totalPrice`

---

## **Learning Objectives** ✅

Students will:

1. Understand **Spring Boot layered architecture**.
2. Use **`@Service`** to implement business logic.
3. Handle **relationships** between entities.
4. Use **Spring Data JPA** with **H2 database**.
5. Build and test **REST APIs**.

---

## **Step 1 — Project Setup**

* Use [Spring Initializr](https://start.spring.io/)
* Project: **Maven**
* Dependencies:

  * Spring Web
  * Spring Data JPA
  * H2 Database
  * Lombok *(optional but recommended)*

---

## **Step 2 — Project Structure**

```
src/main/java/com/crux/bookstore
    ├── controller
    │      ├── BookController.java
    │      ├── CustomerController.java
    │      └── OrderController.java
    ├── service
    │      ├── BookService.java
    │      ├── CustomerService.java
    │      └── OrderService.java
    ├── repository
    │      ├── BookRepository.java
    │      ├── CustomerRepository.java
    │      └── OrderRepository.java
    ├── model
    │      ├── Book.java
    │      ├── Customer.java
    │      └── Order.java
    └── BookstoreApplication.java
```

---

## **Step 3 — Configure H2 Database**

**`application.properties`**

```properties
spring.datasource.url=jdbc:h2:mem:bookstoredb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=update
```

---

## **Step 4 — Create Book Entity**

```java
package com.crux.bookstore.model;

import jakarta.persistence.*;

@Entity
@Table(name = "books")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String author;
    private double price;
    private int stock;

    public Book() {}
    public Book(String title, String author, double price, int stock) {
        this.title = title; this.author = author;
        this.price = price; this.stock = stock;
    }

    // Getters and Setters...
}
```

---

## **Step 5 — Create Repository**

```java
package com.crux.bookstore.repository;

import com.crux.bookstore.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}
```

*(Similar repositories for Customer and Order.)*

---

## **Step 6 — Create Service Layer**

**File:** `service/BookService.java`

```java
package com.crux.bookstore.service;

import com.crux.bookstore.model.Book;
import com.crux.bookstore.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service   // Business logic here
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public Book addBook(Book book) {
        return bookRepository.save(book);
    }

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book updateStock(Long bookId, int newStock) {
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new RuntimeException("Book not found!"));
        book.setStock(newStock);
        return bookRepository.save(book);
    }
}
```

**Key Highlight:**

* All **business logic** (e.g., stock updates) resides in the `@Service` layer.
* Controllers remain **thin** and focused on **request/response handling**.

---

## **Step 7 — Create Controller**

**File:** `controller/BookController.java`

```java
package com.crux.bookstore.controller;

import com.crux.bookstore.model.Book;
import com.crux.bookstore.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @PostMapping
    public Book addBook(@RequestBody Book book) {
        return bookService.addBook(book);
    }

    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @PutMapping("/{id}/stock/{newStock}")
    public Book updateStock(@PathVariable Long id, @PathVariable int newStock) {
        return bookService.updateStock(id, newStock);
    }
}
```

---

## **Step 8 — Test APIs Using Postman**

| **Endpoint**            | **Method** | **Body**                                                                              | **Description** |
| ----------------------- | ---------- | ------------------------------------------------------------------------------------- | --------------- |
| `/api/books`            | POST       | `{ "title": "Spring in Action", "author": "Craig Walls", "price": 550, "stock": 20 }` | Add book        |
| `/api/books`            | GET        | —                                                                                     | Get all books   |
| `/api/books/1/stock/30` | PUT        | —                                                                                     | Update stock    |

---
