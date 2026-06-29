import 'package:flutter/material.dart';
import 'package:test_final/models/note.dart';
import 'package:test_final/services/isar_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedSubject = "Mobile";

  String selectedPriority = "High";

  void saveNote() async {
    final note = Note()
      ..title = titleController.text
      ..description = descriptionController.text
      ..subject = selectedSubject
      ..priority = selectedPriority;

    await IsarService.addNote(note);

    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          // Old Flutter Code
          // RadioListTile<String>(
          //   title: const Text("Mobile"),
          //   value: "Mobile",
          //   groupValue: selectedSubject,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedSubject = value!;
          //     });
          //   },
          // ),

          // RadioListTile<String>(
          //   title: const Text("Frontend"),
          //   value: "Frontend",
          //   groupValue: selectedSubject,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedSubject = value!;
          //     });
          //   },
          // ),

          // RadioListTile<String>(
          //   title: const Text("Backend"),
          //   value: "Backend",
          //   groupValue: selectedSubject,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedSubject = value!;
          //     });
          //   },
          // ),

          // New Flutter Code
          RadioGroup<String>(
            groupValue: selectedSubject,
            onChanged: (value) {
              setState(() {
                selectedSubject = value!;
              });
            },
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text("Mobile"),
                  value: "Mobile",
                ),
                RadioListTile<String>(
                  title: const Text("Frontend"),
                  value: "Frontend",
                ),
                RadioListTile<String>(
                  title: const Text("Backend"),
                  value: "Backend",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          DropdownButton<String>(
            value: selectedPriority,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: "High", child: Text("High")),
              DropdownMenuItem(value: "Medium", child: Text("Medium")),
              DropdownMenuItem(value: "Low", child: Text("Low")),
            ],
            onChanged: (value) {
              setState(() {
                selectedPriority = value!;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveNote,
        child: const Icon(Icons.save),
      ),
    );
  }
}
