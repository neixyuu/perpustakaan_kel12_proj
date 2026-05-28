import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/l10n/app_localizations.dart';
import 'package:perpustakaan/services/theme_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The ListenableBuilder makes sure the screen updates if theme changes
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, _) {
        // Variables defined here so the whole screen can use them
        final isDark = ThemeService.instance.isDarkMode;
        final primary = Theme.of(context).primaryColor;
        final l10n = AppLocalizations.of(context)!;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              l10n.help,
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: isDark ? Colors.white : Colors.black87,
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Contact Support
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.support_agent_rounded, size: 48, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      l10n.needMoreHelp,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () async {
                        final Uri whatsappUrl = Uri.parse('whatsapp://send?phone=62831965749310&text=Hidup_Jokowi');
                        
                        try {
                          if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
                            throw Exception('Could not launch URL');
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isDark 
                                      ? 'Gagal membuka WhatsApp' 
                                      : 'Gagal membuka WhatsApp. Pastikan aplikasi terinstal.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        l10n.contactAdmin,
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // FAQ Section
              _buildFAQItem(l10n.faq1Question, l10n.faq1Answer, context, isDark),
              _buildFAQItem(l10n.faq2Question, l10n.faq2Answer, context, isDark),
              _buildFAQItem(l10n.faq3Question, l10n.faq3Answer, context, isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFAQItem(String question, String answer, BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Theme.of(context).primaryColor,
          title: Text(
            question,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  answer,
                  style: GoogleFonts.inter(
                    fontSize: 13, 
                    color: isDark 
                        ? Colors.grey.shade400 
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}