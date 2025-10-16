

## ✅ Goal

* Accept candidate input (name, email, age).
* Validate that the email is valid and age > 18.
* Save valid entries into SQLite (your project’s default DB).
* Display a simple success page after saving.

---

## 🧩 Step-by-Step Implementation

### **1️⃣ Create the Model**

File: `hello/models.py`

```python
from django.db import models

class Candidate(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    age = models.IntegerField()

    def __str__(self):
        return self.name
```

---

### **2️⃣ Create the Form with Validation**

File: `hello/forms.py`

```python
from django import forms
from .models import Candidate

class CandidateForm(forms.ModelForm):
    class Meta:
        model = Candidate
        fields = ['name', 'email', 'age']

    def clean_age(self):
        age = self.cleaned_data.get('age')
        if age < 18:
            raise forms.ValidationError("Age must be at least 18 years old.")
        return age
```

---

### **3️⃣ Create the View**

File: `hello/views.py`

```python
from django.shortcuts import render, redirect
from .forms import CandidateForm

def candidate_view(request):
    if request.method == 'POST':
        form = CandidateForm(request.POST)
        if form.is_valid():
            form.save()  # ✅ Save to SQLite
            return render(request, 'success.html')
    else:
        form = CandidateForm()

    return render(request, 'candidate_form.html', {'form': form})
```

---

### **4️⃣ Create Templates**

#### `templates/candidate_form.html`

```html
<h2>Candidate Registration</h2>
<form method="post">
  {% csrf_token %}
  {{ form.as_p }}
  <button type="submit">Submit</button>
</form>
```

#### `templates/success.html`

```html
<h2>Candidate Registered Successfully!</h2>
<a href="{% url 'candidate_form' %}">Add another candidate</a>
```

---

### **5️⃣ Add a URL Route**

If you already have `mysite/urls.py` managing your app URLs directly, add:

```python
# mysite/urls.py
from django.contrib import admin
from django.urls import path
from hello import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('candidate/', views.candidate_view, name='candidate_form'),
]
```

*(You mentioned we can skip app urls — so this goes in the project urls directly.)*

---

### **6️⃣ Run Migrations**

Run these in the terminal from the project root:

```bash
python manage.py makemigrations
python manage.py migrate
```

This creates the `hello_candidate` table in your **SQLite database**.

---

### **7️⃣ Test the Form**

Run the server:

```bash
python manage.py runserver
```

Open your browser and visit:

```
http://127.0.0.1:8000/candidate/
```

Try submitting:

* Invalid email → form shows error.
* Age < 18 → form shows “Age must be at least 18 years old.”
* Valid data → gets saved to SQLite and redirects to success page.

---

### **8️⃣ (Optional) View Data in Django Admin**

If you want to see stored candidates in the admin UI:

**hello/admin.py**

```python
from django.contrib import admin
from .models import Candidate

admin.site.register(Candidate)
```

Then create a superuser if not already done:

```bash
python manage.py createsuperuser
```

Login to:

```
http://127.0.0.1:8000/admin/
```

---


