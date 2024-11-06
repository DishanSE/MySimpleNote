import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/viewmodels/note_viewmodel.dart';
import '../presentation/screens/notes_screen.dart';
import '../presentation/providers/theme_provider.dart';
import '../config/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.themePreferences.getTheme().then((value) {
    themeProvider.darkTheme = value;
  });

  runApp(MySimpleNoteApp(themeProvider: themeProvider));
}

class MySimpleNoteApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MySimpleNoteApp({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteViewModel()),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MySimpleNote',
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode:
                themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
            home: const NotesScreen(),
          );
        },
      ),
    );
  }
}
