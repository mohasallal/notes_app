import 'package:flutter/material.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes Manager')),
      body: const Center(child: Text('No Notes Yet!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final result = Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );

          if (result == true) {
            setState(() {
              // refreshing the page to show added notes
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
