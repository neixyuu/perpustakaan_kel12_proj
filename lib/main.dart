import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:perpustakaan/config/theme.dart';
import 'package:perpustakaan/firebase_options.dart';
import 'package:perpustakaan/screens/auth_gate.dart';
import 'package:perpustakaan/screens/onboarding_screen.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/notification_service.dart';
import 'package:perpustakaan/services/theme_service.dart';
import 'package:perpustakaan/services/locale_provider.dart';
import 'package:perpustakaan/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: MyApp(onboardingDone: onboardingDone),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingDone;
  const MyApp({super.key, required this.onboardingDone});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, _) {
        final localeProvider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          title: 'My Buku - Perpustakaan Digital',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeService.instance.themeMode,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: onboardingDone ? const AuthGate() : const OnboardingScreen(),
        );
      },
    );
  }
}
