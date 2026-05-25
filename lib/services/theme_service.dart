import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  // Private constructor yang memuat tema langsung saat aplikasi diluncurkan
  ThemeService._privateConstructor() {
    _loadThemeFromPrefs();
  }
  static final ThemeService instance = ThemeService._privateConstructor();

  ThemeMode _themeMode = ThemeMode.light;

  // Getter yang dibutuhkan oleh main.dart dan settings_screen.dart
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Menerima 1 argumen boolean untuk mengganti tema aplikasi
  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Memperbarui UI secara instan
    
    // Menyimpan pilihan ke penyimpanan perangkat
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