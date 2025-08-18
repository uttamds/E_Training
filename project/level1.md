Here’s a clean, Bootstrap-powered Angular 14 page you can drop into a component template (using `templateUrl`). It includes a header (navbar), a main section with a loan application form + a list, and a footer.

### 1) Ensure Bootstrap is available

Add Bootstrap via CDN in `src/index.html` (quickest way):

```html
<!-- src/index.html -->
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Loan Management</title>
  <base href="/" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous"
  />
</head>
<body>
  <app-root></app-root>
  <!-- Bootstrap JS (optional) -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"
  ></script>
</body>
</html>
```

### 2) Component template with header + footer

Save as `loan-management.component.html` (or use in `app.component.html`):

```html
<!-- loan-management.component.html -->
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
      <a class="navbar-brand fw-semibold" href="#">
        <i class="bi bi-bank2 me-2"></i>Loan Manager
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#topNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div id="topNav" class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Applications</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Reports</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<main class="py-4">
  <div class="container">
    <!-- Apply for Loan -->
    <div class="row g-4">
      <div class="col-lg-5">
        <div class="card shadow-sm">
          <div class="card-header bg-white">
            <h5 class="mb-0">Apply for a Loan</h5>
          </div>
          <div class="card-body">
            <form (ngSubmit)="onSubmit()" #loanForm="ngForm" novalidate>
              <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input class="form-control" name="fullName" [(ngModel)]="model.fullName" required />
                <div class="form-text">As per your ID proof.</div>
              </div>

              <div class="mb-3">
                <label class="form-label">Email</label>
                <input class="form-control" type="email" name="email" [(ngModel)]="model.email" required />
              </div>

              <div class="mb-3">
                <label class="form-label">Loan Type</label>
                <select class="form-select" name="loanType" [(ngModel)]="model.loanType" required>
                  <option value="" disabled selected>Select a type</option>
                  <option>Personal</option>
                  <option>Home</option>
                  <option>Auto</option>
                  <option>Education</option>
                </select>
              </div>

              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Amount (₹)</label>
                  <input class="form-control" type="number" min="10000" step="1000"
                         name="amount" [(ngModel)]="model.amount" required />
                </div>
                <div class="col-md-6 mb-3">
                  <label class="form-label">Tenure (months)</label>
                  <input class="form-control" type="number" min="6" step="1"
                         name="tenure" [(ngModel)]="model.tenure" required />
                </div>
              </div>

              <div class="mb-3">
                <label class="form-label">Notes (optional)</label>
                <textarea class="form-control" rows="3" name="notes" [(ngModel)]="model.notes"></textarea>
              </div>

              <div class="d-grid">
                <button class="btn btn-primary" type="submit" [disabled]="loanForm.invalid">
                  Submit Application
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- Applications List -->
      <div class="col-lg-7">
        <div class="card shadow-sm">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Recent Applications</h5>
            <div class="input-group input-group-sm" style="max-width: 260px;">
              <span class="input-group-text">Search</span>
              <input type="text" class="form-control" placeholder="Name or status" [(ngModel)]="searchText" name="searchText"/>
            </div>
          </div>
          <div class="card-body p-0">
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                  <tr>
                    <th>#</th>
                    <th>Applicant</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th class="text-end">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <tr *ngFor="let app of applications | filter:searchText; let i = index">
                    <td>{{ i + 1 }}</td>
                    <td>
                      <div class="fw-semibold">{{ app.fullName }}</div>
                      <small class="text-muted">{{ app.email }}</small>
                    </td>
                    <td>{{ app.loanType }}</td>
                    <td>₹{{ app.amount | number }}</td>
                    <td>
                      <span class="badge"
                            [ngClass]="{
                              'bg-warning text-dark': app.status==='On Hold',
                              'bg-success': app.status==='Approved',
                              'bg-danger': app.status==='Rejected',
                              'bg-secondary': app.status==='Pending'
                            }">
                        {{ app.status }}
                      </span>
                    </td>
                    <td class="text-end">
                      <button class="btn btn-sm btn-outline-success me-1" (click)="approve(app)">Approve</button>
                      <button class="btn btn-sm btn-outline-danger me-1" (click)="reject(app)">Reject</button>
                      <button class="btn btn-sm btn-outline-secondary" (click)="hold(app)">Hold</button>
                    </td>
                  </tr>
                  <tr *ngIf="!applications || applications.length===0">
                    <td colspan="6" class="text-center text-muted py-4">No applications yet.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="card-footer text-muted small">
            Showing {{ applications?.length || 0 }} record(s)
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<footer class="mt-auto py-3 bg-light border-top">
  <div class="container d-flex flex-column flex-md-row align-items-center justify-content-between">
    <span class="text-muted">© {{ currentYear }} Crux Training Solutions · Loan Management</span>
    <ul class="nav small">
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Privacy</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Terms</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Support</a></li>
    </ul>
  </div>
</footer>
```

### 3) Minimal component TS (optional, for bindings)

```ts
// loan-management.component.ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-loan-management',
  templateUrl: './loan-management.component.html',
})
export class LoanManagementComponent {
  currentYear = new Date().getFullYear();

  model: any = {
    fullName: '',
    email: '',
    loanType: '',
    amount: null,
    tenure: null,
    notes: ''
  };

  searchText = '';

  // Demo data
  applications = [
    { fullName: 'Aarav Shah', email: 'aarav@example.com', loanType: 'Home', amount: 2500000, status: 'Pending' },
    { fullName: 'Diya Nair',  email: 'diya@example.com',  loanType: 'Auto', amount: 800000,  status: 'On Hold' },
    { fullName: 'Rohan Iyer', email: 'rohan@example.com', loanType: 'Personal', amount: 150000, status: 'Approved' }
  ];

  onSubmit() {
    // Add to list (mock)
    this.applications = [
      { ...this.model, status: 'Pending' },
      ...this.applications
    ];
    this.model = { fullName: '', email: '', loanType: '', amount: null, tenure: null, notes: '' };
  }

  approve(app: any) { app.status = 'Approved'; }
  reject(app: any)  { app.status = 'Rejected'; }
  hold(app: any)    { app.status = 'On Hold'; }
}
```

### 4) Notes

* The `filter` pipe in the `*ngFor` is illustrative; replace with your own filtering logic or remove it if you don't have a custom pipe.
* If you prefer npm install: `npm i bootstrap@5` and add `"node_modules/bootstrap/dist/css/bootstrap.min.css"` to `angular.json` styles.

This should give you a polished header + footer and a solid starting point for your loan management front end.
