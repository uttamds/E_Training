# Apple Project: Customer Service Ticket Management System

This document contains the complete end-to-end setup for a Django project `apple` that mimics a customer service ticket management system.

---

## 1️⃣ Create Project and App
```bash
django-admin startproject apple
cd apple
python manage.py startapp tickets
```
Add `tickets` to `INSTALLED_APPS` in `apple/settings.py`:
```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'tickets',  # our app
]
```

---

## 2️⃣ Create Ticket Model
`tickets/models.py`
```python
from django.db import models

class Ticket(models.Model):
    phone_number = models.CharField(max_length=15)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Ticket {self.id} - {self.phone_number}"
```

---

## 3️⃣ Create Form
`tickets/forms.py`
```python
from django import forms
from .models import Ticket

class TicketForm(forms.ModelForm):
    class Meta:
        model = Ticket
        fields = ['phone_number']
        widgets = {
            'phone_number': forms.TextInput(attrs={'placeholder': 'Enter your phone number'})
        }
```

---

## 4️⃣ Create Views
`tickets/views.py`
```python
from django.shortcuts import render, redirect
from .forms import TicketForm
from .models import Ticket

# Home Page
def home(request):
    last_tickets = Ticket.objects.order_by('-created_at')[:5]  # last 5 tickets
    if request.method == 'POST':
        form = TicketForm(request.POST)
        if form.is_valid():
            ticket = form.save()
            return redirect('ticket_confirmation', ticket_id=ticket.id)
    else:
        form = TicketForm()
    return render(request, 'home.html', {'form': form, 'last_tickets': last_tickets})

# Confirmation Page
def ticket_confirmation(request, ticket_id):
    ticket = Ticket.objects.get(id=ticket_id)
    # Calculate queue position
    earlier_tickets = Ticket.objects.filter(created_at__lt=ticket.created_at).count()
    position = earlier_tickets + 1
    return render(request, 'confirmation.html', {'ticket': ticket, 'position': position})
```

---

## 5️⃣ Create Templates
Folder structure:
```
tickets/
└─ templates/
   └─ home.html
   └─ confirmation.html
```

### home.html
```html
<h1>Welcome to Apple Store Customer Service</h1>

<!-- Apple logo -->
<img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" width="200">

<form method="post">
  {% csrf_token %}
  {{ form.as_p }}
  <button type="submit">Get Ticket</button>
</form>

<h3>Last 5 Tickets:</h3>
<ul>
  {% for t in last_tickets %}
    <li>Ticket {{ t.id }} - {{ t.phone_number }}</li>
  {% empty %}
    <li>No tickets issued yet.</li>
  {% endfor %}
</ul>
```

### confirmation.html
```html
<h2>Ticket Confirmation</h2>
<p>Thank you! Your ticket number is: <strong>{{ ticket.id }}</strong></p>
<p>Your position in the queue is: <strong>{{ position }}</strong></p>
<p>Please wait for your turn.</p>
<a href="{% url 'home' %}">Go back to home</a>
```

---

## 6️⃣ Add URLs
### tickets/urls.py
```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('confirmation/<int:ticket_id>/', views.ticket_confirmation, name='ticket_confirmation'),
]
```

### apple/urls.py
```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('tickets.urls')),  # Home page and ticket flow
]
```

---

## 7️⃣ Migrate Database
```bash
python manage.py makemigrations
python manage.py migrate
```

---

## 8️⃣ Run Server
```bash
python manage.py runserver
```

- **Home Page:** http://127.0.0.1:8000/  
  Shows Apple logo, phone number input, and last 5 tickets.  

- **After submitting phone number:**  
  Redirects to `/confirmation/<ticket_id>/` with ticket number and queue position.  

- **Admin Page:** http://127.0.0.1:8000/admin/  
  Superuser can see all tickets.

---

## ✅ Summary

| Feature | Implementation |
|----------|----------------|
| Home page | Form to enter phone number + Apple logo + last 5 tickets |
| Ticket creation | `Ticket` model + `TicketForm` |
| Confirmation | Shows ticket ID + queue position |
| Queue position | Calculated via `created_at` timestamps |
| Admin | Manage tickets via `/admin/` |

---

This is a **fully working minimal ticket management system** named `apple` with queue position tracking.

