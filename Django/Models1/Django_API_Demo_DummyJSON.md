
# Django Mini Demo — Fetching and Displaying API Data (DummyJSON)

## 🎯 Objective

Create a small Django demo that fetches user data from the public API `https://dummyjson.com/users` and displays it beautifully using a table styled with inline CSS.

---

## 🧩 Setup Details

- **Project name:** `mysite`
- **App name:** `hello`

We’ll use the `requests` library to fetch live JSON data and render it through a Django template.

---

## ✅ Complete Steps

### 1️⃣ Install `requests`

```bash
pip install requests
```

---

### 2️⃣ Add view in `hello/views.py`

```python
import requests
from django.shortcuts import render

def api_users(request):
    # Fetch JSON data from DummyJSON API
    response = requests.get('https://dummyjson.com/users')
    data = response.json()
    users = data.get('users', [])
    return render(request, 'api_users.html', {'users': users})
```

---

### 3️⃣ Add URL in `hello/urls.py`

```python
from django.urls import path
from . import views

urlpatterns = [
    path('api-users/', views.api_users, name='api_users'),
]
```

If not already included, make sure `mysite/urls.py` has:

```python
path('hello/', include('hello.urls')),
```

---

### 4️⃣ Create Template — `hello/templates/api_users.html`

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>DummyJSON Users</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f6f9fc;
      margin: 30px;
    }
    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }
    table {
      width: 80%;
      margin: auto;
      border-collapse: collapse;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
    }
    th {
      background-color: #007bff;
      color: white;
      padding: 10px;
      text-align: left;
    }
    td {
      padding: 10px;
      border-bottom: 1px solid #ddd;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
  </style>
</head>
<body>
  <h2>DummyJSON User Data</h2>
  <table>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Email</th>
      <th>Age</th>
      <th>Gender</th>
    </tr>

    {% for user in users %}
    <tr>
      <td>{{ user.id }}</td>
      <td>{{ user.firstName }} {{ user.lastName }}</td>
      <td>{{ user.email }}</td>
      <td>{{ user.age }}</td>
      <td>{{ user.gender }}</td>
    </tr>
    {% endfor %}
  </table>
</body>
</html>
```

---

### 5️⃣ Run the Django server

```bash
python manage.py runserver
```

---

### 6️⃣ Access the Demo

Visit in browser:  
👉 [http://127.0.0.1:8000/hello/api-users/](http://127.0.0.1:8000/hello/api-users/)

---

## 💡 Teaching Pointers

- Demonstrates Django acting as a client consuming an external REST API.
- Shows JSON → Python (`.json()`), then rendering data in a Django template.
- Introduces inline CSS for styling without static files.
- Great mini-project to teach **API consumption** in Django.

---

✅ **End of Demo — DummyJSON API Integration in Django**
