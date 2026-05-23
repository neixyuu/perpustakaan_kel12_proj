import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  // Private constructor that loads the theme immediately on launch
  ThemeService._privateConstructor() {
    _loadThemeFromPrefs();
  }
  static final ThemeService instance = ThemeService._privateConstructor();

  ThemeMode _themeMode = ThemeMode.light;

  // Getters required by main.dart and settings_screen.dart
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Expects 1 boolean argument to fix the settings_screen error
  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Updates UI immediately
    
    // Persist the choice to device storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIsDark = prefs.getBool('isDarkMode') ?? false;
    _themeMode = savedIsDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}