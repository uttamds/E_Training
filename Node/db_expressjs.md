Got it 🙂
You want a **minimal demo project** using **Node.js + Express + MySQL** with a **basic database query**.
I’ll give you a **step-by-step setup** along with **sample code** to make it simple and beginner-friendly.

---

## **Project Structure**

```
node-express-mysql-demo/
│── package.json
│── server.js
└── db.js
```

---

## **Step 1 — Initialize Project**

```bash
mkdir node-express-mysql-demo
cd node-express-mysql-demo
npm init -y
```

---

## **Step 2 — Install Dependencies**

```bash
npm install express mysql2
```

---

## **Step 3 — Create Database and Table (Minimal)**

Open MySQL and run:

```sql
CREATE DATABASE demo_db;

USE demo_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO users (name, email)
VALUES ('Amit', 'amit@example.com'),
       ('Priya', 'priya@example.com');
```

---

## **Step 4 — Create `db.js` (MySQL Connection)**

```js
// db.js
const mysql = require('mysql2');

// Create connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',       // Change if needed
    password: '',       // Set your password if any
    database: 'demo_db'
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error('Database connection failed:', err);
        return;
    }
    console.log('Connected to MySQL Database ✅');
});

module.exports = db;
```

---

## **Step 5 — Create `server.js` (Express Server + Route)**

```js
const express = require('express');
const db = require('./db');

const app = express();
const PORT = 3000;

// Middleware to parse JSON
app.use(express.json());

// Route: Get all users
app.get('/users', (req, res) => {
    const query = 'SELECT * FROM users';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching users:', err);
            return res.status(500).send('Database error');
        }
        res.json(results);
    });
});

// Route: Add a new user
app.post('/users', (req, res) => {
    const { name, email } = req.body;
    const query = 'INSERT INTO users (name, email) VALUES (?, ?)';
    db.query(query, [name, email], (err, result) => {
        if (err) {
            console.error('Error inserting user:', err);
            return res.status(500).send('Database error');
        }
        res.json({ id: result.insertId, name, email });
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
```

---

## **Step 6 — Run the Project**

```bash
node server.js
```

---

## **Step 7 — Test the APIs**

### **1. Get All Users**

```bash
GET http://localhost:3000/users
```

**Response:**

```json
[
  { "id": 1, "name": "Amit", "email": "amit@example.com" },
  { "id": 2, "name": "Priya", "email": "priya@example.com" }
]
```

### **2. Add a New User**

```bash
POST http://localhost:3000/users
Content-Type: application/json

{
  "name": "Rahul",
  "email": "rahul@example.com"
}
```

**Response:**

```json
{
  "id": 3,
  "name": "Rahul",
  "email": "rahul@example.com"
}
```

---

## **Summary**

✅ Uses **Node.js** + **Express** + **MySQL**
✅ Minimal **database query**
✅ Supports **GET** + **POST** APIs
✅ Clean structure, beginner-friendly

---

If you want, I can also create a **simpler single-file version** without `db.js` and with **just one query** to make it even shorter.
Do you want me to make that?
