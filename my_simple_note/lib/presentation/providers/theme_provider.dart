import 'package:flutter/material.dart';
import '../../data/preferences/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    themePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
