import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/screens/auth_gate.dart';
import 'package:perpustakaan/screens/edit_profile_screen.dart';
import 'package:perpustakaan/screens/favorites_screen.dart';
import 'package:perpustakaan/screens/transaction_screen.dart';
import 'package:perpustakaan/services/auth_service.dart';
import 'package:perpustakaan/screens/settings_screen.dart';
import 'package:perpustakaan/screens/help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Profile
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: user?.photoURL != null
                              ? Image.network(user!.photoURL!,
                                  fit: BoxFit.cover)
                              : Icon(Icons.person, size: 52, color: primary),
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt_outlined,
                            size: 16, color: primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user?.displayName ?? 'Nama Anda',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'member@email.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Menu list
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  _buildMenuCard(context, [
                    _MenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Akun Saya',
                      color: primary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfileScreen()),
                      ),
                    ),
                    _MenuItem(
                      icon: Icons.receipt_long_outlined,
                      title: 'Riwayat Pinjaman',
                      color: Colors.orange,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TransactionScreen()),
                      ),
                    ),
                    _MenuItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'Favorit Saya',
                      color: Colors.pink,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoritesScreen()),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  _buildMenuCard(context, [
                    _MenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Pengaturan',
                      color: Colors.teal,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsScreen()),
                      ),
                    ),
                    _MenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Bantuan',
                      color: Colors.purple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HelpScreen()),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  _buildMenuCard(context, [
                    _MenuItem(
                      icon: Icons.logout_rounded,
                      title: 'Keluar',
                      color: Colors.red,
                      isLogout: true,
                      onTap: () => _confirmLogout(context),
                    ),
                  ]),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: item.color, size: 22),
                ),
                title: Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight:
                        item.isLogout ? FontWeight.bold : FontWeight.w500,
                    color: item.isLogout
                      ? Colors.red 
                      : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87
                    ),
                  ),
                ),
                trailing: item.isLogout
                    ? null
                    : const Icon(Icons.chevron_right_rounded,
                        color: Colors.grey, size: 22),
                onTap: item.onTap,
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  indent: 72,
                  color: Colors.grey.shade100,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    // Simpan navigator reference sebelum dialog dibuka
    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout_rounded,
                  color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('Konfirmasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun ini?',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal',
                style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              Navigator.pop(ctx); // tutup dialog
              await AuthService().signOut();
              // Navigasi eksplisit ke AuthGate → otomatis tampil LoginScreen
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthGate()),
                (route) => false,
              );
            },
            child: const Text('Keluar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Color color;
  final bool isLogout;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.color,
    this.isLogout = false,
    this.onTap,
  });
}