import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dynamic List Demo",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DynamicListDemo(),
    );
  }
}

class DynamicListDemo extends StatefulWidget {
  const DynamicListDemo({super.key});

  @override
  State<DynamicListDemo> createState() => _DynamicListDemoState();
}

class _DynamicListDemoState extends State<DynamicListDemo> {
  final List<String> _items = ["Apple", "Banana", "Orange"];
  final TextEditingController _controller = TextEditingController();

  // Add a new item to the list
  void _addItem(String newItem) {
    setState(() {
      _items.add(newItem);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added: $newItem")),
    );
  }

  // Remove an item from the list
  void _removeItem(int index) {
    String removedItem = _items[index];
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Removed: $removedItem")),
    );
  }

  // Show a dialog to enter a new item
  void _showAddItemDialog() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Item"),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter item name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                _addItem(_controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic List Demo"),
        centerTitle: true,
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                "No items added yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        _items[index][0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(_items[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
