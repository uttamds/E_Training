import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-userlogin',
  templateUrl: './userlogin.component.html',
  styleUrls: ['./userlogin.component.css']
})
export class UserloginComponent {
  @Input() username = '';
  @Output() loginEvent = new EventEmitter<string>();

  login() {
    this.loginEvent.emit(`User '${this.username}' logged in successfully!`);
  }
}

<div>
  <h3>User Login Component (Child)</h3>
  <p>Username from parent: {{ username }}</p>
  <button (click)="login()">Login</button>
</div>



import { Component } from '@angular/core';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent {
  parentUsername = 'Uttam';
  loginMessage = '';

  handleLogin(msg: string) {
    this.loginMessage = msg;
  }
}


<h1>Registration Component (Parent)</h1>

<!-- Send data to child -->
<app-userlogin 
  [username]="parentUsername" 
  (loginEvent)="handleLogin($event)">
</app-userlogin>

<!-- Show message from child -->
<p *ngIf="loginMessage">{{ loginMessage }}</p>


==================
app.component.html
  =====================

<app-registration></app-registration>



