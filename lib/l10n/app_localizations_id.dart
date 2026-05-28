// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'My Buku';

  @override
  String get digitalLibrary => 'Perpustakaan Digital';

  @override
  String get onboardingTitle1 => 'Selamat Datang di\nMy Buku';

  @override
  String get onboardingDesc1 =>
      'Temukan berbagai buku menarik di perpustakaan digital kamu.';

  @override
  String get onboardingTitle2 => 'Baca Kapan Saja,\nDi Mana Saja';

  @override
  String get onboardingDesc2 =>
      'Akses seluruh koleksi buku kapanpun dan dimanapun kamu berada.';

  @override
  String get onboardingTitle3 => 'Kelola Koleksi dan\nPinjamanmu';

  @override
  String get onboardingDesc3 =>
      'Pinjam, baca, dan kembalikan buku dengan mudah kapan saja.';

  @override
  String get skip => 'Lewati';

  @override
  String get next => 'Selanjutnya';

  @override
  String get start => 'Mulai';

  @override
  String get loginTitle => 'Masuk ke Akun';

  @override
  String get loginSubtitle => 'Selamat datang kembali!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Lupa Password?';

  @override
  String get login => 'Masuk';

  @override
  String get or => 'atau';

  @override
  String get noAccount => 'Belum punya akun? ';

  @override
  String get register => 'Daftar';

  @override
  String get emailPasswordEmpty => 'Email dan password tidak boleh kosong.';

  @override
  String get registerTitle => 'Buat Akun Baru';

  @override
  String get registerSubtitle => 'Daftarkan dirimu untuk mulai membaca';

  @override
  String get fullName => 'Nama Lengkap';

  @override
  String get confirmPassword => 'Konfirmasi Password';

  @override
  String get allFieldsRequired => 'Semua field harus diisi.';

  @override
  String get passwordMismatch => 'Password tidak cocok.';

  @override
  String get passwordMinLength => 'Password minimal 6 karakter.';

  @override
  String get haveAccount => 'Sudah punya akun? ';

  @override
  String get forgotPasswordTitle => 'Lupa Password';

  @override
  String get forgotPasswordDesc =>
      'Masukkan email kamu dan kami akan mengirimkan instruksi untuk mereset password.';

  @override
  String get enterEmail => 'Masukkan alamat email Anda.';

  @override
  String get emailSent => 'Email Terkirim!';

  @override
  String get checkInbox =>
      'Cek inbox email kamu untuk instruksi reset password.';

  @override
  String get backToLogin => 'Kembali ke Halaman Masuk';

  @override
  String get sendInstructions => 'Kirim Instruksi';

  @override
  String get userNotFound => 'Email tidak terdaftar.';

  @override
  String get invalidEmail => 'Format email tidak valid.';

  @override
  String get genericError => 'Terjadi kesalahan. Coba lagi.';

  @override
  String get welcome => 'Selamat Datang! 👋';

  @override
  String get searchHint => 'Cari buku, penulis, atau genre...';

  @override
  String get totalBooks => 'Total Buku';

  @override
  String get borrowed => 'Dipinjam';

  @override
  String get available => 'Tersedia';

  @override
  String get transactions => 'Transaksi';

  @override
  String get mainMenu => 'Menu Utama';

  @override
  String get searchBooks => 'Cari Buku';

  @override
  String get location => 'Lokasi';

  @override
  String get favorites => 'Favorit';

  @override
  String get popularGenres => 'Genre Populer';

  @override
  String get genreHistory => 'Sejarah';

  @override
  String get genreCulture => 'Budaya';

  @override
  String get genreLiterature => 'Sastra';

  @override
  String get genreCulinary => 'Kuliner';

  @override
  String get genreNature => 'Alam';

  @override
  String get genreTechnology => 'Teknologi';

  @override
  String get latestBooks => 'Buku Terbaru';

  @override
  String get viewAll => 'Lihat Semua';

  @override
  String get failedLoadBooks => 'Gagal memuat buku';

  @override
  String get noBooksYet => 'Belum ada buku';

  @override
  String removedFromFavorites(String title) {
    return '$title dihapus dari favorit';
  }

  @override
  String addedToFavorites(String title) {
    return '$title ditambahkan ke favorit ❤️';
  }

  @override
  String get home => 'Beranda';

  @override
  String get search => 'Cari';

  @override
  String get profile => 'Profil';

  @override
  String get bookDetail => 'Detail Buku';

  @override
  String get publisher => 'Penerbit';

  @override
  String get year => 'Tahun';

  @override
  String get pages => 'Halaman';

  @override
  String get stock => 'Stok';

  @override
  String get description => 'Deskripsi';

  @override
  String get bookInfo => 'Informasi Buku';

  @override
  String get author => 'Penulis';

  @override
  String get publishYear => 'Tahun Terbit';

  @override
  String get pageCount => 'Jumlah Halaman';

  @override
  String pagesUnit(int count) {
    return '$count halaman';
  }

  @override
  String get genre => 'Genre';

  @override
  String get shelfLocation => 'Lokasi Rak';

  @override
  String get borrowBook => 'Pinjam Buku';

  @override
  String get outOfStock => 'Stok Habis';

  @override
  String get confirmBorrow => 'Yakin ingin\nmeminjam buku ini?';

  @override
  String get borrowDueInfo => 'Batas pengembalian 7 hari dari sekarang';

  @override
  String get cancel => 'Batal';

  @override
  String get yesBorrow => 'Ya, Pinjam';

  @override
  String get borrowSuccess => '✅ Buku berhasil dipinjam!';

  @override
  String borrowFailed(String error) {
    return 'Gagal meminjam: $error';
  }

  @override
  String get favoriteBooks => 'Buku Favorit';

  @override
  String get noFavorites => 'Belum ada buku favorit';

  @override
  String get addFavoritesHint =>
      'Tap ikon ❤️ di halaman pencarian untuk menambahkan';

  @override
  String get bookSearch => 'Pencarian Buku';

  @override
  String get searchTitleAuthor => 'Cari judul atau penulis...';

  @override
  String get all => 'Semua';

  @override
  String get genreLanguage => 'Bahasa';

  @override
  String get genreEconomy => 'Ekonomi';

  @override
  String get failedLoadData => 'Gagal memuat data';

  @override
  String get bookNotFound => 'Buku tidak ditemukan';

  @override
  String get tryOtherKeyword => 'Coba genre atau kata kunci lain';

  @override
  String booksFound(int count) {
    return '$count buku ditemukan';
  }

  @override
  String get yourName => 'Nama Anda';

  @override
  String get myAccount => 'Akun Saya';

  @override
  String get borrowHistory => 'Riwayat Pinjaman';

  @override
  String get myFavorites => 'Favorit Saya';

  @override
  String get settings => 'Pengaturan';

  @override
  String get help => 'Bantuan';

  @override
  String get logout => 'Keluar';

  @override
  String get confirmation => 'Konfirmasi';

  @override
  String get logoutConfirm => 'Apakah Anda yakin ingin keluar dari akun ini?';

  @override
  String get appPreferences => 'Preferensi Aplikasi';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get notificationSubtitle => 'Pemberitahuan buku jatuh tempo';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get darkModeSubtitle => 'Ganti tema aplikasi';

  @override
  String get others => 'Lainnya';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get termsConditions => 'Syarat & Ketentuan';

  @override
  String get needMoreHelp => 'Butuh Bantuan Lebih Lanjut?';

  @override
  String get contactLibrarian =>
      'Hubungi pustakawan atau admin kami untuk kendala peminjaman.';

  @override
  String get contactAdmin => 'Hubungi Admin';

  @override
  String get faqTitle => 'Pertanyaan Sering Diajukan';

  @override
  String get faq1Question => 'Berapa lama batas waktu pinjaman?';

  @override
  String get faq1Answer =>
      'Batas waktu standar untuk meminjam buku adalah 7 hari. Anda dapat memperpanjangnya 1 kali melalui aplikasi.';

  @override
  String get faq2Question => 'Bagaimana jika terlambat mengembalikan?';

  @override
  String get faq2Answer =>
      'Keterlambatan pengembalian buku akan dikenakan denda harian sesuai dengan peraturan perpustakaan.';

  @override
  String get faq3Question => 'Apakah saya bisa meminjam lebih dari 3 buku?';

  @override
  String get faq3Answer =>
      'Saat ini, batas maksimal peminjaman adalah 3 buku secara bersamaan untuk anggota reguler.';

  @override
  String get editProfile => 'Ubah Profil';

  @override
  String get changePhotoHint => 'Ketuk ikon kamera untuk mengubah foto';

  @override
  String get photoSource => 'Pilih Sumber Foto';

  @override
  String get camera => 'Kamera';

  @override
  String get takeNewPhoto => 'Ambil foto baru';

  @override
  String get gallery => 'Galeri';

  @override
  String get pickFromGallery => 'Pilih dari galeri';

  @override
  String get nameRequired => 'Nama tidak boleh kosong';

  @override
  String get enterFullName => 'Masukkan nama lengkap Anda';

  @override
  String get emailCannotChange => 'Email tidak dapat diubah';

  @override
  String get phoneNumber => 'Nomor Telepon';

  @override
  String get phoneHint => 'Contoh: 08123456789';

  @override
  String get address => 'Alamat';

  @override
  String get enterAddress => 'Masukkan alamat Anda';

  @override
  String get saveChanges => 'Simpan Perubahan';

  @override
  String get profileUpdated => 'Profil berhasil diperbarui! 🎉';

  @override
  String profileUpdateFailed(String error) {
    return 'Gagal mengubah profil: $error';
  }

  @override
  String imagePickFailed(String error) {
    return 'Gagal mengambil gambar: $error';
  }

  @override
  String get transactionTitle => 'Transaksi';

  @override
  String get filterAll => 'Semua';

  @override
  String get filterBorrow => 'Pinjam';

  @override
  String get filterBuy => 'Beli';

  @override
  String get failedLoadTransactions => 'Gagal memuat transaksi';

  @override
  String get noTransactions => 'Belum ada transaksi';

  @override
  String get borrowLabel => 'PINJAM';

  @override
  String get buyLabel => 'BELI';

  @override
  String get dueDate => 'Batas Kembali:';

  @override
  String get returnBook => 'Kembalikan';

  @override
  String get returnSuccess => 'Buku berhasil dikembalikan';

  @override
  String failedAction(String error) {
    return 'Gagal: $error';
  }

  @override
  String get libraryLocation => 'Lokasi Perpustakaan';

  @override
  String get noLibraryData => 'Tidak ada data perpustakaan.';

  @override
  String get viewOnMap => 'Lihat di Peta';

  @override
  String get getDirections => 'Petunjuk Arah';

  @override
  String get privacyPolicyContent =>
      'Privasi Anda sangat penting bagi kami. Aplikasi ini mengumpulkan data profil pengguna minimal seperti nama, email, dan catatan pinjaman khusus untuk mengelola peminjaman perpustakaan dan preferensi aplikasi. Data Anda disimpan dengan aman dan tidak akan dibagikan kepada pihak ketiga tanpa izin eksplisit Anda.';

  @override
  String get termsConditionsContent =>
      'Dengan menggunakan My Buku, Anda setuju untuk mematuhi peraturan perpustakaan. Batas waktu standar peminjaman buku adalah 7 hari. Keterlambatan pengembalian akan dikenakan denda harian sesuai ketentuan. Pengguna wajib menjaga kondisi fisik buku yang dipinjam. Batas maksimal peminjaman adalah 3 buku secara bersamaan.';
}
