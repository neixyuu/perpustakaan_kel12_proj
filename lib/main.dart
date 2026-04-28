import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/config/theme.dart';
import 'package:perpustakaan/firebase_options.dart';
import 'package:perpustakaan/screens/auth_gate.dart';
import 'package:perpustakaan/screens/onboarding_screen.dart';
import 'package:perpustakaan/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Seed buku ke Firestore (menerapkan semua field terbaru)
  await FirestoreService.instance.forceSeedBooks();

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
    return MaterialApp(
      title: 'My Buku - Perpustakaan Digital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Jika onboarding belum selesai → OnboardingScreen
      // Jika sudah → AuthGate (auto-redirect login ↔ main)
      home: onboardingDone ? const AuthGate() : const OnboardingScreen(),
    );
  }
}
