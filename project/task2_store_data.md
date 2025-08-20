Got it 🙂 You're building an **Angular 14** project and you want to implement **registration, login, and navigation** — but since your database system isn’t available right now, you need an **alternative persistent storage** to temporarily manage user data.

I'll guide you step by step on how to do this using **localStorage** (persistent in the browser) as a temporary database.

---

## **Plan**

### **1. Registration**

* Take user details from the registration form.
* Save the details into `localStorage`.
* Each new user will be stored as an object in an array.

### **2. Login**

* Take credentials from the login form.
* Verify them against the stored data in `localStorage`.
* If matched, set a **logged-in flag** in `localStorage` and redirect to a landing page.

### **3. Landing Page**

* Check if the user is logged in; if not, redirect to the login page.
* Show a welcome message.

### **4. Logout (Optional but Recommended)**

* Clear the login flag and redirect to the login page.

---

## **Implementation**

### **Step 1 — Registration Component**

**registration.component.html**

```html
<div class="container mt-4">
  <h2 class="mb-3">User Registration</h2>
  <form (ngSubmit)="registerUser()" #registerForm="ngForm">
    <div class="mb-3">
      <label>Name</label>
      <input type="text" class="form-control" name="name" [(ngModel)]="user.name" required />
    </div>
    <div class="mb-3">
      <label>Email</label>
      <input type="email" class="form-control" name="email" [(ngModel)]="user.email" required />
    </div>
    <div class="mb-3">
      <label>Password</label>
      <input type="password" class="form-control" name="password" [(ngModel)]="user.password" required />
    </div>
    <button type="submit" class="btn btn-primary" [disabled]="!registerForm.valid">Register</button>
  </form>
</div>
```

**registration.component.ts**

```ts
import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html'
})
export class RegistrationComponent {
  user = {
    name: '',
    email: '',
    password: ''
  };

  constructor(private router: Router) {}

  registerUser() {
    let users = JSON.parse(localStorage.getItem('users') || '[]');
    const userExists = users.find((u: any) => u.email === this.user.email);

    if (userExists) {
      alert('User already exists! Please login.');
      this.router.navigate(['/login']);
      return;
    }

    users.push(this.user);
    localStorage.setItem('users', JSON.stringify(users));
    alert('Registration successful! Please login.');
    this.router.navigate(['/login']);
  }
}
```

---

### **Step 2 — Login Component**

**login.component.html**

```html
<div class="container mt-4">
  <h2 class="mb-3">Login</h2>
  <form (ngSubmit)="loginUser()" #loginForm="ngForm">
    <div class="mb-3">
      <label>Email</label>
      <input type="email" class="form-control" name="email" [(ngModel)]="email" required />
    </div>
    <div class="mb-3">
      <label>Password</label>
      <input type="password" class="form-control" name="password" [(ngModel)]="password" required />
    </div>
    <button type="submit" class="btn btn-success" [disabled]="!loginForm.valid">Login</button>
  </form>
</div>
```

**login.component.ts**

```ts
import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent {
  email = '';
  password = '';

  constructor(private router: Router) {}

  loginUser() {
    let users = JSON.parse(localStorage.getItem('users') || '[]');
    const validUser = users.find((u: any) => u.email === this.email && u.password === this.password);

    if (validUser) {
      localStorage.setItem('loggedInUser', JSON.stringify(validUser));
      this.router.navigate(['/landing']);
    } else {
      alert('Invalid credentials!');
    }
  }
}
```

---

### **Step 3 — Landing Page Component**

**landing.component.html**

```html
<div class="container mt-4 text-center">
  <h2>Welcome, {{ user?.name }}!</h2>
  <p>Your email: {{ user?.email }}</p>
  <button class="btn btn-danger mt-3" (click)="logout()">Logout</button>
</div>
```

**landing.component.ts**

```ts
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html'
})
export class LandingComponent implements OnInit {
  user: any = null;

  constructor(private router: Router) {}

  ngOnInit() {
    const storedUser = localStorage.getItem('loggedInUser');
    if (storedUser) {
      this.user = JSON.parse(storedUser);
    } else {
      this.router.navigate(['/login']);
    }
  }

  logout() {
    localStorage.removeItem('loggedInUser');
    this.router.navigate(['/login']);
  }
}
```

---

### **Step 4 — Update Routes**

**app-routing.module.ts**

```ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RegistrationComponent } from './registration/registration.component';
import { LoginComponent } from './login/login.component';
import { LandingComponent } from './landing/landing.component';

const routes: Routes = [
  { path: '', redirectTo: '/register', pathMatch: 'full' },
  { path: 'register', component: RegistrationComponent },
  { path: 'login', component: LoginComponent },
  { path: 'landing', component: LandingComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
```

---

### **Step 5 — Persistent Storage Choice**

Since your DB isn’t ready, we used **localStorage** because:

* Data persists even after page reload.
* Simple JSON-based storage.
* Good for temporary mock setups.

Alternatively, you could use:

* **IndexedDB** → Better for larger datasets.
* **Fake JSON Server** → Simulates APIs without a DB.
* **SessionStorage** → If you don’t want data persisted after closing the browser.

---

## **Next Steps**

Once your DB becomes available, we can replace `localStorage` logic with **HTTP API calls** using Angular’s **HttpClient** and a backend (Spring Boot, Node.js, etc.).

---

Do you want me to **extend this setup** by adding a **fake JSON server** so your registration and login work exactly like a real backend?
That would make migrating to a real DB later **seamless**. Should I?
