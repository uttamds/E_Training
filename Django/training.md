# Progressive **bare-minimum → real-world** Django training (clean, hands-on — ready to teach)

Nice — I’ll keep this tight and practical. Every module follows the format you like: **Topic**, **Simple code to demo**, **Explanation** (+ short exercises). I’ll assume Python basics, HTML/CSS and a terminal are already known.
Notes: latest stable Django (LTS) is  **Django 5.2.7** (install examples below). For guided learning start with the official “Getting started” tutorial. ([Django Project][1])

---

## Quick setup (prereqs & facts)

* Use a virtual environment (venv) and install the LTS Django release:
  `python -m pip install Django==5.2.7` (or `py -m pip install Django==5.2.7` on Windows). ([Django Project][1])
* Confirm Python compatibility before choosing a Django/Python combo (Django docs cover supported Python versions). ([Django Project][2])

---

# Training modules (bare minimum → progressing)

### Module 0 — Project setup & “Hello world”

**Topic:** Create project, app, run dev server.
**Simple code to demo (commands):**

```bash
# create venv, activate
python -m venv venv
# Linux/macOS
source venv/bin/activate
# Windows (PowerShell)
venv\Scripts\Activate.ps1

# install Django (LTS)
python -m pip install Django==5.2.7

# start project & app
django-admin startproject crux_site
cd crux_site
python manage.py startapp students

# run server
python manage.py runserver
```

**Explanation:** Creates a project (`crux_site`) with `manage.py`, an app (`students`) and runs the dev server. You’ll use `manage.py` for migrations, shell, tests, etc.

**Exercises:** Start project, create one app, open `http://127.0.0.1:8000/` and confirm server runs.

---

### Module 1 — URLs & function-based views (bare minimum)

**Topic:** Map a URL to a view; return simple HttpResponse.
**Simple code to demo:**

`students/views.py`

```python
from django.http import HttpResponse

def hello(request):
    return HttpResponse("Hello from Crux Training — Hi Aarav!")
```

`crux_site/urls.py` (project-level)

```python
from django.urls import path, include
from django.contrib import admin

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("students.urls")),   # include app urls
]
```

`students/urls.py`

```python
from django.urls import path
from .views import hello

urlpatterns = [ path("", hello, name="home") ]
```

**Explanation:** The URL dispatcher routes HTTP requests to your view callables. Function-based views are great to start with.

**Exercises:** Add `/about/` route that returns a small HTML snippet.

---

### Module 2 — Templates & static files

**Topic:** Render HTML templates with context and serve CSS/JS.
**Simple code to demo:**

`students/views.py`

```python
from django.shortcuts import render

def home(request):
    return render(request, "students/home.html", {"name": "Priya"})
```

`students/templates/students/home.html`

```html
<!doctype html>
<html>
  <body>
    <h1>Welcome, {{ name }}!</h1>
  </body>
</html>
```

**Explanation:** `render()` connects views to templates; templates use `{{ }}` for variables. Static files (css/js/images) live under `static/` and are collected in production. (See docs for templates & staticfiles). ([Django Project][3])

**Exercises:** Add a CSS file under `students/static/students/style.css` and link it.

---

### Module 3 — Models & ORM (core)

**Topic:** Define database models, create & run migrations.
**Simple code to demo:**

`students/models.py`

```python
from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=120)
    email = models.EmailField(unique=True)
    joined_on = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
```

Terminal:

```bash
python manage.py makemigrations
python manage.py migrate
python manage.py shell
# in shell
from students.models import Student
Student.objects.create(name="Asha", email="asha@example.com")
```

**Explanation:** Models are Python classes mapping to DB tables. Django’s ORM gives you `.objects` querysets to create/read/update/delete data. ([Django Project][4])

**Exercises:** Create `Course` model and relate `Student` with `ManyToManyField`; write queries to list students in a course.

---

### Module 4 — Admin site & quick CRUD

**Topic:** Use Django admin to manage models (fast internal UI).
**Simple code to demo:**

`students/admin.py`

```python
from django.contrib import admin
from .models import Student

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    list_display = ("name", "email", "joined_on")
```

Terminal:

```bash
python manage.py createsuperuser   # create admin user
python manage.py runserver
# open http://127.0.0.1:8000/admin/ and login
```

**Explanation:** The admin auto-generates a secure, model-centric UI for trusted staff to manage content. Good for demos and internal tools. ([Django Project][5])

**Exercises:** Customize list filters and search fields in admin for `Student`.

---

### Module 5 — Forms & validation (user input)

**Topic:** Accept and validate form data (ModelForm).
**Simple code to demo:**

`students/forms.py`

```python
from django import forms
from .models import Student

class StudentForm(forms.ModelForm):
    class Meta:
        model = Student
        fields = ["name", "email"]
```

`students/views.py` (create view snippet)

```python
def add_student(request):
    if request.method == "POST":
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect("home")
    else:
        form = StudentForm()
    return render(request, "students/add.html", {"form": form})
```

**Explanation:** Django forms (and ModelForms) handle input rendering, validation and save logic safely — preventing common issues like XSS/CSRF (CSRF middleware inserts tokens automatically in templates).

**Exercises:** Add client and server-side validation; show form errors in template.

---

### Module 6 — Authentication & permissions (built-in)

**Topic:** Use `django.contrib.auth` for login/logout, protected views.
**Simple code to demo:**

`crux_site/urls.py`

```python
from django.contrib.auth import views as auth_views

urlpatterns += [
    path("login/", auth_views.LoginView.as_view(template_name="auth/login.html"), name="login"),
    path("logout/", auth_views.LogoutView.as_view(next_page="/"), name="logout"),
]
```

Protect a view:

```python
from django.contrib.auth.decorators import login_required

@login_required
def dashboard(request):
    ...
```

**Explanation:** Django ships a full auth system (users, groups, password hashing) and ready auth views. Use `@login_required` or per-object permissions for access control.

**Exercises:** Add registration (custom view) and restrict certain pages to staff users.

---

### Module 7 — Class-based generic views (progressing)

**Topic:** Use ListView/DetailView/CreateView etc. to speed CRUD pages.
**Simple code to demo:**

`students/views.py`

```python
from django.views.generic import ListView, DetailView, CreateView
from .models import Student

class StudentList(ListView):
    model = Student
    template_name = "students/student_list.html"

class StudentCreate(CreateView):
    model = Student
    fields = ["name", "email"]
    success_url = "/"
```

**Explanation:** Class-based generic views provide reusable building blocks for common patterns (lists, detail pages, forms). They help keep views concise and DRY. ([Django Project][6])

**Exercises:** Replace earlier function-based views with CBVs; add pagination and search.

---

### Module 8 — Migrations, data migrations & best practices

**Topic:** Manage schema changes safely with `makemigrations` & `migrate`.
**Simple code to demo:**

```bash
# after changing models
python manage.py makemigrations
python manage.py migrate

# create a data migration (example)
python manage.py makemigrations --empty students
# then edit the migration file to add RunPython operations
```

**Explanation:** Migrations are Django’s way to version and apply schema changes; data migrations let you move or transform existing data. Know how to resolve conflicts and inspect SQL when needed. ([Django Project][7])

**Exercises:** Add a new non-nullable field and write a data migration to populate it for existing rows.

---

### Module 9 — Testing & debugging

**Topic:** Unit tests with `TestCase`, use `manage.py test`.
**Simple code to demo:**

`students/tests.py`

```python
from django.test import TestCase
from .models import Student

class StudentTest(TestCase):
    def test_create_student(self):
        s = Student.objects.create(name="Ravi", email="ravi@example.com")
        self.assertEqual(str(s), "Ravi")
```

**Explanation:** Django’s test suite wraps DB and provides test client for request/response testing. Encourage TDD for critical features.

**Exercises:** Add tests for forms, views (authenticated vs anonymous), and model methods.

---

### Module 10 — Simple deployment checklist & static files

**Topic:** Production checklist essentials: DEBUG=False, ALLOWED_HOSTS, SECRET_KEY management, collectstatic and use WSGI/ASGI server.
**Simple code to demo:**

```bash
# collect static files for production
python manage.py collectstatic

# run checks
python manage.py check --deploy
```

**Explanation:** Before going live, run Django’s deployment checklist and serve static files from a web server or CDN. Don’t use `runserver` in production. See Django deployment docs for details. ([Django Project][8])

**Exercises:** Deploy a minimal site to a PaaS (Heroku/DigitalOcean App Platform) or a simple VM, serve static files, and test HTTPS redirect.

---

### Module 11 — Optional / advanced topics (pick as needed)

* **REST APIs:** use Django REST Framework (DRF) for API endpoints (optional extra).
* **Asynchronous views & channels:** ASGI support for websockets/async tasks.
* **Caching & performance:** cache templates/data, DB indexing.
* **Celery or background jobs** for long-running tasks.

(Include DRF or async only when students are comfortable with basic CRUD + auth.)

---

## Teaching recipe & mini-projects (progression)

* **Micro-project 1 (beginner):** Student Directory — list, add, edit students; admin enabled.
* **Micro-project 2 (intermediate):** Course Registration — students enroll in courses (ManyToMany), email confirmations.
* **Micro-project 3 (advanced):** Small blog with user accounts, comments, pagination, REST API endpoints for posts.
  Use Indian example names like *Aarav, Priya, Asha, Ravi* in seed data and screenshots (you mentioned you prefer Indian names).

---

## Recommended learning path & resources

1. Official tutorial: **Getting started / tutorial** (follow first 7–8 parts to build a site). ([Django Project][9])
2. Django download/install page (install exact version): install 5.2.7 LTS example. ([Django Project][1])
3. Models, Templates, Migrations, Class-based views (topic pages from Django docs). ([Django Project][4])
4. Deployment checklist & static files docs before going live. ([Django Project][8])

---

## Short sample 6-session syllabus (bare outline you can expand)

1. Session 1 — Setup, project/app, URLs & views, runserver. (Hands-on)
2. Session 2 — Templates & static files; small UI.
3. Session 3 — Models & migrations; admin.
4. Session 4 — Forms, ModelForms, input validation.
5. Session 5 — Authentication + Class-based views CRUD.
6. Session 6 — Tests, deployment checklist, mini-project wrap up.

(If you want, I can convert the above into a **detailed 6-session slide deck or printable handout** with exercises and sample answers.)

---

If you want, I’ll:

* produce a **detailed lesson plan** for each session (slides/notes + code snippets + exercises + model answers), or
* generate a **starter project repo structure** (file tree + exact files) you can give to students, or
* convert the 6-session plan into a printable **.md** or **PDF**.

Which of those would you like next? (I won’t run anything — I’ll just generate the materials here.)

[1]: https://www.djangoproject.com/download/?utm_source=chatgpt.com "Download Django"
[2]: https://docs.djangoproject.com/en/5.2/faq/install/?utm_source=chatgpt.com "FAQ: Installation"
[3]: https://docs.djangoproject.com/en/5.2/topics/templates/?utm_source=chatgpt.com "Templates | Django documentation"
[4]: https://docs.djangoproject.com/en/5.2/topics/db/models/?utm_source=chatgpt.com "Models"
[5]: https://docs.djangoproject.com/en/5.2/ref/contrib/admin/?utm_source=chatgpt.com "The Django admin site"
[6]: https://docs.djangoproject.com/en/5.2/topics/class-based-views/?utm_source=chatgpt.com "Class-based views"
[7]: https://docs.djangoproject.com/en/5.2/topics/migrations/?utm_source=chatgpt.com "Migrations | Django documentation"
[8]: https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/?utm_source=chatgpt.com "Deployment checklist | Django documentation"
[9]: https://docs.djangoproject.com/en/5.2/intro/?utm_source=chatgpt.com "Getting started | Django documentation"
