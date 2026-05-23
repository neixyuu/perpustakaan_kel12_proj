import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/services/theme_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, _) {
        final isDark = ThemeService.instance.isDarkMode;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Pengaturan',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: isDark ? Colors.white : Colors.black87,
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSettingsGroup(context, 'Preferensi Aplikasi', [
                SwitchListTile(
                  title: Text('Notifikasi', style: GoogleFonts.inter(fontSize: 15)),
                  subtitle: Text('Pemberitahuan buku jatuh tempo',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                  value: _notificationsEnabled,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
                const Divider(height: 1),
                
                SwitchListTile(
                  title: Text('Mode Gelap', style: GoogleFonts.inter(fontSize: 15)),
                  subtitle: Text('Ganti tema aplikasi',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                  value: ThemeService.instance.isDarkMode,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    ThemeService.instance.toggleTheme(val); 
                  },
                ),
              ]),
              const SizedBox(height: 20),
              _buildSettingsGroup(context, 'Lainnya', [
                ListTile(
                  title: Text('Kebijakan Privasi', style: GoogleFonts.inter(fontSize: 15)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text('Syarat & Ketentuan', style: GoogleFonts.inter(fontSize: 15)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {},
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(ThemeService.instance.isDarkMode ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}