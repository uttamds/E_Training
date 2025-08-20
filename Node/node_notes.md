
---

### **1. Introduction to Node.js and Features**

* **Node.js** is an **open-source, cross-platform** JavaScript runtime built on **Google’s V8 engine**.
* Allows running **JavaScript on the server-side**.
* **Key Features**:

  * **Non-blocking I/O** → Handles multiple requests without waiting.
  * **Event-driven architecture** → Uses an event loop for scalability.
  * **Fast performance** → Built on V8 engine.
  * **Cross-platform** → Works on Windows, Linux, macOS.

---

### **2. Installing Node.js and npm**

* Download from [https://nodejs.org](https://nodejs.org).
* Node.js installation includes **npm** (Node Package Manager).
* Check versions:

  ```bash
  node -v    # Node.js version
  npm -v     # npm version
  ```

---

### **3. Running JavaScript in Node.js**

* Create a file `app.js`:

  ```js
  console.log("Hello Node.js!");
  ```
* Run using:

  ```bash
  node app.js
  ```
* Supports **REPL** mode (Read-Eval-Print Loop):

  ```bash
  node
  > 5 + 10
  15
  ```

---

### **4. Modules (Built-in, Custom, Third-party)**

* **Built-in Modules** → Provided by Node.js (`fs`, `http`, `path`, `os`).

  ```js
  const os = require("os");
  console.log(os.platform());
  ```
* **Custom Modules** → Create your own:

  ```js
  // math.js
  exports.add = (a, b) => a + b;
  ```
* **Third-party Modules** → Installed via **npm**:

  ```bash
  npm install lodash
  ```

---

### **5. Working with npm**

* **npm** = Node Package Manager → Manages dependencies.
* Commands:

  ```bash
  npm init        # Create package.json
  npm install     # Install dependencies
  npm install axios   # Install a specific package
  npm uninstall axios # Remove a package
  npm list        # Show installed packages
  ```

---

### **6. File System Module Basics**

* The **fs** module handles reading/writing files.
* Example:

  ```js
  const fs = require("fs");
  fs.writeFileSync("data.txt", "Hello Node!");
  const data = fs.readFileSync("data.txt", "utf8");
  console.log(data);
  ```
* Supports **sync** and **async** versions of methods.

---

### **7. HTTP Module – Creating a Simple Server**

* Node.js can create its own **web server**:

  ```js
  const http = require("http");
  const server = http.createServer((req, res) => {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("Hello, World!");
  });
  server.listen(3000, () => console.log("Server running on port 3000"));
  ```

---

### **8. Asynchronous Programming (Callbacks, Promises, Async/Await)**

* **Callbacks** → Pass a function to handle results:

  ```js
  fs.readFile("data.txt", "utf8", (err, data) => console.log(data));
  ```
* **Promises** → Cleaner approach:

  ```js
  fetch(url).then(res => res.json()).then(data => console.log(data));
  ```
* **Async/Await** → Modern, easy to read:

  ```js
  const getData = async () => {
    const res = await fetch(url);
    console.log(await res.json());
  };
  ```

---

### **9. Express.js Basics and Routing**

* **Express.js** → A lightweight Node.js framework for building web apps.
* Install:

  ```bash
  npm install express
  ```
* Basic server:

  ```js
  const express = require("express");
  const app = express();

  app.get("/", (req, res) => res.send("Hello Express!"));
  app.listen(3000, () => console.log("Server running"));
  ```
* **Routing** → Handles different URLs:

  ```js
  app.get("/users", (req, res) => res.send("Users page"));
  ```

---

### **10. Working with REST APIs in Node.js**

* **REST API** → Communicates via **HTTP methods**:

  * **GET** → Read data
  * **POST** → Create data
  * **PUT** → Update data
  * **DELETE** → Remove data
* Example using Express:

  ```js
  app.get("/api/users", (req, res) => res.json([{ id: 1, name: "Ravi" }]));
  ```

---

### **11. Connecting to a Database**

* Node.js supports many databases: **MongoDB, MySQL, PostgreSQL, SQL Server**.
* Example using **MongoDB**:

  ```bash
  npm install mongoose
  ```

  ```js
  const mongoose = require("mongoose");
  mongoose.connect("mongodb://127.0.0.1:27017/mydb")
    .then(() => console.log("Connected"))
    .catch(err => console.log(err));
  ```
* Example using **MySQL**:

  ```bash
  npm install mysql2
  ```

  ```js
  const mysql = require("mysql2");
  const db = mysql.createConnection({ host: "localhost", user: "root", password: "", database: "test" });
  db.connect(err => err ? console.log(err) : console.log("Connected"));
  ```

---

If you want, I can prepare a **visually structured PDF** with **diagrams**, **code snippets**, and **flowcharts** for these topics to use as a **training handout** for your students.

Do you want me to make that?
