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

