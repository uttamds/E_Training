Alright 🙂 — I’ll give you a **sample lab** using **C#** with **ASP.NET Core 8** in **VS Code** to demonstrate **form handling** and **validation**.
We'll keep it **beginner-friendly**, **minimal**, and **step-by-step** so students can follow along.

---

## **Lab Title**: Handling Forms and Validating User Input in ASP.NET Core 8 (MVC)

### **Objective**

Students will:

* Create a simple ASP.NET Core 8 MVC project in VS Code.
* Build a **form** to collect user data.
* Implement **server-side validation** using **Data Annotations**.
* Display **validation error messages** in the UI.

---

## **Step 1 — Create a New ASP.NET Core 8 MVC Project**

Open **VS Code** → Open **Terminal** → Run:

```bash
dotnet new mvc -n FormValidationDemo
cd FormValidationDemo
code .
```

---

## **Step 2 — Project Structure**

After creation, you’ll see:

```
FormValidationDemo/
│── Controllers/
│── Models/
│── Views/
│── wwwroot/
│── Program.cs
│── appsettings.json
```

---

## **Step 3 — Create the Model (with Validation)**

Create a file: `Models/User.cs`

```csharp
using System.ComponentModel.DataAnnotations;

namespace FormValidationDemo.Models
{
    public class User
    {
        [Required(ErrorMessage = "Name is required")]
        [StringLength(30, ErrorMessage = "Name cannot exceed 30 characters")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Enter a valid email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Age is required")]
        [Range(18, 60, ErrorMessage = "Age must be between 18 and 60")]
        public int Age { get; set; }
    }
}
```

---

## **Step 4 — Create the Controller**

Create `Controllers/UserController.cs`

```csharp
using Microsoft.AspNetCore.Mvc;
using FormValidationDemo.Models;

namespace FormValidationDemo.Controllers
{
    public class UserController : Controller
    {
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(User user)
        {
            if (ModelState.IsValid)
            {
                ViewBag.Message = $"Registration Successful! Welcome {user.Name}";
                return View("Success", user);
            }
            return View(user);
        }
    }
}
```

---

## **Step 5 — Create the View**

Create a folder: `Views/User/`
Inside it, create `Register.cshtml`:

```html
@model FormValidationDemo.Models.User

@{
    ViewData["Title"] = "User Registration";
}

<h2>User Registration Form</h2>

<form asp-action="Register" method="post">
    <div>
        <label>Name:</label>
        <input asp-for="Name" />
        <span style="color:red" asp-validation-for="Name"></span>
    </div>

    <div>
        <label>Email:</label>
        <input asp-for="Email" />
        <span style="color:red" asp-validation-for="Email"></span>
    </div>

    <div>
        <label>Age:</label>
        <input asp-for="Age" />
        <span style="color:red" asp-validation-for="Age"></span>
    </div>

    <button type="submit">Register</button>
</form>

@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```

---

## **Step 6 — Create Success Page**

Create `Views/User/Success.cshtml`:

```html
@model FormValidationDemo.Models.User

<h2>Registration Successful!</h2>
<p><strong>Name:</strong> @Model.Name</p>
<p><strong>Email:</strong> @Model.Email</p>
<p><strong>Age:</strong> @Model.Age</p>
```

---

## **Step 7 — Enable Client-Side Validation**

In `Views/Shared/_Layout.cshtml`, ensure you have these scripts at the bottom:

```html
<script src="~/lib/jquery/dist/jquery.min.js"></script>
<script src="~/lib/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="~/lib/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js"></script>
```

---

## **Step 8 — Update `Program.cs`**

Make sure MVC routing is enabled:

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}

app.UseStaticFiles();
app.UseRouting();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=User}/{action=Register}/{id?}");

app.Run();
```

---

## **Step 9 — Run the Project**

```bash
dotnet run
```

Open in browser:
**[http://localhost:5000/User/Register](http://localhost:5000/User/Register)**

---

## **Step 10 — Test Cases**

| **Input**     | **Expected Output**              |
| ------------- | -------------------------------- |
| Empty fields  | Validation errors for all fields |
| Invalid email | "Enter a valid email" error      |
| Age < 18      | "Age must be between 18 and 60"  |
| Correct data  | Redirect to **Success Page**     |

---

## **What Students Learn**

✅ Creating ASP.NET Core 8 MVC project in VS Code
✅ Handling **form submissions**
✅ Applying **Data Annotations** for validation
✅ Displaying **error messages dynamically**
✅ Client + server-side validation working together

