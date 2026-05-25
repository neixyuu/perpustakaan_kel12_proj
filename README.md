# Dokumentasi Proyek: Perpustakaan Digital Palembang (My Buku)

## Deskripsi Eksekutif
Aplikasi Perpustakaan Digital Palembang merupakan solusi perangkat lunak berbasis _mobile_ yang dikembangkan untuk memfasilitasi akses literatur dan manajemen peminjaman buku. Proyek ini mengintegrasikan ekosistem Firebase untuk pengolahan data _real-time_, manajemen pengguna tersentralisasi, serta pencatatan transaksi yang asinkron dan aman. Aplikasi ini dirancang dengan prinsip pemisahan logika bisnis (Business Logic) dan antarmuka (User Interface) guna memastikan skalabilitas dan kemudahan pemeliharaan kode.

## Arsitektur Sistem dan Basis Data
Proyek ini mengadopsi pendekatan _hybrid database_ dalam ekosistem Firebase untuk mengoptimalkan kinerja aplikasi:

1. **Firebase Realtime Database**
   Digunakan untuk menyimpan entri data yang membutuhkan sinkronisasi berkecepatan tinggi, termasuk:
   - **Katalog Buku**: Menangani operasi _read_ dan pembaruan ketersediaan stok buku secara instan.
   - **Lokasi Perpustakaan**: Menyediakan koordinat geografis (latitude, longitude) untuk integrasi dengan modul pemetaan.

2. **Firebase Cloud Firestore**
   Digunakan untuk menyimpan struktur data yang lebih kompleks dan terikat dengan masing-masing entitas pengguna:
   - **Data Transaksi**: Menyimpan riwayat peminjaman, pembelian, dan pengembalian buku.
   - **Data Favorit**: Mencatat buku yang ditandai oleh pengguna untuk akses cepat di masa mendatang.

## Modul dan Fitur Utama

- **Manajemen Autentikasi**: Menggunakan Firebase Authentication untuk registrasi dan otorisasi sesi pengguna dengan tingkat keamanan standar industri.
- **Sistem Transaksi**: Menyediakan alur peminjaman buku (dengan validasi stok) serta pembelian buku secara langsung. Pembaruan stok dilakukan secara terstruktur untuk mencegah inkonsistensi data antar modul.
- **Sistem Notifikasi Lokal Terjadwal**: Memanfaatkan penjadwalan lokal (Local Notifications) berbasis zona waktu untuk mengirimkan peringatan tenggat pengembalian buku (H-1 dan pada hari jatuh tempo). Notifikasi akan dibatalkan secara otomatis apabila entitas buku dikembalikan sebelum tenggat waktu.
- **Integrasi Pemetaan Spasial**: Modul pemetaan interaktif berbasis `flutter_map` untuk visualisasi sebaran cabang perpustakaan secara presisi pada peta digital.
- **Manajemen State Reaktif**: Menggunakan kombinasi `StreamBuilder` dan pola koneksi persisten pada _StreamController_ untuk memastikan data antarmuka selalu selaras dengan kondisi basis data terkini, menghilangkan latensi waktu muat (loading) berulang.

## Spesifikasi Teknis

- **Bahasa Pemrograman**: Dart
- **Kerangka Kerja**: Flutter (Versi >= 3.10.7)
- **Komponen Utama**:
  - `firebase_core`, `firebase_auth`, `firebase_database`, `cloud_firestore` (Backend Layanan Firebase)
  - `flutter_map`, `latlong2` (Layanan Pemetaan Spasial)
  - `flutter_local_notifications`, `timezone` (Manajemen Sistem Notifikasi)
  - `google_fonts` (Tipografi Antarmuka)

## Struktur Direktori

Kode sumber diorganisasikan dengan paradigma _Feature-Driven_ dan _Service-Oriented Architecture_:

- `/lib/models/`: Model representasi objek data terstruktur (`book_model.dart`, `transaction_model.dart`, `library_location.dart`).
- `/lib/screens/`: Lapisan presentasi atau antarmuka pengguna (`home_screen.dart`, `search_screen.dart`, `favorites_screen.dart`, dll).
- `/lib/services/`: Lapisan layanan pengelola logika bisnis utama:
  - `auth_service.dart`: Pengendali sesi dan autentikasi.
  - `firestore_service.dart`: Operasi basis data pada Cloud Firestore.
  - `realtime_database_service.dart`: Operasi _real-time_ data katalog dan lokasi, memanfaatkan manajemen _stream_ presisten yang efisien.
  - `transaction_service.dart`: Pengendali transaksional agregat yang mengkalkulasi logika peminjaman serta memicu _side-effects_ ke modul notifikasi dan pembaruan stok.
  - `favorites_service.dart`: Manajer state sinkronisasi daftar favorit lokal dengan _cloud_.
  - `notification_service.dart`: Pengendali layanan _broadcast_ peringatan dan tata kelola identitas notifikasi spesifik.

## Konfigurasi dan Instalasi

1. **Kloning Repositori**
   Unduh repositori kode ini ke dalam direktori lokal.
   
2. **Instalasi Dependensi**
   Eksekusi perintah berikut melalui antar muka baris perintah (CLI) untuk mengunduh semua pustaka yang diperlukan:
   ```bash
   flutter pub get
   ```

3. **Konfigurasi Lingkungan Lingkup Firebase**
   - **Android**: Pindahkan berkas konfigurasi `google-services.json` yang diperoleh dari Firebase Console ke dalam direktori `/android/app/`.
   - **Kompilasi Tingkat Lanjut**: Konfigurasi Gradle proyek telah dimodifikasi secara spesifik untuk mengaktifkan properti `coreLibraryDesugaringEnabled` beserta penambahan modul dependensi `desugar_jdk_libs` guna menunjang kompatibilitas pustaka waktu (`timezone`) pada varian Android lama.

4. **Kompilasi dan Eksekusi**
   ```bash
   flutter run
   ```

## Catatan Teknis Operasional Tambahan

1. **Manajemen Indeks Basis Data**: Mekanisme pengurutan riwayat transaksi diproses melalui metode pengurutan sisi klien (_Client-side Sorting_) untuk mengeliminasi limitasi dan ketergantungan pada pembuatan struktur _Composite Index_ manual di sistem _server_.
2. **Manajemen Memori Koneksi Stream**: Implementasi `RealtimeDatabaseService` secara eksplisit menggunakan kontrol sambungan berkesinambungan melalui objek `StreamController.broadcast()`. Pendekatan arsitektur ini terbukti secara efisien memangkas latensi secara masif saat merender kembali pustaka antarmuka dengan menghilangkan proses rekoneksi yang repetitif dan memperberat sistem.
3. **Persyaratan Izin Sistem Operasi**: Aplikasi diprogram secara eksplisit untuk meminta dan menyertakan perizinan akses khusus pada modifikasi Android API Level 33+ (Android 13) yang meliputi manifes fungsi `POST_NOTIFICATIONS` dan `USE_EXACT_ALARM` agar layanan automasi berbasis waktu tetap berjalan sempurna di latar sistem operasi.

---
_Dokumen teknis ini disusun secara khusus untuk merepresentasikan status fungsional dan arsitektural terkini dari sistem Perpustakaan Digital Palembang._
