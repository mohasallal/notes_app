import 'package:flutter/material.dart';
import 'package:test_final/models/note.dart';
import 'package:test_final/services/isar_service.dart';
import 'package:test_final/widgets/app_drawer.dart';
import 'package:test_final/widgets/note_card.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  List<Note> filteredNotes = [];
  String selectedSubjectFilter = 'All';

  final searchConteoller = TextEditingController();

  bool isLoading = true;

  Future<void> fetchNotes() async {
    final data = await IsarService.getNotes();

    setState(() {
      notes = data;
      filteredNotes = data;
      isLoading = false;
    });
  }

  Future<void> toggleFavorite(Note note) async {
    note.isFav = !note.isFav;

    await IsarService.updateNote(note);

    await fetchNotes();
  }

  Future<void> deleteNote(Note note) async {
    await IsarService.deleteNote(note.id);

    await fetchNotes();
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

  void applyFilters() {
    final query = searchConteoller.text.toLowerCase();

    final result = notes.where((note) {
      final titleLower = note.title.toLowerCase();
      final subjectLower = note.subject.toLowerCase();

      final matchesSearch =
          titleLower.contains(query) || subjectLower.contains(query);

      final matchesFilter =
          selectedSubjectFilter == "All" ||
          note.subject == selectedSubjectFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    setState(() {
      filteredNotes = result;
    });
  }

  void searchNotes(String query) {
    applyFilters();
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: selectedSubjectFilter,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "All",
                        child: Text("All Subjects"),
                      ),
                      DropdownMenuItem(value: "Mobile", child: Text("Mobile")),
                      DropdownMenuItem(
                        value: "Frontend",
                        child: Text("Frontend"),
                      ),
                      DropdownMenuItem(
                        value: "Backend",
                        child: Text("Backend"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSubjectFilter = value!;
                        applyFilters();
                      });
                    },
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];

                      return NoteCard(
                        note: note,
                        onFavoritPressed: () async {
                          await toggleFavorite(note);
                        },
                        onDeletePressed: () async {
                          await deleteNote(note);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddNotePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
