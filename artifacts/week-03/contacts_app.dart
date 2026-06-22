import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  final String name;
  final String phone;
  final String email;

  Contact({
    required this.name,
    required this.phone,
    required this.email,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  ContactListScreen({super.key});

  final List<Contact> contacts = [
    Contact(
      name: 'Nguyen Van A',
      phone: '0901234567',
      email: 'a@gmail.com',
    ),
    Contact(
      name: 'Tran Thi B',
      phone: '0912345678',
      email: 'b@gmail.com',
    ),
    Contact(
      name: 'Le Van C',
      phone: '0923456789',
      email: 'c@gmail.com',
    ),
    Contact(
      name: 'Pham Thi D',
      phone: '0934567890',
      email: 'd@gmail.com',
    ),
    Contact(
      name: 'Hoang Van E',
      phone: '0945678901',
      email: 'e@gmail.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách liên hệ'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(contact.name[0]),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ContactDetailScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết liên hệ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tên: ${contact.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'SĐT: ${contact.phone}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${contact.email}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}