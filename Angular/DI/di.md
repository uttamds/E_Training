# Dependency Injection


## 🔹 **Dependency Injection (DI) in Angular – Quick Notes**

* **Definition**:
  Dependency Injection is a **design pattern** where objects (dependencies) are provided to a class instead of the class creating them itself.

* **Why?**

  * Promotes **loose coupling**
  * Improves **reusability** and **testability**
  * Centralizes object creation (services are created once and reused)

* **In Angular:**

  * Angular has a **built-in DI framework**.
  * Services are the most common dependencies injected.
  * You declare dependencies in a component’s constructor. Angular automatically provides them.

* **How it works:**

  1. A service is marked with `@Injectable()` and registered with a provider (`providedIn: 'root'` or module/component providers).
  2. When a component needs that service, Angular’s **injector** supplies an instance via the constructor.
  3. By default, `providedIn: 'root'` makes the service a **singleton** (same instance across the app).

* **Example:**

  ```ts
  @Injectable({ providedIn: 'root' })
  export class DataService { ... }

  @Component({...})
  export class MyComponent {
    constructor(private dataService: DataService) { }
  }
  ```

  👉 Here, `DataService` is injected into `MyComponent` automatically.

* **Key Benefits:**
  ✅ Single source of truth (services)
  ✅ Shared data across components
  ✅ Cleaner, maintainable code

---



---

## 🔹 **Service**

```ts
// student.service.ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'   // Service available throughout the app
})
export class StudentService {
  private students: string[] = ["Amit", "Priya", "Rohan"];

  getStudents() {
    return this.students;
  }

  addStudent(name: string) {
    this.students.push(name);
  }
}
```

---

## 🔹 **Component (TypeScript)**

```ts
// student-list.component.ts
import { Component } from '@angular/core';
import { StudentService } from './student.service';

@Component({
  selector: 'app-student-list',
  templateUrl: './student-list.component.html'   // ✅ external HTML template
})
export class StudentListComponent {
  students: string[] = [];
  newStudent: string = "";

  constructor(private studentService: StudentService) {}

  ngOnInit() {
    this.students = this.studentService.getStudents();
  }

  add() {
    if (this.newStudent.trim()) {
      this.studentService.addStudent(this.newStudent);
      this.newStudent = "";
    }
  }
}
```

---

## 🔹 **Component (HTML Template)**

```html
<!-- student-list.component.html -->
<h3>Student List</h3>

<ul>
  <li *ngFor="let s of students">{{ s }}</li>
</ul>

<input [(ngModel)]="newStudent" placeholder="Enter name">
<button (click)="add()">Add Student</button>
```

---

## 🔹 **Key Point**

Using `templateUrl` is the **recommended way** for real projects since:

* HTML stays separate (cleaner code).
* Easier to maintain and scale when templates grow larger.

