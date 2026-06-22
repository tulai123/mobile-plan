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
        title: const Text("Danh sách"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.star),
            title: Text(items[index]),
            subtitle: Text("Phần tử số ${index + 1}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    item: items[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết"),
      ),
      body: Center(
        child: Text(
          "Bạn đã chọn: $item",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}