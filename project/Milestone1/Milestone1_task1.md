Got it 👍.
Since this is **Phase 1** of your Angular 14 project, and you want to focus only on the **UI for User Registration**, here’s a minimal but clean structure to get started.

---

## 📌 High-level Steps

1. **Create a new component** for registration, e.g., `register`.
2. **Design the registration form UI** with Bootstrap or Angular Material.
3. **Use Angular Template-driven Forms** (beginner-friendly) or Reactive Forms (for better validation).
4. **Collect basic user details** like name, email, password, phone, etc.
5. For now, just **print the entered values in console** (no backend yet).

---

## 📁 Project Structure (Phase 1)

```
loan-app/
 └── src/app/
      ├── app.module.ts
      ├── app-routing.module.ts
      ├── components/
      │     └── register/
      │          ├── register.component.ts
      │          ├── register.component.html
      │          └── register.component.css
```

---

## 📝 Code Example

### 1. app.module.ts

Make sure FormsModule is imported for template-driven forms.

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './components/register/register.component';

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

---

### 2. register.component.ts

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {
  user = {
    fullName: '',
    email: '',
    password: '',
    phone: ''
  };

  onSubmit() {
    console.log('User Registered:', this.user);
    alert('Registration form submitted! (Check console)');
  }
}
```

---

### 3. register.component.html (Bootstrap UI)

```html
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg p-4 rounded">
        <h3 class="text-center text-primary mb-4">User Registration</h3>

        <form (ngSubmit)="onSubmit()" #regForm="ngForm">
          <!-- Full Name -->
          <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" class="form-control" required name="fullName" [(ngModel)]="user.fullName">
          </div>

          <!-- Email -->
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" required name="email" [(ngModel)]="user.email">
          </div>

          <!-- Password -->
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" required name="password" [(ngModel)]="user.password">
          </div>

          <!-- Phone -->
          <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone" [(ngModel)]="user.phone">
          </div>

          <!-- Submit -->
          <button class="btn btn-primary w-100" [disabled]="!regForm.valid">Register</button>
        </form>
      </div>
    </div>
  </div>
</div>
```

---

✅ With this, your **Phase 1 Registration UI is ready**.

* It collects details.
* Validation is basic (`required` fields).
* On submit, it logs data in the console.

Later, in **Phase 2**, we can connect this with a **backend (Node.js / Spring Boot / etc.)** and store data in a database.

---

Perfect 👍. Let’s extend **Phase 1** to include both **Register** and **Login** UIs.
We’ll use **Routing** so the user can switch between the two.

---

## 📁 Updated Project Structure

```
loan-app/
 └── src/app/
      ├── app-routing.module.ts
      ├── app.module.ts
      ├── components/
      │     ├── register/
      │     │     ├── register.component.ts
      │     │     ├── register.component.html
      │     │     └── register.component.css
      │     └── login/
      │           ├── login.component.ts
      │           ├── login.component.html
      │           └── login.component.css
```

---

## 📝 Code Changes

### 1. app-routing.module.ts

Add routing for `register` and `login`.

```ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';

const routes: Routes = [
  { path: '', redirectTo: 'register', pathMatch: 'full' },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
```

---

### 2. app.module.ts

Add `LoginComponent`.

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    LoginComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

---

### 3. login.component.ts

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  credentials = {
    email: '',
    password: ''
  };

  onLogin() {
    console.log('Login Attempt:', this.credentials);
    alert('Login form submitted! (Check console)');
  }
}
```

---

### 4. login.component.html (Bootstrap UI)

```html
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card shadow-lg p-4 rounded">
        <h3 class="text-center text-success mb-4">User Login</h3>

        <form (ngSubmit)="onLogin()" #loginForm="ngForm">
          <!-- Email -->
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" required name="email" [(ngModel)]="credentials.email">
          </div>

          <!-- Password -->
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" required name="password" [(ngModel)]="credentials.password">
          </div>

          <!-- Submit -->
          <button class="btn btn-success w-100" [disabled]="!loginForm.valid">Login</button>
        </form>

        <p class="text-center mt-3">
          New user? <a routerLink="/register">Register here</a>
        </p>
      </div>
    </div>
  </div>
</div>
```

---

### 5. Update register.component.html

Add navigation to **Login**.

```html
<p class="text-center mt-3">
  Already registered? <a routerLink="/login">Login here</a>
</p>
```

---

✅ Now you have:

* **Registration Page** (`/register`)
* **Login Page** (`/login`)
* Navigation links between them
* Both use **Bootstrap cards** with simple forms
* On submit → just logs data to console

---

Would you like me to also add a **navbar with routing links** (Register | Login) at the top so navigation looks more professional from the start?


Awesome 🚀. Let’s add a **Navbar** so users can navigate between **Register** and **Login** pages easily.

We’ll put the navbar in `app.component.html` so it’s visible across the app.

---

## 📝 Code Changes

### 1. app.component.html

```html
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand fw-bold" routerLink="/">Loan Manager</a>
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarNav"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" routerLink="/register" routerLinkActive="active">Register</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" routerLink="/login" routerLinkActive="active">Login</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Router outlet -->
<div class="container mt-4">
  <router-outlet></router-outlet>
</div>
```

---

### 2. Small Style (optional)

In `styles.css` (global styles), add:

```css
.nav-link.active {
  font-weight: bold;
  text-decoration: underline;
}
```

---

✅ Now you’ll see:

* A **Bootstrap navbar** with app title → *Loan Manager*
* Links for **Register** and **Login**
* Current active link is highlighted
* Form cards are shown inside the page body via `<router-outlet>`

---

👉 This completes **Phase 1 UI**:

* Navbar
* Register page
* Login page
* Routing between them

---

Do you want me to plan **Phase 2 (backend integration)** with Node.js + SQL Server (or Spring Boot, depending on your stack) right now, or should we keep Phase 1 strictly UI-only for your students/users?

Would you like me to also include a **Login UI** stub (just the form, no backend) so you can switch between **Register** and **Login** pages right from Phase 1?
