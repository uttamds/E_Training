Nice 👍 Right now you’re using the browser’s **blocking alert()**.
Instead, let’s replace it with a **Bootstrap animated alert** that smoothly appears and disappears.

---

### ✅ Updated Angular Component (TypeScript)

We’ll add a flag (`showAlert`) and message to control the Bootstrap alert.

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html',
  styleUrls: ['./user-form.component.css']
})
export class UserFormComponent {
  user = {
    name: '',
    email: '',
    password: ''
  };

  showAlert = false;
  alertMessage = '';

  onSubmit(formData: any) {
    console.log('Form Submitted!', formData.value);
    this.alertMessage = `Welcome ${this.user.name}! Registration Successful.`;
    this.showAlert = true;

    // Hide after 3 seconds with fade-out
    setTimeout(() => {
      this.showAlert = false;
    }, 3000);
  }
}
```

---

### ✅ Updated Template (HTML with Bootstrap alert + animation)

```html
<form #userForm="ngForm" (ngSubmit)="onSubmit(userForm)">
  <!-- form fields here -->

  <button type="submit" class="btn btn-primary">Register</button>
</form>

<!-- Animated Alert -->
<div class="alert alert-success alert-dismissible fade"
     [class.show]="showAlert"
     role="alert"
     style="transition: opacity 0.5s ease-in-out;">
  {{ alertMessage }}
  <button type="button" class="btn-close" aria-label="Close" (click)="showAlert=false"></button>
</div>
```

---

### ✅ CSS (Optional smoother fade)

In `user-form.component.css`:

```css
.alert {
  opacity: 0;
}
.alert.show {
  opacity: 1;
}
```

---

### 🔎 How it works:

* Instead of `alert()`, we toggle a **Bootstrap alert box**.
* `fade` + `show` classes handle animation.
* Angular `[class.show]` binding makes it appear/disappear.
* `setTimeout()` auto-hides after 3 seconds.
* Close button lets user dismiss it manually.

---

👉 Do you want me to also give you a **jQuery-based version** (using `fadeIn/fadeOut`) in case you want to demo both approaches to your students?
