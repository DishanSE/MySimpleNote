import 'package:flutter/foundation.dart';
import '../../data/datasource/note_database.dart';
import '../../data/models/note.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteDatabase _db = NoteDatabase.instance;
  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();
    _notes = await _db.getAllNotes();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final note = Note(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
    );
    await _db.createNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _db.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _db.deleteNote(id);
    await loadNotes();
  }
}
