

## **Steps to Create a Spring Boot App for User Authentication**

---

## **1. Go to Spring Initializr**

* Open **[https://start.spring.io](https://start.spring.io)**

### **Project Settings**

* **Project** → Maven
* **Language** → Java
* **Spring Boot** → Latest stable (e.g., 3.x)
* **Group** → `com.demo`
* **Artifact** → `user-auth`
* **Packaging** → Jar
* **Java Version** → 17 or above

---

## **2. Add Dependencies**

Select these dependencies:

* **Spring Web** → For REST APIs / MVC
* **Spring Security** → For authentication & authorization
* **Spring Boot DevTools** *(optional, for hot reload)*
* **Thymeleaf** *(optional, if you want simple HTML pages)*

> For now, we’ll keep authentication **in-memory** — no database.

Click **Generate** → A ZIP file will download.

---

## **3. Import Project into IDE**

* Unzip the downloaded file.
* Open in **Eclipse** (or IntelliJ).
* Wait for Maven to download dependencies.

---

## **4. Project Structure**

```
user-auth/
│── src/main/java
│   └── com.demo.userauth
│       ├── UserAuthApplication.java    // Main app class
│       ├── config
│       │   └── SecurityConfig.java     // Security setup
│       ├── controller
│       │   └── HomeController.java     // Handles pages
│── src/main/resources
│   ├── templates
│   │   ├── home.html
│   │   ├── login.html
│   └── application.properties
```

---

## **5. Create the Main Class**

**`UserAuthApplication.java`**

```java
package com.demo.userauth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class UserAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(UserAuthApplication.class, args);
    }
}
```

---

## **6. Configure Spring Security**

**`SecurityConfig.java`**

```java
package com.demo.userauth.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    // In-memory authentication
    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        UserDetails user = User.withDefaultPasswordEncoder()
                .username("ravi")
                .password("password123")
                .roles("USER")
                .build();

        UserDetails admin = User.withDefaultPasswordEncoder()
                .username("admin")
                .password("admin123")
                .roles("ADMIN")
                .build();

        return new InMemoryUserDetailsManager(user, admin);
    }

    // Configure URL access rules
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/home").permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(Customizer.withDefaults()) // Enables default login page
            .logout(Customizer.withDefaults());   // Enables default logout

        return http.build();
    }
}
```

---

## **7. Create a Simple Controller**

**`HomeController.java`**

```java
package com.demo.userauth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/home")
    public String home() {
        return "home"; // Renders home.html
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard"; // Renders dashboard.html
    }
}
```

---

## **8. Create HTML Pages**

Inside `src/main/resources/templates`:

**`home.html`**

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Home</title>
</head>
<body>
    <h2>Welcome to User Authentication Demo</h2>
    <p><a href="/dashboard">Go to Dashboard</a></p>
    <p><a href="/logout">Logout</a></p>
</body>
</html>
```

**`dashboard.html`**

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Dashboard</h2>
    <p>You are logged in successfully!</p>
    <p><a href="/logout">Logout</a></p>
</body>
</html>
```

> Spring Security automatically provides a **default login page** at `/login`.

---

## **9. Configure Application Properties**

**`application.properties`**

```properties
spring.thymeleaf.cache=false
server.port=8080
```

---

## **10. Run the App**

```bash
mvn spring-boot:run
```

Or run from **Eclipse → Right-click → Run As → Spring Boot App**.

---

## **11. Test the App**

* Open **[http://localhost:8080/home](http://localhost:8080/home)** → Accessible without login.
* Open **[http://localhost:8080/dashboard](http://localhost:8080/dashboard)** → Redirects to **login page**.
* Use:

  * Username: `ravi`
    Password: `password123`
* After login → You’ll see the dashboard.

---

## **Demo Highlights**

✅ Uses **Spring Boot** + **Spring Security**
✅ **In-memory user authentication**
✅ Default **login & logout** functionality
✅ Simple **home** and **dashboard** pages
