import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/screens/main_screen.dart';
import 'package:perpustakaan/firebase_options.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:perpustakaan/services/theme_service.dart';
import 'package:image_picker/image_picker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inisialisasi favorit untuk user yang sudah login
  FavoritesService.instance.init();
  // Inisialisasi service notifikasi lokal
  await NotificationService.instance.init();

  // Cek apakah onboarding sudah pernah dilihat
  final prefs = await SharedPreferences.getInstance();
  final onboardingDone = prefs.getBool('onboarding_done') ?? false;

  runApp(MyApp(onboardingDone: onboardingDone));
}

class MyApp extends StatelessWidget {
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
      },
    );
  }
}
