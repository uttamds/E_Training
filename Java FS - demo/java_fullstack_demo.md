# 🎓 Java Fullstack Demo: Student Portal

## 🎯 Objective
Show students how a **Java Fullstack application** works end-to-end:
- **Frontend → Backend → Database**
- Relatable use case: **Student Portal** (Register, Login, View Profile)

---

## 🛠️ Tech Stack
- **Frontend**: React (or simple HTML/JS for quick demo)
- **Backend**: Java Spring Boot (REST APIs)
- **Database**: MySQL (Student data)

---

## 📍 Demo Flow
1. **Register** → Save student in DB
2. **Login** → Validate credentials
3. **View Profile** → Fetch details from DB

---

## 🔹 Architecture Diagram
```
[Frontend: React/HTML/JS]  --->  [Backend: Spring Boot REST APIs]  --->  [Database: MySQL]
```
- Frontend sends requests (Register/Login/Profile)
- Backend processes requests, talks to DB
- Database stores and returns student data

---

## 🔹 Workflow Diagram
```
Student Action → API Call → Backend Logic → DB Interaction → Response → UI Update

Example:
Register → POST /students/register → Save in DB → Return Student ID → Show Success Message
```

---

## 🔹 Step 1: Backend (Spring Boot)

### Entity: Student
```java
@Entity
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
    private String password;
}
```

### Controller
```java
@RestController
@RequestMapping("/students")
public class StudentController {
    @Autowired
    private StudentRepository repo;

    @PostMapping("/register")
    public Student register(@RequestBody Student student) {
        return repo.save(student);
    }

    @PostMapping("/login")
    public String login(@RequestBody Student student) {
        Student dbStudent = repo.findByEmail(student.getEmail());
        if (dbStudent != null && dbStudent.getPassword().equals(student.getPassword())) {
            return "Login Successful: " + dbStudent.getName();
        }
        return "Invalid Credentials";
    }

    @GetMapping("/{id}")
    public Student getProfile(@PathVariable Long id) {
        return repo.findById(id).orElse(null);
    }
}
```

---

## 🔹 Step 2: Database (MySQL)
```sql
CREATE DATABASE student_portal;
```

**application.properties**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/student_portal
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update
```

---

## 🔹 Step 3: Frontend (React Example)
```jsx
function App() {
  const [msg, setMsg] = useState("");

  const handleRegister = async () => {
    const res = await fetch("http://localhost:8080/students/register", {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({name: "Ravi", email: "ravi@test.com", password: "1234"})
    });
    const data = await res.json();
    setMsg("Registered: " + data.name);
  };

  return (
    <div>
      <h1>Student Portal</h1>
      <button onClick={handleRegister}>Register Student</button>
      <p>{msg}</p>
    </div>
  );
}
```

---

## 🎬 Live Demo Plan (15–20 min)

### ⏱️ 0–5 min → Introduction
- Explain **Fullstack architecture**
- Show **Architecture Diagram**

### ⏱️ 5–10 min → Backend Setup
- Create Spring Boot project
- Show **register/login/profile APIs**

### ⏱️ 10–15 min → Database Integration
- Connect to MySQL
- Show student data being saved

### ⏱️ 15–20 min → Frontend Demo
- Register student → Data saved in DB
- Login with credentials → Success message
- Fetch profile → Show stored details
- Show **Workflow Diagram**

---

## 🚀 Optional Extensions
- Deploy backend on **Heroku/Render**
- Deploy frontend on **Netlify/Vercel**
- Add **Admin view** (list of all students)

---

✅ By the end, students see a **working Java Fullstack application** they can relate to, supported with **visual architecture + workflow diagrams**.

