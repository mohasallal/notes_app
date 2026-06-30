import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteDetailsPage extends StatelessWidget {
  final Note note;

  const NoteDetailsPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text(
                  "Subject: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(note.subject),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Priority: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(note.priority),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(note.description),
            ),
          ],
        ),
      ),
    );
  }
}