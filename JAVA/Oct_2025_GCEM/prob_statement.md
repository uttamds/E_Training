
## 🧩 Problem Statement: College Course Registration System

### Objective:

Design and implement a **Course Registration System** using **Core Java**, the **Collection Framework**, and **Exception Handling**.

---

### Scenario:

A college needs a system to manage student enrollments for various courses.
Each **course** has a limited capacity, and each **student** can register for available courses until the capacity is reached.

You are required to build a **console-based application** that handles the following operations.

---

### Requirements:

#### 1. Student Management

* Create a `Student` class with:

  * `id` (int)
  * `name` (String)
* Provide appropriate constructors, getters, and a `toString()` method.

#### 2. Course Management

* Create a `Course` class with:

  * `code` (String)
  * `title` (String)
  * `capacity` (int)
  * A list to store enrolled students.
* Implement:

  * A method to **enroll a student** into the course.
  * Throw a custom exception `CourseFullException` when the course is already full.

#### 3. Custom Exceptions

Create two custom exception classes:

* `StudentNotFoundException` — raised when trying to register a non-existent student.
* `CourseFullException` — raised when the course has reached maximum capacity.

#### 4. Registration System

* Create a class `RegistrationSystem` that maintains:

  * A collection of students (`Map<Integer, Student>`)
  * A collection of courses (`Map<String, Course>`)
* Implement methods to:

  * Add new students and courses.
  * Register a student for a course.
  * Display all enrollments (course-wise listing of students).

#### 5. Main Application

* In a `CollegeApp` class:

  * Add a few sample students and courses.
  * Demonstrate successful and failed registration attempts (to trigger exceptions).
  * Handle exceptions gracefully using `try-catch-finally`.
  * Display all enrollments at the end.

---

### Expected Output (Example)

```
✅ Amit enrolled in Data Structures
✅ Priya enrolled in Data Structures
⚠️ Course Error: Course Data Structures is full!

✅ Enrollment process complete.

=== COURSE ENROLLMENTS ===
Data Structures:
  - 101 - Amit
  - 102 - Priya
Operating Systems:
  (No students enrolled)
```

---

### Evaluation Criteria:

* Proper use of **OOP principles (Encapsulation, Classes, Objects)**
* Logical use of **Java Collections (Map, List, etc.)**
* Correct **exception handling** and meaningful error messages
* Clean and readable code structure

---

Would you like me to format this as a downloadable **assignment .docx or .pdf** for classroom use?
