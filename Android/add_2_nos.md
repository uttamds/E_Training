This will be a **basic app** that takes **two numbers** from the user, **adds them**, and **displays the result**.

---

## **Steps to Create the Project**

### **Step 1 — Create a New Project**

1. Open **Android Studio** → **New Project** → **Empty Activity**.
2. Name it → `AddTwoNumbersDemoJava`.
3. Language → **Java**.
4. Minimum SDK → **API 24 (Android 7.0)** or above.
5. Click **Finish**.

---

### **Step 2 — Design the Layout**

Open **`res/layout/activity_main.xml`** and replace the code with:

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
        android:gravity="center"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp" />

</LinearLayout>
```

---

### **Step 3 — Java Code for Adding Two Numbers**

Open **`MainActivity.java`** and replace the code with:

```java
package com.example.addtwonumbersdemojava;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    EditText etNum1, etNum2;
    Button btnAdd;
    TextView tvResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etNum1 = findViewById(R.id.etNum1);
        etNum2 = findViewById(R.id.etNum2);
        btnAdd = findViewById(R.id.btnAdd);
        tvResult = findViewById(R.id.tvResult);

        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String num1Str = etNum1.getText().toString();
                String num2Str = etNum2.getText().toString();

                if (!num1Str.isEmpty() && !num2Str.isEmpty()) {
                    int num1 = Integer.parseInt(num1Str);
                    int num2 = Integer.parseInt(num2Str);
                    int sum = num1 + num2;
                    tvResult.setText("Sum = " + sum);
                } else {
                    tvResult.setText("Please enter both numbers!");
                }
            }
        });
    }
}
```

---

### **Step 4 — Run the App**

1. Click **Run** ▶.
2. Choose an **emulator** or **real device**.
3. Enter two numbers → Click **Add Numbers** → **Result** appears.

---

### **How It Works**

* **EditText** → User inputs numbers.
* **Button** → Click triggers calculation.
* **TextView** → Displays result.
* We handle empty inputs with a simple check.

---

