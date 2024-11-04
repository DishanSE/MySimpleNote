import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_simple_note/presentation/viewmodels/note_viewmodel.dart';
import '../widgets/note_card.dart';
import 'edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NoteViewModel>().loadNotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MySimpleNote',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<NoteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_add, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.notes.length,
            itemBuilder: (context, index) {
              final note = viewModel.notes[index];
              return NoteCard(
                note: note,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditNoteScreen(note: note),
                  ),
                ),
                onDelete: () async {
                  await viewModel.deleteNote(note.id!);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note deleted')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
