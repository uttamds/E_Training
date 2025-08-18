# **Angular 14 Template-Driven Forms** 

---

## 🌐 Use Case

Suppose we want a **User Registration Form** where a user enters their name, email, and password.
We’ll validate that:

* Name is required.
* Email should be a valid email.
* Password should be at least 6 characters long.

This is a **good demo for Template-Driven Forms**, as they are **easy to set up, require less boilerplate, and are ideal for small/medium forms**.

---

## ⚡ Code Example

### 1. app.module.ts

Make sure you import `FormsModule` for template-driven forms.

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { UserFormComponent } from './user-form/user-form.component';

@NgModule({
  declarations: [AppComponent, UserFormComponent],
  imports: [BrowserModule, FormsModule],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}
```

---

### 2. user-form.component.ts

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html'
})
export class UserFormComponent {
  user = {
    name: '',
    email: '',
    password: ''
  };

  onSubmit(formData: any) {
    console.log('Form Submitted!', formData.value);
    alert('Welcome ' + this.user.name + '! Registration Successful.');
  }
}
```

---

### 3. user-form.component.html

```html
<div class="container mt-4">
  <h2>User Registration</h2>

  <form #userForm="ngForm" (ngSubmit)="onSubmit(userForm)" novalidate>
    
    <!-- Name -->
    <div class="mb-3">
      <label for="name">Name</label>
      <input type="text" 
             id="name" 
             name="name" 
             class="form-control"
             required
             [(ngModel)]="user.name" 
             #name="ngModel">
      <div *ngIf="name.invalid && name.touched" class="text-danger">
        Name is required
      </div>
    </div>

    <!-- Email -->
    <div class="mb-3">
      <label for="email">Email</label>
      <input type="email" 
             id="email" 
             name="email" 
             class="form-control"
             required
             [(ngModel)]="user.email" 
             #email="ngModel">
      <div *ngIf="email.invalid && email.touched" class="text-danger">
        Valid email is required
      </div>
    </div>

    <!-- Password -->
    <div class="mb-3">
      <label for="password">Password</label>
      <input type="password" 
             id="password" 
             name="password" 
             class="form-control"
             required minlength="6"
             [(ngModel)]="user.password" 
             #password="ngModel">
      <div *ngIf="password.invalid && password.touched" class="text-danger">
        Password must be at least 6 characters
      </div>
    </div>

    <button class="btn btn-primary" [disabled]="userForm.invalid">
      Register
    </button>
  </form>
</div>
```

---

## ✅ How It Works

1. **FormsModule** allows Angular to use template-driven forms.
2. We use `ngModel` for **two-way data binding**.
3. Template reference variables like `#name="ngModel"` give access to field validation state.
4. The form is submitted only when valid.


==================


<input type="email" 
       id="email" 
       name="email" 
       class="form-control"
       required
       email                 <!-- ✅ Angular's EmailValidator -->
       [(ngModel)]="user.email" 
       #email="ngModel">

<!-- Error Messages -->
<div *ngIf="email.errors?.['required'] && email.touched" class="text-danger">
  Email is required
</div>
<div *ngIf="email.errors?.['email'] && email.touched" class="text-danger">
  Please enter a valid email address
</div>

