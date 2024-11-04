import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/viewmodels/note_viewmodel.dart';
import '../presentation/screens/notes_screen.dart';

void main() {
  runApp(const MySimpleNoteApp());
}

class MySimpleNoteApp extends StatelessWidget {
  const MySimpleNoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteViewModel(),
      child: MaterialApp(
        title: 'MySimpleNote',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.light,
          useMaterial3: true,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const NotesScreen(),
      ),
    );
  }
}
