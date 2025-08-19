Alright 🙂 Let's create a **basic Node.js API** step by step.
We’ll use **Express.js** because it's simple and widely used for building REST APIs.

I’ll explain everything clearly since this is for **beginners**.

---

# **1. What We’ll Build**

We’ll create a simple **Student Management API** with the following endpoints:

| **Method** | **Endpoint**    | **Description**            |
| ---------- | --------------- | -------------------------- |
| GET        | `/students`     | Fetch all students         |
| GET        | `/students/:id` | Fetch a student by ID      |
| POST       | `/students`     | Add a new student          |
| PUT        | `/students/:id` | Update an existing student |
| DELETE     | `/students/:id` | Delete a student           |

---

# **2. Setup Project**

### **Step 1 — Create Project Folder**

```bash
mkdir student-api
cd student-api
```

### **Step 2 — Initialize Node.js**

```bash
npm init -y
```

This creates a **package.json** file.

### **Step 3 — Install Express**

```bash
npm install express
```

---

# **3. Create `server.js`**

```js
// Import express
const express = require("express");
const app = express();
const PORT = 3000;

// Middleware to parse JSON data
app.use(express.json());

// Sample student data (in-memory)
let students = [
  { id: 1, name: "Rahul", course: "B.Tech" },
  { id: 2, name: "Priya", course: "B.Sc" },
  { id: 3, name: "Amit", course: "MBA" }
];

// 1. GET all students
app.get("/students", (req, res) => {
  res.json(students);
});

// 2. GET a student by ID
app.get("/students/:id", (req, res) => {
  const student = students.find(s => s.id === parseInt(req.params.id));
  if (!student) {
    return res.status(404).json({ message: "Student not found" });
  }
  res.json(student);
});

// 3. POST - Add a new student
app.post("/students", (req, res) => {
  const newStudent = {
    id: students.length + 1,
    name: req.body.name,
    course: req.body.course
  };
  students.push(newStudent);
  res.status(201).json(newStudent);
});

// 4. PUT - Update student info
app.put("/students/:id", (req, res) => {
  const student = students.find(s => s.id === parseInt(req.params.id));
  if (!student) {
    return res.status(404).json({ message: "Student not found" });
  }
  student.name = req.body.name || student.name;
  student.course = req.body.course || student.course;
  res.json(student);
});

// 5. DELETE - Remove a student
app.delete("/students/:id", (req, res) => {
  const index = students.findIndex(s => s.id === parseInt(req.params.id));
  if (index === -1) {
    return res.status(404).json({ message: "Student not found" });
  }
  students.splice(index, 1);
  res.json({ message: "Student deleted successfully" });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
```

---

# **4. Run the API**

```bash
node server.js
```

**Output:**

```
Server running at http://localhost:3000
```

---

# **5. Test the API**

### **a) Fetch All Students**

```bash
GET http://localhost:3000/students
```

**Response:**

```json
[
  { "id": 1, "name": "Rahul", "course": "B.Tech" },
  { "id": 2, "name": "Priya", "course": "B.Sc" },
  { "id": 3, "name": "Amit", "course": "MBA" }
]
```

### **b) Fetch One Student**

```bash
GET http://localhost:3000/students/2
```

### **c) Add a New Student**

```bash
POST http://localhost:3000/students
```

**Body (JSON):**

```json
{
  "name": "Sneha",
  "course": "BCA"
}
```

### **d) Update a Student**

```bash
PUT http://localhost:3000/students/3
```

**Body (JSON):**

```json
{
  "course": "MCA"
}
```

### **e) Delete a Student**

```bash
DELETE http://localhost:3000/students/1
```

---

# **6. Next Step**

Right now, the data is **in-memory**.
If you restart the server, data will be lost.
For real projects, we should **connect a database** like:

* MySQL
* MongoDB
* PostgreSQL
* MS SQL Server

---

If you want, I can show you how to **convert this API** to use **MS SQL Server**, since your other Angular loan project also uses it.

Do you want me to upgrade this API to **use MS SQL**?
