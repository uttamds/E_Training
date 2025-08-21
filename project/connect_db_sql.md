Alright 🙂 I’ll give you **clear step-by-step instructions** to **create a Node.js API** that connects to **MS SQL Server** and then **consume that API** in your **Angular 14 project**.

We’ll break it into **3 phases**:

1. **Setup Node.js + Express API**
2. **Connect Node.js to MS SQL Server**
3. **Use the API in Angular 14**

---

# **Phase 1 — Setup Node.js + Express API**

### **Step 1.1 — Create Project Folder**

```bash
mkdir loan-api
cd loan-api
npm init -y
```

---

### **Step 1.2 — Install Dependencies**

```bash
npm install express mssql cors body-parser
```

* **express** → API framework
* **mssql** → For connecting to MS SQL Server
* **cors** → To allow Angular frontend to call API
* **body-parser** → To handle POST request data

---

### **Step 1.3 — Create `server.js`**

```js
const express = require("express");
const sql = require("mssql");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// MS SQL Server Configuration
const dbConfig = {
  user: "your_username",       // Replace with your SQL login username
  password: "your_password",   // Replace with your SQL login password
  server: "localhost",         // Or .\SQLEXPRESS
  database: "LoanDB",          // Replace with your database name
  options: {
    encrypt: false,            // Set true if using Azure SQL
    trustServerCertificate: true
  }
};

// API: Test DB Connection
app.get("/api/test-db", async (req, res) => {
  try {
    let pool = await sql.connect(dbConfig);
    let result = await pool.request().query("SELECT TOP 5 * FROM Customers");
    res.json(result.recordset);
  } catch (err) {
    console.error("DB Error:", err);
    res.status(500).send("Database connection failed");
  }
});

// API: Add New Customer
app.post("/api/customers", async (req, res) => {
  try {
    const { name, email, phone } = req.body;
    let pool = await sql.connect(dbConfig);
    let result = await pool
      .request()
      .input("name", sql.VarChar, name)
      .input("email", sql.VarChar, email)
      .input("phone", sql.VarChar, phone)
      .query("INSERT INTO Customers (Name, Email, Phone) VALUES (@name, @email, @phone)");
    res.status(201).send("Customer added successfully");
  } catch (err) {
    console.error("Insert Error:", err);
    res.status(500).send("Error adding customer");
  }
});

// Start Server
app.listen(port, () => {
  console.log(`API running on http://localhost:${port}`);
});
```

---

# **Phase 2 — Setup MS SQL Server**

### **Step 2.1 — Create Database & Table**

Run these queries in **SQL Server Management Studio**:

```sql
CREATE DATABASE LoanDB;
GO

USE LoanDB;
GO

CREATE TABLE Customers (
  Id INT PRIMARY KEY IDENTITY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(15)
);
```

---

### **Step 2.2 — Test API with Postman**

* **GET** → `http://localhost:3000/api/test-db`
* **POST** → `http://localhost:3000/api/customers`

```json
{
  "name": "Ravi Kumar",
  "email": "ravi@example.com",
  "phone": "9876543210"
}
```

If successful, you should see:

```json
"Customer added successfully"
```

---

# **Phase 3 — Use API in Angular 14**

### **Step 3.1 — Create Angular Service**

In your Angular project (`loan-app`):

```bash
ng generate service services/customer
```

---

### **Step 3.2 — Add Code to `customer.service.ts`**

```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {
  private apiUrl = 'http://localhost:3000/api/customers';

  constructor(private http: HttpClient) {}

  // Get all customers
  getCustomers(): Observable<any> {
    return this.http.get(this.apiUrl);
  }

  // Add new customer
  addCustomer(customer: any): Observable<any> {
    return this.http.post(this.apiUrl, customer);
  }
}
```

---

### **Step 3.3 — Update `app.module.ts`**

Add **HttpClientModule**:

```ts
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  imports: [BrowserModule, HttpClientModule],
  ...
})
export class AppModule {}
```

---

### **Step 3.4 — Use in Component**

In `customer.component.ts`:

```ts
import { Component, OnInit } from '@angular/core';
import { CustomerService } from '../services/customer.service';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html'
})
export class CustomerComponent implements OnInit {
  customers: any[] = [];
  newCustomer = { name: '', email: '', phone: '' };

  constructor(private customerService: CustomerService) {}

  ngOnInit() {
    this.loadCustomers();
  }

  loadCustomers() {
    this.customerService.getCustomers().subscribe(data => {
      this.customers = data;
    });
  }

  addCustomer() {
    this.customerService.addCustomer(this.newCustomer).subscribe(() => {
      this.newCustomer = { name: '', email: '', phone: '' };
      this.loadCustomers();
    });
  }
}
```

---

### **Step 3.5 — Create Template `customer.component.html`**

```html
<h2>Customer List</h2>
<ul>
  <li *ngFor="let c of customers">
    {{ c.Name }} — {{ c.Email }} — {{ c.Phone }}
  </li>
</ul>

<h3>Add New Customer</h3>
<input [(ngModel)]="newCustomer.name" placeholder="Name" />
<input [(ngModel)]="newCustomer.email" placeholder="Email" />
<input [(ngModel)]="newCustomer.phone" placeholder="Phone" />
<button (click)="addCustomer()">Add</button>
```

---

# **Final Workflow**

1. Start **Node API**:

   ```bash
   node server.js
   ```
2. Start **Angular App**:

   ```bash
   ng serve
   ```
3. Open [http://localhost:4200](http://localhost:4200)
4. Add customers → See them appear instantly → Data stored in **MS SQL Server**.

---

If you want, I can create a **complete project folder structure diagram** showing
**Angular + Node + SQL Server** interaction.
It’ll help you visualize how everything connects.

Do you want me to prepare that?
