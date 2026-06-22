import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListScreen(),
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Flutter",
      "Dart",
      "Java",
      "C#",
      "Python",
      "JavaScript",
      "PHP",
      "C++",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView.builder Demo"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(items[index]),
            subtitle: Text("Phần tử thứ ${index + 1}"),
          );
        },
      ),
    );
  }
}