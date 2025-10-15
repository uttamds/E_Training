

# 🧩 Add Student Entry UI (Project: `mysite`, App: `hello`)

---

## 🪜 Step 1: Update or Confirm Your Model

Make sure your model is defined properly in **`hello/models.py`**:

```python
# hello/models.py
from django.db import models

class Student(models.Model):
    roll = models.IntegerField()
    name = models.CharField(max_length=100)
    branch = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.roll} - {self.name}"
```

---

## ⚙️ Step 2: Create a Form

Create **`hello/forms.py`** if it doesn’t exist:

```python
# hello/forms.py
from django import forms
from .models import Student

class StudentForm(forms.ModelForm):
    class Meta:
        model = Student
        fields = ['roll', 'name', 'branch']
```

---

## 🧠 Step 3: Add the View

Edit **`hello/views.py`** and add the following code.

We’ll include both views — the existing **list** and new **create** view — in case you want redirection to work seamlessly.

```python
# hello/views.py
from django.shortcuts import render, redirect
from .models import Student
from .forms import StudentForm

def student_list(request):
    students = Student.objects.all()
    return render(request, 'student_list.html', {'students': students})


def student_create(request):
    if request.method == 'POST':
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('student_list')
    else:
        form = StudentForm()
    return render(request, 'student_form.html', {'form': form})
```

---

## 🌐 Step 4: Add URLs in **project-level `mysite/urls.py`**

Since you’re skipping app-level `urls.py`, just edit **`mysite/urls.py`** and connect the app’s views directly:

```python
# mysite/urls.py
from django.contrib import admin
from django.urls import path
from hello import views  # import from your app

urlpatterns = [
    path('admin/', admin.site.urls),
    path('students/', views.student_list, name='student_list'),
    path('students/new/', views.student_create, name='student_create'),
]
```

---

## 🎨 Step 5: Create the New Template for Form

Since you already have `student_list.html`, just create the new file **`student_form.html`** inside your templates folder.

Example:

```
hello/
│
├── templates/
│   ├── student_list.html   ← (already there)
│   └── student_form.html   ← (add this new one)
```

Now put this content inside `student_form.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Add New Student</title>
    <style>
        body { font-family: Arial; background-color: #f5f5f5; }
        .container {
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        input {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
        }
        button {
            background-color: #007BFF;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover { background-color: #0056b3; }
        a { text-decoration: none; display: block; margin-top: 10px; text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Student</h2>
        <form method="POST">
            {% csrf_token %}
            {{ form.as_p }}
            <button type="submit">Save</button>
        </form>
        <a href="{% url 'student_list' %}">Back to Student List</a>
    </div>
</body>
</html>
```

---

## ▶️ Step 6: Run and Test

Start your development server:

```bash
python manage.py runserver
```

Then test these routes:

* 🧾 **List Page:**
  [http://127.0.0.1:8000/students/](http://127.0.0.1:8000/students/)

* ➕ **Add Student Page:**
  [http://127.0.0.1:8000/students/new/](http://127.0.0.1:8000/students/new/)

---

✅ **You now have:**

* A fully functional student entry form (non-admin)
* Seamless redirect back to your existing `student_list.html`
* Clean and minimal setup with no app-level URL config

