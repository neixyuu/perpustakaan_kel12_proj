import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/screens/login_screen.dart';
import 'package:perpustakaan/screens/main_screen.dart';
import 'package:perpustakaan/services/favorites_service.dart';

/// Widget pusat yang mengelola routing berdasarkan status auth Firebase.
/// Selalu berada di root Navigator agar auto-redirect login ↔ main bekerja.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Menunggu state awal
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User sudah login → MainScreen
        if (snapshot.hasData) {
          // Pastikan favorites service sudah diinisialisasi untuk user ini
          FavoritesService.instance.init();
          return const MainScreen();
        }

        // Belum login → LoginScreen
        return const LoginScreen();
      },
    );
  }
}
