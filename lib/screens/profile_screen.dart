import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/screens/edit_profile_screen.dart';
import 'package:perpustakaan/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Profile
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? 'Pengguna',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? '-',
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menus
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildMenu(
                    context,
                    'Edit Profil',
                    Icons.edit_outlined,
                    Colors.black87,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenu(
                    context,
                    'Pengaturan',
                    Icons.settings_outlined,
                    Colors.black87,
                  ),
                  _buildMenu(
                    context,
                    'Tentang Aplikasi',
                    Icons.info_outline,
                    Colors.black87,
                  ),
                  _buildMenu(
                    context,
                    'Bantuan',
                    Icons.help_outline,
                    Colors.black87,
                  ),
                  const SizedBox(height: 24),
                  _buildMenu(
                    context,
                    'Logout',
                    Icons.logout,
                    Colors.red,
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(
    BuildContext context,
    String title,
    IconData icon,
    Color color, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: isLogout ? FontWeight.bold : FontWeight.w500,
          color: color,
        ),
      ),
      onTap:
          onTap ??
          () {
            if (isLogout) {
              _confirmLogout(context);
            }
          },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthService().signOut();
              // AuthGate di main.dart otomatis redirect ke LoginScreen
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
