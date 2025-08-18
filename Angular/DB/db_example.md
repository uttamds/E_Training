## run following command in your terminal

npm install -g json-server

## Create db.json file with following data

<img width="832" height="242" alt="image" src="https://github.com/user-attachments/assets/66d2be74-3761-46d7-89b9-50d69af893a4" />

## Create a service using following commnad

ng generate service services/student

Note : verify if a new service file is created.

## copy paste the following code in the service.ts file 

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Student {
  id?: number;
  name: string;
  email: string;
}

@Injectable({
  providedIn: 'root'
})
export class StudentService {
  private apiUrl = 'http://localhost:3000/students';

  constructor(private http: HttpClient) {}  // ✅ DI in action

  getStudents(): Observable<Student[]> {
    return this.http.get<Student[]>(this.apiUrl);
  }

  addStudent(student: Student): Observable<Student> {
    return this.http.post<Student>(this.apiUrl, student);
  }

  updateStudent(id: number, student: Student): Observable<Student> {
    return this.http.put<Student>(`${this.apiUrl}/${id}`, student);
  }

  deleteStudent(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}

## create a new component

ng generate component components/student-list

## paste the code in TS file 

import { Component, OnInit } from '@angular/core';
import { StudentService, Student } from '../../services/student.service';

@Component({
  selector: 'app-student-list',
  templateUrl: './student-list.component.html'
})
export class StudentListComponent implements OnInit {
  students: Student[] = [];
  newStudent: Student = { name: '', email: '' };

  constructor(private studentService: StudentService) {}  // ✅ DI

  ngOnInit() {
    this.loadStudents();
  }

  loadStudents() {
    this.studentService.getStudents().subscribe(data => this.students = data);
  }

  addStudent() {
    if (this.newStudent.name && this.newStudent.email) {
      this.studentService.addStudent(this.newStudent).subscribe(() => {
        this.loadStudents();
        this.newStudent = { name: '', email: '' };
      });
    }
  }

  updateStudent(student: Student) {
    this.studentService.updateStudent(student.id!, student).subscribe(() => {
      this.loadStudents();
    });
  }

  deleteStudent(id: number) {
    this.studentService.deleteStudent(id).subscribe(() => {
      this.loadStudents();
    });
  }
}




