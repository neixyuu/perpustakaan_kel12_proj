import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/screens/main_screen.dart';
import 'package:perpustakaan/firebase_options.dart';
<<<<<<< Updated upstream
import 'package:perpustakaan/screens/login_screen.dart';
import 'package:perpustakaan/screens/main_screen.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/firestore_service.dart';
=======
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:perpustakaan/services/theme_service.dart';
>>>>>>> Stashed changes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Seed buku ke Firestore (forceSeed untuk menerapkan field baru)
  await FirestoreService.instance.forceSeedBooks();

  // Inisialisasi stream favorit dari Firestore
  FavoritesService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< Updated upstream
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Palembang',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainScreen();
        }
        return const LoginScreen();
=======
  final bool onboardingDone;
  const MyApp({super.key, required this.onboardingDone});
      
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'My Buku - Perpustakaan Digital',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeService.instance.themeMode,
          
          // --- CONFIGURATION TEMA TERANG (LIGHT THEME) ---
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.teal,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            cardColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
              surface: Colors.white,
            ),
            // Style otomatis untuk seluruh ElevatedButton di Mode Terang
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),

          // --- CONFIGURATION TEMA GELAP (DARK THEME) ---
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.teal,
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF1E1E1E),
            colorScheme: const ColorScheme.dark(
              primary: Colors.teal,
              surface: Color(0xFF1E1E1E),
            ),
            // Style otomatis untuk seluruh ElevatedButton di Mode Gelap
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Tetap gunakan Teal atau sesuaikan ke warna dark accent
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
          
          home: const MainScreen(),
        );
>>>>>>> Stashed changes
      },
    );
  }
}
