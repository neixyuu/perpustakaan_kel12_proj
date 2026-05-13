# Perpustakaan Digital Palembang (My Buku)

Aplikasi mobile perpustakaan digital berbasis Flutter yang dirancang untuk memudahkan pengguna dalam meminjam buku, membeli buku, serta mencari lokasi perpustakaan fisik di daerah Palembang dan sekitarnya. Proyek ini dikembangkan menggunakan arsitektur service-based yang memisahkan logika bisnis dengan antarmuka pengguna (UI), serta memanfaatkan layanan Firebase untuk backend.

## Fitur Utama

- **Autentikasi Pengguna**: Sistem login dan registrasi menggunakan Firebase Authentication.
- **Katalog Buku Realtime**: Menampilkan daftar buku yang tersedia secara langsung (realtime) menggunakan Firebase Realtime Database.
- **Peminjaman & Pembelian**: Pengguna dapat meminjam buku dengan tenggat waktu tertentu atau membelinya langsung. Sistem akan secara otomatis mengurangi stok buku di Realtime Database dan mencatat riwayat transaksi di Cloud Firestore.
- **Sistem Favorit**: Pengguna dapat menyimpan buku ke dalam daftar favorit. Data favorit dikelola spesifik per pengguna di Firestore dan direlasikan dengan detail buku di Realtime Database.
- **Peta Lokasi Perpustakaan**: Integrasi peta (menggunakan `flutter_map` dan `latlong2`) untuk menampilkan lokasi cabang perpustakaan secara akurat berdasarkan koordinat.
- **Notifikasi Pengingat Tenggat**: Sistem notifikasi lokal (menggunakan `flutter_local_notifications`) yang dijadwalkan secara otomatis untuk mengingatkan pengguna pada H-1 dan tepat di hari jatuh tempo pengembalian buku.
- **Pencarian & Filter**: Fitur pencarian buku berdasarkan judul dan filter berdasarkan genre.

## Teknologi yang Digunakan

- **Framework**: Flutter (Dart)
- **Backend & Database**: 
  - Firebase Authentication (Manajemen Pengguna)
  - Firebase Realtime Database (Data Buku & Lokasi)
  - Firebase Cloud Firestore (Riwayat Transaksi & Data Favorit Pengguna)
- **State Management**: ListenableBuilder & StreamBuilder
- **Layanan Peta**: `flutter_map`
- **Notifikasi Lokal**: `flutter_local_notifications` dengan dukungan `timezone`

## Struktur Proyek

Proyek ini mengadopsi pemisahan _concern_ melalui struktur folder berikut:

- `/lib/models/`: Berisi kelas representasi data seperti `BookModel`, `TransactionModel`, dan `LibraryLocation`.
- `/lib/screens/`: Berisi seluruh tampilan halaman antarmuka pengguna (UI).
- `/lib/services/`: Pusat logika bisnis dan interaksi dengan Firebase backend.
  - `auth_service.dart`: Mengelola login, registrasi, dan state pengguna.
  - `firestore_service.dart`: Mengelola read/write dokumen di Cloud Firestore (Transaksi & Favorit).
  - `realtime_database_service.dart`: Mengelola _stream_ data buku dan lokasi dari Realtime Database.
  - `transaction_service.dart`: Mengelola alur peminjaman, pembelian, dan pengembalian buku.
  - `favorites_service.dart`: Mengelola _state_ favorit pengguna di aplikasi secara sinkron dengan Firestore.
  - `notification_service.dart`: Mengelola penjadwalan dan pembatalan notifikasi tenggat waktu.

## Persiapan & Menjalankan Proyek

### Prasyarat
- Flutter SDK (versi >= 3.10.7)
- Proyek Firebase yang sudah terkonfigurasi untuk Android/iOS dengan fitur Authentication, Realtime Database, dan Cloud Firestore diaktifkan.

### Langkah-langkah

1. **Clone repositori ini**
2. **Unduh dependensi**
   Jalankan perintah berikut di terminal:
   ```bash
   flutter pub get
   ```
3. **Konfigurasi Firebase**
   - Pastikan file `google-services.json` telah diletakkan pada folder `android/app/` (untuk Android).
   - Pastikan database URL pada Realtime Database sudah sesuai dengan konfigurasi proyek Firebase Anda.
   - Aktifkan database Firestore di Firebase Console dan atur _rules_ agar mengizinkan baca/tulis bagi pengguna yang terautentikasi.
4. **Jalankan Aplikasi**
   ```bash
   flutter run
   ```

## Catatan Penting

- Saat menggunakan fitur filter dan pencarian transaksi, pastikan untuk tidak menggabungkan `.where()` dan `.orderBy()` pada atribut yang berbeda tanpa membuat _Composite Index_ terlebih dahulu di Firebase Console. Pada implementasi saat ini, pengurutan dilakukan di sisi _client_ (Dart) untuk menghindari keharusan pembuatan _index_ secara manual.
- Aplikasi ini memerlukan izin `POST_NOTIFICATIONS` dan `USE_EXACT_ALARM` pada perangkat Android 13+ agar fitur pengingat tenggat waktu dapat berfungsi dengan baik.

---
Dikembangkan sebagai bagian dari proyek akhir aplikasi perpustakaan digital.
