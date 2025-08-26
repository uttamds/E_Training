
# **C# Security and Authentication – Notes**

## **1. Introduction to Security in C#**

Security in C# applications ensures that data, resources, and operations are **protected from unauthorized access, misuse, and vulnerabilities**.
It typically involves three key areas:

* **Authentication** → Verifying user identity
* **Authorization** → Controlling what authenticated users can access
* **Data Protection** → Securing sensitive data (e.g., passwords, tokens)

---

## **2. Common Security Threats in C# Applications**

Before implementing security, it’s important to know the potential risks:

| **Threat**                            | **Description**                         | **Example**                        |
| ------------------------------------- | --------------------------------------- | ---------------------------------- |
| **SQL Injection**                     | Inserting malicious SQL queries         | `' OR 1=1 --`                      |
| **Cross-Site Scripting (XSS)**        | Injecting malicious scripts in UI       | `<script>alert('Hacked')</script>` |
| **Cross-Site Request Forgery (CSRF)** | Unauthorized actions on behalf of users | Clicking hidden links              |
| **Session Hijacking**                 | Stealing session tokens                 | Using stolen cookies               |
| **Brute Force Attacks**               | Trying multiple password combinations   | Automated login attempts           |

---

## **3. Authentication in C#**

Authentication verifies **who the user is** before granting access.

### **3.1 Types of Authentication**

#### **a) Windows Authentication**

* Uses **Windows user accounts** for login.
* Commonly used in **intranet applications**.
* Configuration in `appsettings.json` or `web.config`.

```json
{
  "Authentication": {
    "Schemes": {
      "Windows": {
        "Enabled": true
      }
    }
  }
}
```

#### **b) Forms Authentication**

* Custom login form + authentication ticket.
* Common in older **ASP.NET Web Forms** apps.

```csharp
FormsAuthentication.SetAuthCookie(username, false);
```

#### **c) Token-Based Authentication** *(Modern Approach)*

* Uses **JWT (JSON Web Tokens)**.
* Stateless, scalable, and secure.
* Widely used in **ASP.NET Core APIs**.

#### **d) OAuth 2.0 / OpenID Connect**

* Third-party authentication (e.g., Google, Facebook, Microsoft).
* Mostly used for **social logins** and **SSO (Single Sign-On)**.

---

## **4. Implementing Authentication in ASP.NET Core**

### **4.1 Cookie-Based Authentication**

Best suited for **web applications**.

**Startup Configuration:**

```csharp
services.AddAuthentication("CookieAuth")
    .AddCookie("CookieAuth", config =>
    {
        config.LoginPath = "/Account/Login";
    });
```

**Login Action:**

```csharp
var claims = new List<Claim>
{
    new Claim(ClaimTypes.Name, user.Username),
    new Claim(ClaimTypes.Role, user.Role)
};
var identity = new ClaimsIdentity(claims, "CookieAuth");
await HttpContext.SignInAsync(new ClaimsPrincipal(identity));
```

---

### **4.2 JWT Authentication (For APIs)**

Best for **REST APIs** and **mobile applications**.

**Install NuGet Package:**

```bash
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
```

**Configure JWT in `Program.cs`:**

```csharp
builder.Services.AddAuthentication("Bearer")
    .AddJwtBearer("Bearer", options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidIssuer = "https://myapp.com",
            ValidAudience = "https://myapp.com",
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes("YourSecretKeyHere"))
        };
    });
```

**Generate JWT Token:**

```csharp
var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("YourSecretKeyHere"));
var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

var token = new JwtSecurityToken(
    issuer: "https://myapp.com",
    audience: "https://myapp.com",
    claims: claims,
    expires: DateTime.Now.AddHours(1),
    signingCredentials: credentials);

return new JwtSecurityTokenHandler().WriteToken(token);
```

---

## **5. Authorization in C#**

Authorization controls **what authenticated users can do**.

### **5.1 Role-Based Authorization**

```csharp
[Authorize(Roles = "Admin")]
public IActionResult AdminDashboard()
{
    return View();
}
```

### **5.2 Policy-Based Authorization**

```csharp
services.AddAuthorization(options =>
{
    options.AddPolicy("RequireHR", policy => policy.RequireRole("HR"));
});
```

```csharp
[Authorize(Policy = "RequireHR")]
public IActionResult HRDashboard()
{
    return View();
}
```

---

## **6. Secure Password Handling**

Never store passwords in **plain text**.

* Use **Hashing + Salt**
* Recommended algorithm: **PBKDF2**, **BCrypt**, or **SHA-256**

```csharp
using var hmac = new HMACSHA256();
byte[] passwordHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(password));
```

For ASP.NET Core, use **PasswordHasher<T>**:

```csharp
var hasher = new PasswordHasher<IdentityUser>();
string hashedPassword = hasher.HashPassword(user, "MySecret123");
```

---

## **7. Best Practices for C# Security**

* ✅ Always **validate user input** to prevent SQL injection.
* ✅ Use **parameterized queries**.
* ✅ Enable **HTTPS**.
* ✅ Use **Data Protection API** for encryption.
* ✅ Store **secrets** in **Azure Key Vault** or **User Secrets**.
* ✅ Implement **rate limiting** to avoid brute-force attacks.
* ✅ Always **log authentication failures** for monitoring.

---

## **8. Summary**

| **Feature**         | **Description**            | **Best Use Case** |
| ------------------- | -------------------------- | ----------------- |
| **Windows Auth**    | Uses Windows accounts      | Intranet apps     |
| **Forms Auth**      | Login form with cookies    | Legacy apps       |
| **JWT Tokens**      | Stateless token-based auth | APIs, mobile apps |
| **OAuth 2.0**       | Third-party login          | Social login      |
| **Role-Based Auth** | Access control via roles   | Admin dashboards  |
| **Policy-Based**    | Custom authorization rules | Complex scenarios |

