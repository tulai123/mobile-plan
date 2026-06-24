import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WarmupApp());
}

class WarmupApp extends StatelessWidget {
  const WarmupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warmup HTTP',
      home: Scaffold(
        appBar: AppBar(title: const Text('Warmup HTTP - Tuan 4')),
        body: const Center(child: LoadButton()),
      ),
    );
  }
}

class LoadButton extends StatelessWidget {
  const LoadButton({super.key});

  Future<void> _taiDuLieu() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    print('statusCode: ${response.statusCode}');
    final body = response.body;
    final preview = body.length > 300 ? body.substring(0, 300) : body;
    print('body (300 ky tu dau): $preview');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _taiDuLieu,
      child: const Text('Tai du lieu'),
    );
  }
}