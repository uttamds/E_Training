## Install Material UI

ng add @angular/material

### 1️⃣ Create a Component

```bash
ng generate component demo
```

This generates:

* `demo.component.ts`
* `demo.component.html`
* `demo.component.css`

---

### 2️⃣ Component TypeScript (`demo.component.ts`)

```ts
import { Component } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-demo',
  templateUrl: './demo.component.html',
  styleUrls: ['./demo.component.css']
})
export class DemoComponent {
  students = [
    { name: 'Ravi', email: 'ravi@example.com' },
    { name: 'Anita', email: 'anita@example.com' }
  ];

  constructor(private snackBar: MatSnackBar) {}

  showSnack() {
    this.snackBar.open('Registration Successful!', 'Close', {
      duration: 3000,
      horizontalPosition: 'right',
      verticalPosition: 'top'
    });
  }
}
```

---

### 3️⃣ Component HTML (`demo.component.html`)

```html
<!-- Buttons -->
<button mat-raised-button color="primary">Primary Button</button>
<button mat-stroked-button color="accent">Accent Button</button>

<hr>

<!-- Input -->
<mat-form-field appearance="outline">
  <mat-label>Email</mat-label>
  <input matInput placeholder="Enter email">
</mat-form-field>

<hr>

<!-- Select -->
<mat-form-field appearance="fill">
  <mat-label>Country</mat-label>
  <mat-select>
    <mat-option value="in">India</mat-option>
    <mat-option value="us">USA</mat-option>
    <mat-option value="uk">UK</mat-option>
  </mat-select>
</mat-form-field>

<hr>

<!-- Card -->
<mat-card>
  <mat-card-header>
    <mat-card-title>Student</mat-card-title>
    <mat-card-subtitle>Profile</mat-card-subtitle>
  </mat-card-header>
  <mat-card-content>
    <p>Ravi Sharma - Computer Science</p>
  </mat-card-content>
  <mat-card-actions>
    <button mat-button color="primary">Edit</button>
    <button mat-button color="warn">Delete</button>
  </mat-card-actions>
</mat-card>

<hr>

<!-- Table -->
<table mat-table [dataSource]="students" class="mat-elevation-z8">

  <!-- Name Column -->
  <ng-container matColumnDef="name">
    <th mat-header-cell *matHeaderCellDef> Name </th>
    <td mat-cell *matCellDef="let student"> {{student.name}} </td>
  </ng-container>

  <!-- Email Column -->
  <ng-container matColumnDef="email">
    <th mat-header-cell *matHeaderCellDef> Email </th>
    <td mat-cell *matCellDef="let student"> {{student.email}} </td>
  </ng-container>

  <tr mat-header-row *matHeaderRowDef="['name','email']"></tr>
  <tr mat-row *matRowDef="let row; columns: ['name','email'];"></tr>
</table>

<hr>

<!-- Snackbar Button -->
<button mat-raised-button color="warn" (click)="showSnack()">Show Snackbar</button>
```

---

### 4️⃣ Import Angular Material Modules

Create a `material.module.ts` (for neatness):

```ts
import { NgModule } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatCardModule } from '@angular/material/card';
import { MatTableModule } from '@angular/material/table';
import { MatSnackBarModule } from '@angular/material/snack-bar';

@NgModule({
  exports: [
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatCardModule,
    MatTableModule,
    MatSnackBarModule
  ]
})
export class MaterialModule {}
```

And import it in `app.module.ts`:

```ts
imports: [
  BrowserModule,
  BrowserAnimationsModule,
  MaterialModule
]
```

---

👉 Now your examples work with `templateUrl` cleanly.

Do you want me to **combine these into a single minimal “Material Demo Page” project flow** (with routing to `/demo`) so your students can run it immediately after `ng serve`?
