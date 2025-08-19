package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello, Spring Boot!";
    }

    @GetMapping("/greet")
    public String greet() {
        return "Greetings from Spring Boot!";
    }

    // -------- PathVariable Example --------
    // URL: http://localhost:8080/welcome/Rahul
    @GetMapping("/welcome/{name}")
    public String welcome(@PathVariable String name) {
        return "Welcome, " + name + "!";
    }

    // -------- RequestParam Example --------
    // URL: http://localhost:8080/sayHello?name=Priya
    @GetMapping("/sayHello")
    public String sayHello(@RequestParam String name) {
        return "Hello, " + name + "!";
    }
}


/*
How to test:

http://localhost:8080/hello
→ Hello, Spring Boot!

http://localhost:8080/greet
→ Greetings from Spring Boot!

http://localhost:8080/welcome/Rahul
→ Welcome, Rahul! (PathVariable)

http://localhost:8080/sayHello?name=Priya
→ Hello, Priya! (RequestParam)
                 */
