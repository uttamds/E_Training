

## Use Case

👉 Fetch a list of users from a public API and display them.
We’ll create a service (`UserService`) that uses `HttpClient` to fetch data, then inject it into a component.

---

### 1. Enable HttpClientModule

Add this to `app.module.ts`:

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, HttpClientModule], // 👈 important
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
```

---

### 2. Create a Service (`user.service.ts`)

This service will be **provided in root** (so Angular DI will manage it as a singleton).

```ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root' // 👈 Angular DI takes care of providing this service
})
export class UserService {
  private apiUrl = 'https://jsonplaceholder.typicode.com/users';

  constructor(private http: HttpClient) {} // 👈 DI injects HttpClient

  getUsers(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }
}
```

---

### 3. Use the Service in a Component (`app.component.ts`)

```ts
import { Component, OnInit } from '@angular/core';
import { UserService } from './user.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent implements OnInit {
  users: any[] = [];

  // 👇 DI injects UserService into this component
  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.userService.getUsers().subscribe((data) => {
      this.users = data;
    });
  }
}
```

---

### 4. Component Template (`app.component.html`)

```html
<h2>User List</h2>
<ul>
  <li *ngFor="let user of users">
    {{ user.name }} ({{ user.email }})
  </li>
</ul>
```

---

## 💡 Explanation for Beginners

* `HttpClient` is a **built-in Angular service** for making HTTP requests.
* `UserService` is a **custom service** we created.
* Both are injected into classes via the **constructor** → that’s Angular **Dependency Injection (DI)** in action.
* We didn’t manually create objects using `new`. Angular DI did it for us.


