import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/screens/edit_profile_screen.dart';
import 'package:perpustakaan/services/auth_service.dart';
import 'package:perpustakaan/screens/settings_screen.dart';
import 'package:perpustakaan/screens/help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
<<<<<<< Updated upstream
      backgroundColor: Colors.white,
=======
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
=======
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
                        // child: Icon(Icons.camera_alt_outlined,
                        //     size: 16, color: primary),
                      ),
                    ],
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
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
