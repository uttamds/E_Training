Here’s the **enhanced, single complete demo file** that now includes everything up to **path parameters** —
so you can show how Django’s URL dispatcher handles **dynamic URLs like `/students/101/`** for viewing details of one student.

---

# 🧩 Django Demo — Admin UI + Frontend (Student Model with Path Parameters)

### 💡 Objective

To demonstrate how Django’s **Admin UI**, **Views**, **Templates**, and **URL dispatcher** work together.
Students will learn to manage data via Admin and access it via URLs like `/students/` and `/students/101/`.

---

## STEP 1️⃣ — Define the Model

**File:** `hello/models.py`

```python
from django.db import models

class Student(models.Model):
    roll = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    branch = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.roll} - {self.name}"
```

---

## STEP 2️⃣ — Apply Migrations

```bash
python manage.py makemigrations hello
python manage.py migrate
```

---

## STEP 3️⃣ — Create a Superuser

```bash
python manage.py createsuperuser
```

Use this to log into Django’s Admin interface.

---

## STEP 4️⃣ — Register the Model in Admin

**File:** `hello/admin.py`

```python
from django.contrib import admin
from .models import Student

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    list_display = ('roll', 'name', 'branch')
    search_fields = ('name', 'branch')
```

---

## STEP 5️⃣ — Ensure App is in Settings

**File:** `mysite/settings.py`

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'hello',
]
```

---

## STEP 6️⃣ — Views (List + Detail)

**File:** `hello/views.py`

```python
from django.shortcuts import render, get_object_or_404
from .models import Student

# List View
def student_list(request):
    students = Student.objects.all()
    return render(request, 'student_list.html', {'students': students})

# Detail View (using path parameter)
def student_detail(request, roll):
    student = get_object_or_404(Student, pk=roll)
    return render(request, 'student_detail.html', {'student': student})
```

---

## STEP 7️⃣ — URLs with Path Parameters

**File:** `hello/urls.py`

```python
from django.urls import path
from . import views

urlpatterns = [
    path('students/', views.student_list, name='student_list'),
    path('students/<int:roll>/', views.student_detail, name='student_detail'),
]
```

Include this in **`mysite/urls.py`**:

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('hello.urls')),
]
```

---

## STEP 8️⃣ — Templates

### 🔹 `student_list.html`

```html
<h2>Student List</h2>
<table border="1" cellpadding="6">
  <tr>
    <th>Roll</th>
    <th>Name</th>
    <th>Branch</th>
  </tr>
  {% for s in students %}
  <tr>
    <td><a href="{% url 'student_detail' s.roll %}">{{ s.roll }}</a></td>
    <td>{{ s.name }}</td>
    <td>{{ s.branch }}</td>
  </tr>
  {% empty %}
  <tr><td colspan="3">No students found.</td></tr>
  {% endfor %}
</table>
```

### 🔹 `student_detail.html`

```html
<h2>Student Details</h2>
<p><strong>Roll:</strong> {{ student.roll }}</p>
<p><strong>Name:</strong> {{ student.name }}</p>
<p><strong>Branch:</strong> {{ student.branch }}</p>
<p><a href="{% url 'student_list' %}">Back to list</a></p>
```

---

## STEP 9️⃣ — Run and Test

```bash
python manage.py runserver
```

* Go to **[http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)** → Add a few students
* Visit **[http://127.0.0.1:8000/students/](http://127.0.0.1:8000/students/)** → List view
* Click on a roll number → opens **[http://127.0.0.1:8000/students/101/](http://127.0.0.1:8000/students/101/)** → Detail view

---

## ✅ What This Demo Shows

| Concept             | Explanation                                      |
| ------------------- | ------------------------------------------------ |
| **Models**          | Define data structure (`Student`)                |
| **Admin**           | Manage data using Django’s built-in UI           |
| **Views**           | Fetch and render data to templates               |
| **URL Dispatcher**  | Maps URL patterns to view functions              |
| **Path Parameters** | Handle dynamic URLs like `/students/101/`        |
| **Templates**       | Display data using HTML and Django template tags |

---

Would you like me to make a **concise classroom version** of this — a 1-page “trainer handout” summarizing just the file names, code snippets, and test URLs (no explanations)?
That version works great as a **demo reference sheet** for students.
