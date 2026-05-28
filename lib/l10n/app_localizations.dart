import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// Application name
  ///
  /// In id, this message translates to:
  /// **'My Buku'**
  String get appName;

  /// Digital library subtitle
  ///
  /// In id, this message translates to:
  /// **'Perpustakaan Digital'**
  String get digitalLibrary;

  /// Onboarding page 1 title
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang di\nMy Buku'**
  String get onboardingTitle1;

  /// Onboarding page 1 description
  ///
  /// In id, this message translates to:
  /// **'Temukan berbagai buku menarik di perpustakaan digital kamu.'**
  String get onboardingDesc1;

  /// Onboarding page 2 title
  ///
  /// In id, this message translates to:
  /// **'Baca Kapan Saja,\nDi Mana Saja'**
  String get onboardingTitle2;

  /// Onboarding page 2 description
  ///
  /// In id, this message translates to:
  /// **'Akses seluruh koleksi buku kapanpun dan dimanapun kamu berada.'**
  String get onboardingDesc2;

  /// Onboarding page 3 title
  ///
  /// In id, this message translates to:
  /// **'Kelola Koleksi dan\nPinjamanmu'**
  String get onboardingTitle3;

  /// Onboarding page 3 description
  ///
  /// In id, this message translates to:
  /// **'Pinjam, baca, dan kembalikan buku dengan mudah kapan saja.'**
  String get onboardingDesc3;

  /// Skip button
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get skip;

  /// Next button
  ///
  /// In id, this message translates to:
  /// **'Selanjutnya'**
  String get next;

  /// Start/Get started button
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get start;

  /// Login screen title
  ///
  /// In id, this message translates to:
  /// **'Masuk ke Akun'**
  String get loginTitle;

  /// Login screen subtitle
  ///
  /// In id, this message translates to:
  /// **'Selamat datang kembali!'**
  String get loginSubtitle;

  /// Email field hint
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field hint
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link
  ///
  /// In id, this message translates to:
  /// **'Lupa Password?'**
  String get forgotPassword;

  /// Login button
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get login;

  /// Or divider text
  ///
  /// In id, this message translates to:
  /// **'atau'**
  String get or;

  /// No account prompt
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun? '**
  String get noAccount;

  /// Register link/button
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get register;

  /// Error when email or password is empty
  ///
  /// In id, this message translates to:
  /// **'Email dan password tidak boleh kosong.'**
  String get emailPasswordEmpty;

  /// Register screen title
  ///
  /// In id, this message translates to:
  /// **'Buat Akun Baru'**
  String get registerTitle;

  /// Register screen subtitle
  ///
  /// In id, this message translates to:
  /// **'Daftarkan dirimu untuk mulai membaca'**
  String get registerSubtitle;

  /// Full name field hint
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get fullName;

  /// Confirm password field hint
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Password'**
  String get confirmPassword;

  /// Error when fields are empty
  ///
  /// In id, this message translates to:
  /// **'Semua field harus diisi.'**
  String get allFieldsRequired;

  /// Error when passwords don't match
  ///
  /// In id, this message translates to:
  /// **'Password tidak cocok.'**
  String get passwordMismatch;

  /// Error when password too short
  ///
  /// In id, this message translates to:
  /// **'Password minimal 6 karakter.'**
  String get passwordMinLength;

  /// Already have account prompt
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun? '**
  String get haveAccount;

  /// Forgot password screen title
  ///
  /// In id, this message translates to:
  /// **'Lupa Password'**
  String get forgotPasswordTitle;

  /// Forgot password description
  ///
  /// In id, this message translates to:
  /// **'Masukkan email kamu dan kami akan mengirimkan instruksi untuk mereset password.'**
  String get forgotPasswordDesc;

  /// Enter email error
  ///
  /// In id, this message translates to:
  /// **'Masukkan alamat email Anda.'**
  String get enterEmail;

  /// Email sent success title
  ///
  /// In id, this message translates to:
  /// **'Email Terkirim!'**
  String get emailSent;

  /// Check inbox instruction
  ///
  /// In id, this message translates to:
  /// **'Cek inbox email kamu untuk instruksi reset password.'**
  String get checkInbox;

  /// Back to login button
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Halaman Masuk'**
  String get backToLogin;

  /// Send reset instructions button
  ///
  /// In id, this message translates to:
  /// **'Kirim Instruksi'**
  String get sendInstructions;

  /// User not found error
  ///
  /// In id, this message translates to:
  /// **'Email tidak terdaftar.'**
  String get userNotFound;

  /// Invalid email error
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid.'**
  String get invalidEmail;

  /// Generic error message
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan. Coba lagi.'**
  String get genericError;

  /// Home screen welcome greeting
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang! 👋'**
  String get welcome;

  /// Home search bar hint
  ///
  /// In id, this message translates to:
  /// **'Cari buku, penulis, atau genre...'**
  String get searchHint;

  /// Total books stat label
  ///
  /// In id, this message translates to:
  /// **'Total Buku'**
  String get totalBooks;

  /// Borrowed stat label
  ///
  /// In id, this message translates to:
  /// **'Dipinjam'**
  String get borrowed;

  /// Available stat label
  ///
  /// In id, this message translates to:
  /// **'Tersedia'**
  String get available;

  /// Transactions stat/menu label
  ///
  /// In id, this message translates to:
  /// **'Transaksi'**
  String get transactions;

  /// Main menu section title
  ///
  /// In id, this message translates to:
  /// **'Menu Utama'**
  String get mainMenu;

  /// Search books menu item
  ///
  /// In id, this message translates to:
  /// **'Cari Buku'**
  String get searchBooks;

  /// Location menu item
  ///
  /// In id, this message translates to:
  /// **'Lokasi'**
  String get location;

  /// Favorites menu/tab label
  ///
  /// In id, this message translates to:
  /// **'Favorit'**
  String get favorites;

  /// Popular genres section title
  ///
  /// In id, this message translates to:
  /// **'Genre Populer'**
  String get popularGenres;

  /// History genre
  ///
  /// In id, this message translates to:
  /// **'Sejarah'**
  String get genreHistory;

  /// Culture genre
  ///
  /// In id, this message translates to:
  /// **'Budaya'**
  String get genreCulture;

  /// Literature genre
  ///
  /// In id, this message translates to:
  /// **'Sastra'**
  String get genreLiterature;

  /// Culinary genre
  ///
  /// In id, this message translates to:
  /// **'Kuliner'**
  String get genreCulinary;

  /// Nature genre
  ///
  /// In id, this message translates to:
  /// **'Alam'**
  String get genreNature;

  /// Technology genre
  ///
  /// In id, this message translates to:
  /// **'Teknologi'**
  String get genreTechnology;

  /// Latest books section title
  ///
  /// In id, this message translates to:
  /// **'Buku Terbaru'**
  String get latestBooks;

  /// View all link
  ///
  /// In id, this message translates to:
  /// **'Lihat Semua'**
  String get viewAll;

  /// Failed to load books error
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat buku'**
  String get failedLoadBooks;

  /// No books available message
  ///
  /// In id, this message translates to:
  /// **'Belum ada buku'**
  String get noBooksYet;

  /// Snackbar when book removed from favorites
  ///
  /// In id, this message translates to:
  /// **'{title} dihapus dari favorit'**
  String removedFromFavorites(String title);

  /// Snackbar when book added to favorites
  ///
  /// In id, this message translates to:
  /// **'{title} ditambahkan ke favorit ❤️'**
  String addedToFavorites(String title);

  /// Home tab label
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get home;

  /// Search tab label
  ///
  /// In id, this message translates to:
  /// **'Cari'**
  String get search;

  /// Profile tab label
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// Book detail screen title
  ///
  /// In id, this message translates to:
  /// **'Detail Buku'**
  String get bookDetail;

  /// Publisher label
  ///
  /// In id, this message translates to:
  /// **'Penerbit'**
  String get publisher;

  /// Year label
  ///
  /// In id, this message translates to:
  /// **'Tahun'**
  String get year;

  /// Pages label
  ///
  /// In id, this message translates to:
  /// **'Halaman'**
  String get pages;

  /// Stock label
  ///
  /// In id, this message translates to:
  /// **'Stok'**
  String get stock;

  /// Description section title
  ///
  /// In id, this message translates to:
  /// **'Deskripsi'**
  String get description;

  /// Book information section title
  ///
  /// In id, this message translates to:
  /// **'Informasi Buku'**
  String get bookInfo;

  /// Author label
  ///
  /// In id, this message translates to:
  /// **'Penulis'**
  String get author;

  /// Published year label
  ///
  /// In id, this message translates to:
  /// **'Tahun Terbit'**
  String get publishYear;

  /// Page count label
  ///
  /// In id, this message translates to:
  /// **'Jumlah Halaman'**
  String get pageCount;

  /// Page count with unit
  ///
  /// In id, this message translates to:
  /// **'{count} halaman'**
  String pagesUnit(int count);

  /// Genre label
  ///
  /// In id, this message translates to:
  /// **'Genre'**
  String get genre;

  /// Shelf location label
  ///
  /// In id, this message translates to:
  /// **'Lokasi Rak'**
  String get shelfLocation;

  /// Borrow book button
  ///
  /// In id, this message translates to:
  /// **'Pinjam Buku'**
  String get borrowBook;

  /// Out of stock label
  ///
  /// In id, this message translates to:
  /// **'Stok Habis'**
  String get outOfStock;

  /// Borrow confirmation dialog title
  ///
  /// In id, this message translates to:
  /// **'Yakin ingin\nmeminjam buku ini?'**
  String get confirmBorrow;

  /// Borrow due date info
  ///
  /// In id, this message translates to:
  /// **'Batas pengembalian 7 hari dari sekarang'**
  String get borrowDueInfo;

  /// Cancel button
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// Confirm borrow button
  ///
  /// In id, this message translates to:
  /// **'Ya, Pinjam'**
  String get yesBorrow;

  /// Borrow success snackbar
  ///
  /// In id, this message translates to:
  /// **'✅ Buku berhasil dipinjam!'**
  String get borrowSuccess;

  /// Borrow failed snackbar
  ///
  /// In id, this message translates to:
  /// **'Gagal meminjam: {error}'**
  String borrowFailed(String error);

  /// Favorites screen title
  ///
  /// In id, this message translates to:
  /// **'Buku Favorit'**
  String get favoriteBooks;

  /// No favorites empty state title
  ///
  /// In id, this message translates to:
  /// **'Belum ada buku favorit'**
  String get noFavorites;

  /// Hint to add favorites
  ///
  /// In id, this message translates to:
  /// **'Tap ikon ❤️ di halaman pencarian untuk menambahkan'**
  String get addFavoritesHint;

  /// Search screen title
  ///
  /// In id, this message translates to:
  /// **'Pencarian Buku'**
  String get bookSearch;

  /// Search field hint
  ///
  /// In id, this message translates to:
  /// **'Cari judul atau penulis...'**
  String get searchTitleAuthor;

  /// All filter option
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get all;

  /// Language genre
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get genreLanguage;

  /// Economy genre
  ///
  /// In id, this message translates to:
  /// **'Ekonomi'**
  String get genreEconomy;

  /// Failed to load data error
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data'**
  String get failedLoadData;

  /// Book not found message
  ///
  /// In id, this message translates to:
  /// **'Buku tidak ditemukan'**
  String get bookNotFound;

  /// Try other keyword suggestion
  ///
  /// In id, this message translates to:
  /// **'Coba genre atau kata kunci lain'**
  String get tryOtherKeyword;

  /// Number of books found
  ///
  /// In id, this message translates to:
  /// **'{count} buku ditemukan'**
  String booksFound(int count);

  /// Default display name placeholder
  ///
  /// In id, this message translates to:
  /// **'Nama Anda'**
  String get yourName;

  /// My account menu item
  ///
  /// In id, this message translates to:
  /// **'Akun Saya'**
  String get myAccount;

  /// Borrow history menu item
  ///
  /// In id, this message translates to:
  /// **'Riwayat Pinjaman'**
  String get borrowHistory;

  /// My favorites menu item
  ///
  /// In id, this message translates to:
  /// **'Favorit Saya'**
  String get myFavorites;

  /// Settings menu/screen title
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settings;

  /// Help menu/screen title
  ///
  /// In id, this message translates to:
  /// **'Bantuan'**
  String get help;

  /// Logout menu item
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logout;

  /// Confirmation dialog title
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirmation;

  /// Logout confirmation message
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin keluar dari akun ini?'**
  String get logoutConfirm;

  /// App preferences settings group
  ///
  /// In id, this message translates to:
  /// **'Preferensi Aplikasi'**
  String get appPreferences;

  /// Notifications setting title
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get notifications;

  /// Notifications setting subtitle
  ///
  /// In id, this message translates to:
  /// **'Pemberitahuan buku jatuh tempo'**
  String get notificationSubtitle;

  /// Dark mode setting title
  ///
  /// In id, this message translates to:
  /// **'Mode Gelap'**
  String get darkMode;

  /// Dark mode setting subtitle
  ///
  /// In id, this message translates to:
  /// **'Ganti tema aplikasi'**
  String get darkModeSubtitle;

  /// Others settings group
  ///
  /// In id, this message translates to:
  /// **'Lainnya'**
  String get others;

  /// Privacy policy menu item
  ///
  /// In id, this message translates to:
  /// **'Kebijakan Privasi'**
  String get privacyPolicy;

  /// Terms and conditions menu item
  ///
  /// In id, this message translates to:
  /// **'Syarat & Ketentuan'**
  String get termsConditions;

  /// Help screen header title
  ///
  /// In id, this message translates to:
  /// **'Butuh Bantuan Lebih Lanjut?'**
  String get needMoreHelp;

  /// Help screen header description
  ///
  /// In id, this message translates to:
  /// **'Hubungi pustakawan atau admin kami untuk kendala peminjaman.'**
  String get contactLibrarian;

  /// Contact admin button
  ///
  /// In id, this message translates to:
  /// **'Hubungi Admin'**
  String get contactAdmin;

  /// FAQ section title
  ///
  /// In id, this message translates to:
  /// **'Pertanyaan Sering Diajukan'**
  String get faqTitle;

  /// FAQ question 1
  ///
  /// In id, this message translates to:
  /// **'Berapa lama batas waktu pinjaman?'**
  String get faq1Question;

  /// FAQ answer 1
  ///
  /// In id, this message translates to:
  /// **'Batas waktu standar untuk meminjam buku adalah 7 hari. Anda dapat memperpanjangnya 1 kali melalui aplikasi.'**
  String get faq1Answer;

  /// FAQ question 2
  ///
  /// In id, this message translates to:
  /// **'Bagaimana jika terlambat mengembalikan?'**
  String get faq2Question;

  /// FAQ answer 2
  ///
  /// In id, this message translates to:
  /// **'Keterlambatan pengembalian buku akan dikenakan denda harian sesuai dengan peraturan perpustakaan.'**
  String get faq2Answer;

  /// FAQ question 3
  ///
  /// In id, this message translates to:
  /// **'Apakah saya bisa meminjam lebih dari 3 buku?'**
  String get faq3Question;

  /// FAQ answer 3
  ///
  /// In id, this message translates to:
  /// **'Saat ini, batas maksimal peminjaman adalah 3 buku secara bersamaan untuk anggota reguler.'**
  String get faq3Answer;

  /// Edit profile screen title
  ///
  /// In id, this message translates to:
  /// **'Ubah Profil'**
  String get editProfile;

  /// Change photo hint text
  ///
  /// In id, this message translates to:
  /// **'Ketuk ikon kamera untuk mengubah foto'**
  String get changePhotoHint;

  /// Photo source bottom sheet title
  ///
  /// In id, this message translates to:
  /// **'Pilih Sumber Foto'**
  String get photoSource;

  /// Camera option
  ///
  /// In id, this message translates to:
  /// **'Kamera'**
  String get camera;

  /// Camera subtitle
  ///
  /// In id, this message translates to:
  /// **'Ambil foto baru'**
  String get takeNewPhoto;

  /// Gallery option
  ///
  /// In id, this message translates to:
  /// **'Galeri'**
  String get gallery;

  /// Gallery subtitle
  ///
  /// In id, this message translates to:
  /// **'Pilih dari galeri'**
  String get pickFromGallery;

  /// Name validation error
  ///
  /// In id, this message translates to:
  /// **'Nama tidak boleh kosong'**
  String get nameRequired;

  /// Full name field hint
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama lengkap Anda'**
  String get enterFullName;

  /// Email field note
  ///
  /// In id, this message translates to:
  /// **'Email tidak dapat diubah'**
  String get emailCannotChange;

  /// Phone number field label
  ///
  /// In id, this message translates to:
  /// **'Nomor Telepon'**
  String get phoneNumber;

  /// Phone number field hint
  ///
  /// In id, this message translates to:
  /// **'Contoh: 08123456789'**
  String get phoneHint;

  /// Address field label
  ///
  /// In id, this message translates to:
  /// **'Alamat'**
  String get address;

  /// Address field hint
  ///
  /// In id, this message translates to:
  /// **'Masukkan alamat Anda'**
  String get enterAddress;

  /// Save changes button
  ///
  /// In id, this message translates to:
  /// **'Simpan Perubahan'**
  String get saveChanges;

  /// Profile updated success snackbar
  ///
  /// In id, this message translates to:
  /// **'Profil berhasil diperbarui! 🎉'**
  String get profileUpdated;

  /// Profile update failed snackbar
  ///
  /// In id, this message translates to:
  /// **'Gagal mengubah profil: {error}'**
  String profileUpdateFailed(String error);

  /// Image pick failed snackbar
  ///
  /// In id, this message translates to:
  /// **'Gagal mengambil gambar: {error}'**
  String imagePickFailed(String error);

  /// Transaction screen title
  ///
  /// In id, this message translates to:
  /// **'Transaksi'**
  String get transactionTitle;

  /// All filter
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get filterAll;

  /// Borrow filter
  ///
  /// In id, this message translates to:
  /// **'Pinjam'**
  String get filterBorrow;

  /// Buy filter
  ///
  /// In id, this message translates to:
  /// **'Beli'**
  String get filterBuy;

  /// Failed to load transactions error
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat transaksi'**
  String get failedLoadTransactions;

  /// No transactions empty state
  ///
  /// In id, this message translates to:
  /// **'Belum ada transaksi'**
  String get noTransactions;

  /// Borrow type label
  ///
  /// In id, this message translates to:
  /// **'PINJAM'**
  String get borrowLabel;

  /// Buy type label
  ///
  /// In id, this message translates to:
  /// **'BELI'**
  String get buyLabel;

  /// Due date label
  ///
  /// In id, this message translates to:
  /// **'Batas Kembali:'**
  String get dueDate;

  /// Return book button
  ///
  /// In id, this message translates to:
  /// **'Kembalikan'**
  String get returnBook;

  /// Return success snackbar
  ///
  /// In id, this message translates to:
  /// **'Buku berhasil dikembalikan'**
  String get returnSuccess;

  /// Generic failed action snackbar
  ///
  /// In id, this message translates to:
  /// **'Gagal: {error}'**
  String failedAction(String error);

  /// Library location screen title
  ///
  /// In id, this message translates to:
  /// **'Lokasi Perpustakaan'**
  String get libraryLocation;

  /// No library data message
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data perpustakaan.'**
  String get noLibraryData;

  /// View on map button
  ///
  /// In id, this message translates to:
  /// **'Lihat di Peta'**
  String get viewOnMap;

  /// Get directions button
  ///
  /// In id, this message translates to:
  /// **'Petunjuk Arah'**
  String get getDirections;

  /// Your privacy is important to us. This application collects minimal user profile data such as your name, email, and loan history strictly to manage library borrowings and personalized app preferences. Your data is stored securely and will never be shared with third parties without your explicit permission.
  ///
  /// In id, this message translates to:
  /// **'Privasi Anda sangat penting bagi kami. Aplikasi ini mengumpulkan data profil pengguna minimal seperti nama, email, dan catatan pinjaman khusus untuk mengelola peminjaman perpustakaan dan preferensi aplikasi. Data Anda disimpan dengan aman dan tidak akan dibagikan kepada pihak ketiga tanpa izin eksplisit Anda.'**
  String get privacyPolicyContent;

  /// y using My Buku, you agree to comply with library regulations. The standard book borrowing duration is 7 days. Late returns are subject to penalties and fines calculated daily. Users are expected to maintain the condition of borrowed materials. The account limit is capped at 3 simultaneous book loans.
  ///
  /// In id, this message translates to:
  /// **'Dengan menggunakan My Buku, Anda setuju untuk mematuhi peraturan perpustakaan. Batas waktu standar peminjaman buku adalah 7 hari. Keterlambatan pengembalian akan dikenakan denda harian sesuai ketentuan. Pengguna wajib menjaga kondisi fisik buku yang dipinjam. Batas maksimal peminjaman adalah 3 buku secara bersamaan.'**
  String get termsConditionsContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
