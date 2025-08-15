import { Component } from '@angular/core';
import { UserloginComponent } from '../userlogin/userlogin.component';

@Component({
  selector: 'app-registration',
  standalone: true,            // ✅ Works in Angular 14+
  imports: [UserloginComponent], // ✅ Import child here
  template: `
    <h1>Registration Component (Parent)</h1>
    <!-- Send data to child -->
    <app-userlogin [username]="parentUsername" 
                   (loginEvent)="handleLogin($event)">
    </app-userlogin>

    <p *ngIf="loginMessage">{{ loginMessage }}</p>
  `
})
export class RegistrationComponent {
  parentUsername = 'Uttam';
  loginMessage = '';

  handleLogin(msg: string) {
    this.loginMessage = msg;
  }
}
=====================================

userlogin component.ts
=====================================
import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-userlogin',
  standalone: true,
  template: `
    <div>
      <h3>User Login Component (Child)</h3>
      <p>Username from parent: {{ username }}</p>
      <button (click)="login()">Login</button>
    </div>
  `
})
export class UserloginComponent {
  @Input() username = '';
  @Output() loginEvent = new EventEmitter<string>();

  login() {
    this.loginEvent.emit(`User '${this.username}' logged in successfully!`);
  }
}
