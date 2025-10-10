Perfect — here’s an **end-to-end Django illustration** (no virtual environment, no database yet) — just enough to understand **how Django’s request–response cycle works**, using **a single app**, a **view**, and **templates**.

This setup works entirely in memory, no DB, no models — just **URLs, views, templates, and the dev server**.

---

## 🧭 Goal

Create a minimal Django app that:

1. Displays a homepage (`/`)
2. Displays another page (`/greet/<name>/`)
3. Uses templates for rendering

---

## 🧩 Folder Structure (after steps below)

```
mysite/
│
├── manage.py
├── mysite/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   └── wsgi.py
│
└── hello/
    ├── __init__.py
    ├── urls.py
    ├── views.py
    └── templates/
        └── hello/
            ├── home.html
            └── greet.html
```

---

## ⚙️ Step 1 — Create Project & App

```bash
django-admin startproject mysite
cd mysite
python manage.py startapp hello
```

---

## 🧠 Step 2 — Register the App

Open `mysite/settings.py`, find `INSTALLED_APPS`, and add:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'hello',     # 👈 add this line
]
```

---

## 🌐 Step 3 — Define URLs

### `mysite/urls.py`

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('hello.urls')),   # 👈 include app-level URLs
]
```

### `hello/urls.py`

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('greet/<str:name>/', views.greet, name='greet'),
]
```

---

## 🧩 Step 4 — Write Views

### `hello/views.py`

```python
from django.shortcuts import render

def home(request):
    return render(request, 'hello/home.html')

def greet(request, name):
    return render(request, 'hello/greet.html', {'person': name})
```

---

## 🎨 Step 5 — Create Templates

Inside the app folder, create:
`hello/templates/hello/home.html`

```html
<!DOCTYPE html>
<html>
<head>
  <title>Home | Crux Training</title>
</head>
<body>
  <h1>Welcome to Crux Training Solutions!</h1>
  <p>Try visiting <a href="/greet/Aarav/">Greet Aarav</a></p>
</body>
</html>
```

`hello/templates/hello/greet.html`

```html
<!DOCTYPE html>
<html>
<head>
  <title>Greeting</title>
</head>
<body>
  <h1>Hello, {{ person }}!</h1>
  <p>This is rendered through a Django template.</p>
  <a href="/">Go back home</a>
</body>
</html>
```

---

## 🚀 Step 6 — Run the Server

From the project folder (where `manage.py` lives):

```bash
python manage.py runserver
```

Visit:

* **[http://127.0.0.1:8000/](http://127.0.0.1:8000/)** → Home Page
* **[http://127.0.0.1:8000/greet/Aarav/](http://127.0.0.1:8000/greet/Aarav/)** → Dynamic Greeting Page

---

## ⚡ What’s Happening Internally

1. **Browser** requests `/greet/Aarav/`.
2. **`urls.py`** maps that path to `views.greet`.
3. **View** prepares context data (`name`) and calls `render()`.
4. **Template** replaces `{{ person }}` with `"Aarav"`.
5. **Response** goes back to browser.

---

## 💡 Key Takeaway

Even without a database, Django provides:

* Organized folder structure
* Clear separation of logic (View) and presentation (Template)
* Powerful URL mapping system
* Built-in development server

This is the **purest “Hello Django” workflow** — enough to teach how the framework processes requests.

---

Would you like me to extend this same illustration **to include database + model + form (next stage)**, as a natural continuation?
