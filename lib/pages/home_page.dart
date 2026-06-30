import 'package:flutter/material.dart';
import 'package:test_final/models/note.dart';
import 'package:test_final/services/isar_service.dart';
import 'package:test_final/widgets/note_card.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  bool isLoading = true;

  Future<void> fetchNotes() async {
    final data = await IsarService.getNotes();

    setState(() {
      notes = data;
      isLoading = false;
    });
  }

  Future<void> navigateToAddNotePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddNotePage()),
    );

    if (result == true) {
      await fetchNotes();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes Manager')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notes.isEmpty
          ? const Center(child: Text("No Notes Yet"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return NoteCard(note: note);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddNotePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
