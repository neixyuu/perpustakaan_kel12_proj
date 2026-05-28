import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/services/theme_service.dart';
import 'package:perpustakaan/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:perpustakaan/services/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//uralea
// indigo: intisari dingin lets go

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _updateNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    setState(() {
      _notificationsEnabled = value;
    });

    if (!value) {
      // If turned off, clear all currently queued notification reminders
      await FlutterLocalNotificationsPlugin().cancelAll();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, _) {
        final isDark = ThemeService.instance.isDarkMode;
        final primary = Theme.of(context).primaryColor;
        final localeProvider = Provider.of<LocaleProvider>(context);

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.settings,
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
              // Theme and Language prominent buttons
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      context,
                      title: AppLocalizations.of(context)!.darkMode,
                      icon: isDark ? Icons.dark_mode : Icons.light_mode,
                      value: isDark ? 'On' : 'Off',
                      color: isDark ? Colors.indigoAccent : Colors.orange,
                      onTap: () => ThemeService.instance.toggleTheme(!isDark),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickActionCard(
                      context,
                      title: 'Language',
                      icon: Icons.language,
                      value: localeProvider.locale.languageCode.toUpperCase(),
                      color: primary,
                      onTap: () {
                        final newCode = localeProvider.locale.languageCode == 'id' ? 'en' : 'id';
                        localeProvider.setLocale(Locale(newCode));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildSettingsGroup(context, "Preferences", [
                SwitchListTile(
                  title: Text(
                    "Notifications", 
                    style: GoogleFonts.inter(fontSize: 15),
                  ),
                  secondary: Icon(
                    _notificationsEnabled 
                        ? Icons.notifications_active 
                        : Icons.notifications_off,
                    color: _notificationsEnabled ? primary : Colors.grey,
                  ),
                  value: _notificationsEnabled,
                  activeColor: primary,
                  onChanged: (bool value) {
                    _updateNotificationSetting(value);
                  },
                ),
              ]),
              const SizedBox(height: 24),

              _buildSettingsGroup(context, AppLocalizations.of(context)!.others, [
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Theme.of(context).primaryColor,
                    collapsedIconColor: Colors.grey,
                    title: Text(
                      AppLocalizations.of(context)!.privacyPolicy, 
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.privacyPolicyContent,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Theme.of(context).primaryColor,
                    collapsedIconColor: Colors.grey,
                    title: Text(
                      AppLocalizations.of(context)!.termsConditions, 
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.termsConditionsContent,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 20),
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

  Widget _buildQuickActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
