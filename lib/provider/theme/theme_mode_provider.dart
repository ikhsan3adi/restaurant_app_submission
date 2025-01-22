import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode != ThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
