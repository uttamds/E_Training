below is a **complete, step-by-step guide** to add a new model called **`Subject`** and create a **list view** for it, exactly like your student listing page.

## 🪜 Step 1: Open or Create `models.py`

Edit the file `school/models.py` and add the new model below your existing one.

```python
# school/models.py
from django.db import models

class Student(models.Model):
    roll = models.IntegerField()
    name = models.CharField(max_length=100)
    branch = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.roll} - {self.name}"


class Subject(models.Model):
    subcode = models.CharField(max_length=10, unique=True)
    subname = models.CharField(max_length=100)
    credits = models.IntegerField()

    def __str__(self):
        return f"{self.subcode} - {self.subname}"
```

---

## ⚙️ Step 2: Make and Apply Migrations

Run the following commands to update your database schema:

```bash
python manage.py makemigrations
python manage.py migrate
```

✅ This will create a new table called `school_subject` in your database.

---

## 🧠 Step 3: Register the Model in Django Admin

Open **`school/admin.py`** and register the model so you can manage subjects from the admin interface.

```python
# school/admin.py
from django.contrib import admin
from .models import Student, Subject

admin.site.register(Student)
admin.site.register(Subject)
```

---

## 🧑‍💻 Step 4: Create the View for Subject List

Open **`school/views.py`** and add the following view:

```python
# school/views.py
from django.shortcuts import render
from .models import Subject

def subject_list(request):
    subjects = Subject.objects.all()
    return render(request, 'subject_list.html', {'subjects': subjects})
```

---

## 🌐 Step 5: Add the URL Pattern

If your app doesn’t have a `urls.py`, create one inside your app folder (`school/urls.py`):

```python
# school/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('subjects/', views.subject_list, name='subject_list'),
]
```

Now include this file in your **main project `urls.py`** (the one usually beside `settings.py`):

```python
# project_name/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('school.urls')),
]
```

---

## 🎨 Step 6: Create the Template

Inside your app folder, create a folder named **templates** (if not already).
Then inside it, create a file named **`subject_list.html`**:

```
school/
│
├── templates/
│   └── subject_list.html
```

Now, put this code inside `subject_list.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Subject List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #888;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f0f0f0;
        }
        h1 {
            text-align: center;
            color: #333;
        }
    </style>
</head>
<body>
    <h1>List of Subjects</h1>
    <table>
        <tr>
            <th>Subject Code</th>
            <th>Subject Name</th>
            <th>Credits</th>
        </tr>
        {% for subject in subjects %}
        <tr>
            <td>{{ subject.subcode }}</td>
            <td>{{ subject.subname }}</td>
            <td>{{ subject.credits }}</td>
        </tr>
        {% empty %}
        <tr>
            <td colspan="3">No subjects available.</td>
        </tr>
        {% endfor %}
    </table>
</body>
</html>
```

---

## 🚀 Step 7: Run the Server

Start your Django development server:

```bash
python manage.py runserver
```

Then visit in your browser:

```
http://127.0.0.1:8000/subjects/
```

✅ You’ll now see a clean table showing all subjects stored in your database.

---

## 🧮 Optional: Add Sample Subjects via Admin

Go to:

```
http://127.0.0.1:8000/admin
```

Login and add a few subjects like:

| subcode | subname          | credits |
| ------- | ---------------- | ------- |
| CS101   | Data Structures  | 4       |
| CS102   | DBMS             | 3       |
| MA101   | Engineering Math | 4       |

Then refresh your `/subjects/` page — they’ll appear in the list.

---

### ✅ Summary of Files Modified

| File                          | Purpose                           |
| ----------------------------- | --------------------------------- |
| `models.py`                   | Added `Subject` model             |
| `admin.py`                    | Registered `Subject` for admin UI |
| `views.py`                    | Added `subject_list` view         |
| `urls.py`                     | Mapped `/subjects/` URL           |
| `templates/subject_list.html` | Created HTML listing page         |


