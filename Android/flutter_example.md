Got it 🙂 You want a **minimal Flutter code demo** using **Android Studio** — something very simple to show students or beginners how Flutter works. I’ll give you a **step-by-step guide** plus a **basic app code** that displays a button and updates text when clicked.

---

## **Step 1: Create a New Flutter Project**

1. Open **Android Studio**.
2. Go to **File → New → New Flutter Project**.
3. Select **Flutter Application** → Click **Next**.
4. Give your project a name, e.g., `flutter_demo`.
5. Set the Flutter SDK path → Click **Finish**.
6. Wait for the project to load.

---

## **Step 2: Minimal Code Example**

### **File:** `lib/main.dart`

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "Hello Flutter!";

  void changeMessage() {
    setState(() {
      message = "You clicked the button!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo App"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeMessage,
              child: const Text("Click Me"),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## **Step 3: Run the App**

* Connect an **Android Emulator** or a **real device**.
* Click **Run ▶** in Android Studio.
* You’ll see:

  * A **"Hello Flutter!"** text.
  * A **"Click Me"** button.
  * On clicking, the text changes instantly.

---

## **Step 4: Key Concepts Demoed**

* **MaterialApp** → Base structure for Flutter app.
* **Scaffold** → Provides app layout (AppBar, body, etc.).
* **StatefulWidget** → For handling UI changes dynamically.
* **setState()** → Rebuilds UI when data changes.

---
