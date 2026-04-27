import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/config/theme.dart';
import 'package:perpustakaan/firebase_options.dart';
import 'package:perpustakaan/screens/login_screen.dart';
import 'package:perpustakaan/screens/main_screen.dart';
import 'package:perpustakaan/screens/onboarding_screen.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Seed buku ke Firestore (forceSeed untuk menerapkan field baru)
  await FirestoreService.instance.forceSeedBooks();

  // Inisialisasi stream favorit dari Firestore
  FavoritesService.instance.init();

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
      home: onboardingDone ? const AuthGate() : const OnboardingScreen(),
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
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return const MainScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
