

## **Section 1: Basics of JavaScript (15 Questions)**

1. What is JavaScript? How is it different from Java?
2. Explain the difference between `var`, `let`, and `const` with examples.
3. What are data types in JavaScript? Give examples of primitive and non-primitive types.
4. What is the difference between `==` and `===` in JavaScript?
5. What is hoisting in JavaScript? Give an example.
6. What are template literals in JavaScript? Give an example.
7. What is the difference between `null` and `undefined`?
8. How do you declare and call a function in JavaScript? Show with an example.
9. What are arrow functions? How are they different from normal functions?
10. What is the difference between function declaration and function expression?
11. What are default parameters in JavaScript? Give an example.
12. What is the purpose of the `typeof` operator?
13. Explain the difference between shallow copy and deep copy in JavaScript.
14. What are objects in JavaScript? Show how to create an object and access its properties.
15. How do you convert a string to a number in JavaScript? Mention at least two methods.

---

## **Section 2: DOM & Events (10 Questions)**

1. What is the DOM in JavaScript?
2. How do you select an element using `getElementById`, `querySelector`, and `getElementsByClassName`?
3. How do you change the content and style of an element using JavaScript?
4. What are event listeners in JavaScript? Give an example using `addEventListener`.
5. What is event bubbling and event capturing?
6. How do you prevent the default behavior of an event?
7. How do you create and append new HTML elements dynamically using JavaScript?
8. What are `setTimeout` and `setInterval`? Give examples.
9. How can you fetch the value of an input field using JavaScript?
10. What are keyboard and mouse events in JavaScript? Give two examples.

---

## **Section 3: Advanced JavaScript (15 Questions)**

1. What is the difference between synchronous and asynchronous programming in JavaScript?
2. What are JavaScript promises? Show a basic example.
3. Explain the `async` and `await` keywords with an example.
4. What is the difference between `call()`, `apply()`, and `bind()`?
5. What is the event loop in JavaScript? Explain with an example.
6. What are closures in JavaScript? Give a simple use case.
7. What is the purpose of the `this` keyword in JavaScript?
8. How does JavaScript handle scope: global, function, and block scopes?
9. What are higher-order functions in JavaScript? Give an example.
10. Explain the concept of currying in JavaScript with a sample code.
11. What are JavaScript modules? How do you import and export them?
12. What is debouncing and throttling in JavaScript? Give real-time examples.
13. What is the difference between `localStorage`, `sessionStorage`, and `cookies`?
14. What are template literals and tagged templates in JavaScript?
15. Explain the difference between synchronous callbacks and asynchronous callbacks.

---

## **Section 4: Asynchronous Programming & APIs (10 Questions)**

1. What is asynchronous programming in JavaScript? Why is it needed?

2. How does the JavaScript call stack and event loop work together?

3. What are promises? Explain states of a promise.

4. Convert the following callback-based code into promises:

   ```javascript
   function getData(callback) {
     setTimeout(() => {
       callback("Data received!");
     }, 1000);
   }
   ```

5. Write an example using `fetch()` to get data from a public API.

6. How do you handle promise rejections? Give an example.

7. What are async/await advantages over promises?

8. What is the difference between `fetch()` and `XMLHttpRequest`?

9. Explain the concept of `Promise.all()`, `Promise.race()`, and `Promise.allSettled()`.

10. Write a simple program to fetch JSON data from an API and display it in the console.

---

## **Section 5: Coding Practice Questions (10 Problems)**

1. Write a program to reverse a string without using built-in methods.
2. Write a function to check if a number is prime or not.
3. Given an array, return a new array with only unique elements.
4. Write a program to find the largest number in an array.
5. Implement a function that takes a callback and executes it after 2 seconds.
6. Write a function that fetches data from an API and handles errors gracefully.
7. Create a countdown timer using `setInterval` in JavaScript.
8. Write a function to sort an array of objects by a specific key.
9. Build a small promise chain that executes three asynchronous tasks in sequence.
10. Implement an async function that fetches data from two APIs simultaneously using `Promise.all()`.
