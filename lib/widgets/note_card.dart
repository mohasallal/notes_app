import 'package:flutter/material.dart';
import 'package:test_final/pages/note_detail_page.dart';

import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  final VoidCallback onFavoritPressed;

  final VoidCallback onDeletePressed;

  const NoteCard({
    super.key,
    required this.note,
    required this.onFavoritPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteDetailsPage(note: note)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.note, size: 40),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(note.subject),

                  Text(note.priority),
                ],
              ),
            ),

            IconButton(
              onPressed: onFavoritPressed,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  note.isFav ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(note.isFav),
                  color: note.isFav ? Colors.red : null,
                ),
              ),
            ),

            IconButton(onPressed: onDeletePressed, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
