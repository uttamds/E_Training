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



=========================
    Hello Controller revised for UI based demo
========================

package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    // API endpoint: http://localhost:8080/api/greet?name=Rahul
    @GetMapping("/api/greet")
    public String greet(@RequestParam String name) {
        return "Hello, " + name + " from Spring Boot!";
    }
}


==========================

hrml file to be created under  src/main/resources/static
=========================
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Spring Boot Demo App</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      margin-top: 50px;
      background: #f5f7fa;
    }
    h1 {
      color: #2c3e50;
    }
    input, button {
      padding: 8px 12px;
      margin: 5px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }
    button {
      background-color: #3498db;
      color: white;
      cursor: pointer;
    }
    button:hover {
      background-color: #2980b9;
    }
    #result {
      margin-top: 20px;
      font-size: 18px;
      color: green;
    }
  </style>
</head>
<body>
  <h1>Spring Boot + HTML Demo</h1>
  <input type="text" id="nameInput" placeholder="Enter your name">
  <button onclick="getGreeting()">Get Greeting</button>

  <div id="result"></div>

  <script>
    async function getGreeting() {
      const name = document.getElementById("nameInput").value;
      if (!name) {
        alert("Please enter a name!");
        return;
      }
      try {
        const response = await fetch(`http://localhost:8080/api/greet?name=${name}`);
        const text = await response.text();
        document.getElementById("result").innerText = text;
      } catch (err) {
        document.getElementById("result").innerText = "Error contacting backend!";
      }
    }
  </script>
</body>
</html>

    
