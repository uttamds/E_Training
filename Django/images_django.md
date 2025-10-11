Perfect 👍 — if you’re **not using `models.py` yet** (i.e., you haven’t introduced databases or ORM), you can **still handle images** in Django using **simple file upload logic** — entirely via views, forms, and templates.

Here’s how to do it step-by-step 👇

---

## 🧩 Goal

Allow the user to **upload an image** and then **display it back** on a results page —
✅ without using `models.py` or a database.

---

## ⚙️ Step 1: Update `settings.py`

Add a folder to store uploaded files (say, `/media`):

```python
# settings.py
import os

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
```

This tells Django where to store and access uploaded files.

---

## 🛣️ Step 2: Configure `urls.py`

Make Django serve media files during development.

```python
# urls.py
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from myapp import views

urlpatterns = [
    path('', views.index, name='index'),
    path('upload/', views.upload_image, name='upload'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

---

## 📄 Step 3: Create Templates

### `templates/index.html`

A simple form for file upload:

```html
<h2>Upload an Image</h2>

<form method="post" enctype="multipart/form-data" action="/upload/">
    {% csrf_token %}
    <input type="file" name="image">
    <button type="submit">Upload</button>
</form>
```

### `templates/display.html`

Show the uploaded image:

```html
<h2>Uploaded Image</h2>
<img src="{{ image_url }}" alt="Uploaded Image" width="250">
<br>
<a href="/">Upload Another</a>
```

---

## 🧠 Step 4: Write the View Logic

```python
# views.py
from django.shortcuts import render
from django.core.files.storage import FileSystemStorage

def index(request):
    return render(request, 'index.html')

def upload_image(request):
    if request.method == 'POST' and request.FILES['image']:
        image = request.FILES['image']
        fs = FileSystemStorage()
        filename = fs.save(image.name, image)
        image_url = fs.url(filename)
        return render(request, 'display.html', {'image_url': image_url})
    return render(request, 'index.html')
```

---

## 📁 Folder Structure

```
project_root/
│
├── myapp/
│   ├── views.py
│   ├── templates/
│   │   ├── index.html
│   │   └── display.html
│
├── media/
│   └── (uploaded images will appear here)
│
├── manage.py
└── settings.py
```

---

## 🧠 How It Works

| Step                                                   | What Happens                      |
| ------------------------------------------------------ | --------------------------------- |
| User selects image and clicks upload                   | Browser sends file to Django      |
| Django saves it via `FileSystemStorage()`              | File is written to `/media/`      |
| `fs.url()` generates a link                            | View sends that URL to template   |
| Template shows image via `<img src="{{ image_url }}">` | Browser renders the uploaded file |

---
Would you like me to give you a **ready-to-run mini Django app (with 3 files)** that does this upload-display cycle so you can test it right away?
