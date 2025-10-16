Perfect — here’s a **complete set of steps** to create a new Django app called **`amazon`** inside your existing project `mysite` with **user registration, login, logout, and dashboard** functionality. We’ll ignore the image part. This is a ready-to-run demo.

---

## ✅ Full Steps: Amazon App with Auth Demo

---

### **1️⃣ Create the App**

From your project root (`mysite`):

```bash
python manage.py startapp amazon
```

Add the app to `INSTALLED_APPS` in `mysite/settings.py`:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'amazon',  # ✅ new app
]
```

---

### **2️⃣ Create Views**

File: `amazon/views.py`

```python
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User

# User Registration
def register(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        confirm = request.POST['confirm']

        if password != confirm:
            return render(request, 'register.html', {'error': 'Passwords do not match'})
        if User.objects.filter(username=username).exists():
            return render(request, 'register.html', {'error': 'Username already exists'})

        User.objects.create_user(username=username, email=email, password=password)
        return redirect('login')

    return render(request, 'register.html')

# User Login
def user_login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('dashboard')
        else:
            return render(request, 'login.html', {'error': 'Invalid credentials'})
    return render(request, 'login.html')

# Dashboard (Protected)
@login_required
def dashboard(request):
    return render(request, 'dashboard.html')

# Logout
def user_logout(request):
    logout(request)
    return redirect('login')
```

---

### **3️⃣ Create Templates**

Create a folder structure:

```
amazon/
└─ templates/
   └─ register.html
   └─ login.html
   └─ dashboard.html
```

#### **register.html**

```html
<h2>User Registration</h2>
{% if error %}
  <p style="color:red;">{{ error }}</p>
{% endif %}
<form method="post">
  {% csrf_token %}
  <label>Username:</label><br>
  <input type="text" name="username" required><br><br>

  <label>Email:</label><br>
  <input type="email" name="email" required><br><br>

  <label>Password:</label><br>
  <input type="password" name="password" required><br><br>

  <label>Confirm Password:</label><br>
  <input type="password" name="confirm" required><br><br>

  <button type="submit">Register</button>
</form>

<p>Already have an account? <a href="{% url 'login' %}">Login here</a></p>
```

#### **login.html**

```html
<h2>Login</h2>
{% if error %}
  <p style="color:red;">{{ error }}</p>
{% endif %}
<form method="post">
  {% csrf_token %}
  <label>Username:</label><br>
  <input type="text" name="username" required><br><br>

  <label>Password:</label><br>
  <input type="password" name="password" required><br><br>

  <button type="submit">Login</button>
</form>

<p>Don’t have an account? <a href="{% url 'register' %}">Register</a></p>
```

#### **dashboard.html**

```html
<h2>Welcome, {{ request.user.username }}!</h2>
<p>This is your dashboard.</p>
<a href="{% url 'logout' %}">Logout</a>
```

---

### **4️⃣ Add URLs**

Edit `mysite/urls.py`:

```python
from django.contrib import admin
from django.urls import path
from amazon import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('register/', views.register, name='register'),
    path('login/', views.user_login, name='login'),
    path('logout/', views.user_logout, name='logout'),
    path('dashboard/', views.dashboard, name='dashboard'),
]
```

---

### **5️⃣ Run Migrations and Superuser**

Make sure database tables are ready:

```bash
python manage.py makemigrations
python manage.py migrate
```

Create a superuser (if not already done) to access admin:

```bash
python manage.py createsuperuser
```

---

### **6️⃣ Run the Server**

```bash
python manage.py runserver
```

---

### **7️⃣ Test the App**

* **Register page:** [http://127.0.0.1:8000/register/](http://127.0.0.1:8000/register/)
  Create a new user.

* **Login page:** [http://127.0.0.1:8000/login/](http://127.0.0.1:8000/login/)
  Login with the registered credentials.

* **Dashboard page:** [http://127.0.0.1:8000/dashboard/](http://127.0.0.1:8000/dashboard/)
  Accessible only after login.

* **Logout:** [http://127.0.0.1:8000/logout/](http://127.0.0.1:8000/logout/)
  Ends the session and redirects to login.

* **Admin:** [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)
  Manage users, groups, and permissions.

---

### ✅ Summary

| Feature      | How it’s implemented                              |
| ------------ | ------------------------------------------------- |
| Registration | `register` view, `User.objects.create_user`       |
| Login        | `user_login` view, `authenticate()` and `login()` |
| Dashboard    | `dashboard` view with `@login_required`           |
| Logout       | `user_logout` view with `logout()`                |
| Admin        | Superuser can manage all users                    |

---

This is a **complete working setup** for a new app `amazon` with **registration, login, logout, and session management**.

If you want, I can also provide a **diagram showing the flow of registration → login → dashboard → logout** for quick understanding.

Do you want me to do that?
