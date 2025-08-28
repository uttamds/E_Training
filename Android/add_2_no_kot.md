
---

## **Steps to Create the Project**

### **Step 1 — Create a New Project**

1. Open **Android Studio** → **New Project** → **Empty Activity**.
2. Name it → `AddTwoNumbersDemo`.
3. Language → **Kotlin** (or Java if you prefer).
4. Minimum SDK → **API 24 (Android 7.0)** or above.
5. Click **Finish**.

---

### **Step 2 — Design the Layout**

Open **`res/layout/activity_main.xml`** and replace the code with this:

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:padding="16dp"
    android:gravity="center_horizontal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <EditText
        android:id="@+id/etNum1"
        android:hint="Enter first number"
        android:inputType="number"
        android:layout_width="match_parent"
        android:layout_height="wrap_content" />

    <EditText
        android:id="@+id/etNum2"
        android:hint="Enter second number"
        android:inputType="number"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp" />

    <Button
        android:id="@+id/btnAdd"
        android:text="Add Numbers"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp" />

    <TextView
        android:id="@+id/tvResult"
        android:text="Result will appear here"
        android:textSize="18sp"
        android:textStyle="bold"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:gravity="center"
        android:layout_marginTop="16dp" />

</LinearLayout>
```

---

### **Step 3 — Kotlin Code for Adding Two Numbers**

Open **`MainActivity.kt`** and replace the code with:

```kotlin
package com.example.addtwonumbersdemo

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val etNum1 = findViewById<EditText>(R.id.etNum1)
        val etNum2 = findViewById<EditText>(R.id.etNum2)
        val btnAdd = findViewById<Button>(R.id.btnAdd)
        val tvResult = findViewById<TextView>(R.id.tvResult)

        btnAdd.setOnClickListener {
            val num1 = etNum1.text.toString().toIntOrNull() ?: 0
            val num2 = etNum2.text.toString().toIntOrNull() ?: 0
            val sum = num1 + num2
            tvResult.text = "Sum = $sum"
        }
    }
}
```

---

### **Step 4 — Run the App**

1. Click **Run** ▶.
2. Choose an **emulator** or **physical device**.
3. Enter two numbers → click **Add Numbers** → see the **result**.

---

### **How It Works**

* **EditText** → User enters numbers.
* **Button** → Triggers calculation.
* **TextView** → Displays the result.
* We use `toIntOrNull()` → avoids crashes if the user leaves fields empty.

---
