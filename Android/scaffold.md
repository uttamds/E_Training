 **Flutter demo** that showcases **most of the important aspects of the `Scaffold` widget** in a single example.

I’ll create a **comprehensive but beginner-friendly Flutter app** using **Dart** that demonstrates:

### **Features to Cover**

* `appBar` → Title, actions, leading icon
* `body` → Using `Center`, `Column`, `ListView`
* `floatingActionButton`
* `floatingActionButtonLocation`
* `drawer` + `endDrawer`
* `bottomNavigationBar`
* `bottomSheet`
* `backgroundColor`
* `SnackBar` (using `ScaffoldMessenger`)
* `PersistentFooterButtons`

---

## **Complete Flutter Code**

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Scaffold Demo",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const ScaffoldDemo(),
    );
  }
}

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key});

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  int _selectedIndex = 0;

  // Bottom navigation items
  final List<Widget> _pages = [
    const Center(child: Text("🏠 Home Page", style: TextStyle(fontSize: 24))),
    const Center(child: Text("🔍 Search Page", style: TextStyle(fontSize: 24))),
    const Center(child: Text("⚙️ Settings Page", style: TextStyle(fontSize: 24))),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("This is a SnackBar! 🎉"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // AppBar with title, actions, and leading icon
      appBar: AppBar(
        title: const Text("Flutter Scaffold Demo"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showSnackBar(context),
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showSnackBar(context),
          ),
        ],
      ),

      // Drawer on the left
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                "Navigation Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text("Home")),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ListTile(leading: Icon(Icons.info), title: Text("About")),
          ],
        ),
      ),

      // End Drawer on the right
      endDrawer: Drawer(
        child: Center(
          child: Text("End Drawer Content", style: TextStyle(fontSize: 18)),
        ),
      ),

      // Body with ListView and Column
      body: _pages[_selectedIndex],

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSnackBar(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),

      // Bottom Sheet
      bottomSheet: Container(
        color: Colors.deepPurple[50],
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: const Text(
          "This is a persistent Bottom Sheet",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.deepPurple),
        ),
      ),

      // Persistent Footer Buttons
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: const Text("OK"),
        ),
        ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
```

---

## **What This Code Demonstrates**

| Scaffold Feature                 | Where to See It                  |
| -------------------------------- | -------------------------------- |
| **AppBar**                       | Top title bar with menu & icons  |
| **Drawer**                       | Left-side navigation menu        |
| **EndDrawer**                    | Right-side drawer                |
| **Body**                         | Displays different pages         |
| **FloatingActionButton**         | Circular button at bottom        |
| **FloatingActionButtonLocation** | Positioned at center bottom      |
| **BottomNavigationBar**          | Navigation tabs                  |
| **BottomSheet**                  | Persistent info bar              |
| **PersistentFooterButtons**      | Buttons always visible at bottom |
| **SnackBar**                     | Temporary message popup          |
| **BackgroundColor**              | Light gray page background       |

