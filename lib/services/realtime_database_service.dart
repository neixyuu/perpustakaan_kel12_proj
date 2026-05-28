import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/screens/location_screen.dart';

/// Service untuk membaca & menulis data dari Firebase Realtime Database.
/// - books/      → daftar buku (read + update stock)
/// - libraries/  → lokasi perpustakaan (read only)
///
/// Stream buku dan perpustakaan menggunakan StreamController.broadcast()
/// dengan koneksi Firebase yang selalu aktif (persistent), sehingga tidak
/// terputus saat berpindah layar.
class RealtimeDatabaseService {
  RealtimeDatabaseService._() {
    _initStreams();
  }
  static final RealtimeDatabaseService instance = RealtimeDatabaseService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // StreamControllers yang selalu aktif
  final _booksController = StreamController<List<BookModel>>.broadcast();
  final _librariesController = StreamController<List<LibraryLocation>>.broadcast();

  // Subscription internal (persistent — tidak dibatalkan saat UI navigasi)
  StreamSubscription? _booksSubscription;
  StreamSubscription? _librariesSubscription;

  // Cache data terakhir agar subscriber baru langsung menerima data
  List<BookModel>? _lastBooks;
  List<LibraryLocation>? _lastLibraries;

  void _initStreams() {
    // ── Books ──────────────────────────────────────────────────────────────
    _booksSubscription = _db.ref('books').onValue.listen((event) {
      final raw = event.snapshot.value;
      if (raw == null) {
        _lastBooks = [];
        _booksController.add([]);
        return;
      }
      final data = Map<String, dynamic>.from(raw as Map);
      final books = data.entries
          .map((e) => BookModel.fromRTDB(
                e.key,
                Map<String, dynamic>.from(e.value as Map),
              ))
          .toList();
      _lastBooks = books;
      _booksController.add(books);
    }, onError: (e) {
      _booksController.addError(e);
    });

    // ── Libraries ──────────────────────────────────────────────────────────
    _librariesSubscription = _db.ref('libraries').onValue.listen((event) {
      final raw = event.snapshot.value;
      if (raw == null) {
        _lastLibraries = [];
        _librariesController.add([]);
        return;
      }
      final data = Map<String, dynamic>.from(raw as Map);
      final libs = data.entries
          .map((e) => LibraryLocation.fromRTDB(
                e.key,
                Map<String, dynamic>.from(e.value as Map),
              ))
          .toList();
      _lastLibraries = libs;
      _librariesController.add(libs);
    }, onError: (e) {
      _librariesController.addError(e);
    });
  }

  // ── BUKU ─────────────────────────────────────────────────────────────────

  /// Stream realtime semua buku dari RTDB.
  /// Subscriber baru langsung menerima data cache terakhir jika sudah tersedia.
  Stream<List<BookModel>> getBooksStream() {
    return Stream<List<BookModel>>.multi((controller) {
      // Emit data terakhir yang sudah tersedia langsung
      if (_lastBooks != null) controller.add(_lastBooks!);
      // Lanjutkan subscribe ke broadcast
      final sub = _booksController.stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = sub.cancel;
    });
  }

  /// Ambil satu buku berdasarkan ID (one-time read)
  Future<BookModel?> getBookById(String bookId) async {
    final snapshot = await _db.ref('books/$bookId').get();
    if (!snapshot.exists || snapshot.value == null) return null;
    return BookModel.fromRTDB(
      bookId,
      Map<String, dynamic>.from(snapshot.value as Map),
    );
  }

  /// Update stok buku (+1 kembalikan, -1 pinjam/beli)
  Future<void> updateBookStock(String bookId, int stockChange) async {
    final ref = _db.ref('books/$bookId');
    
    // Menggunakan get() dan update() karena runTransaction() di Flutter 
    // sering abort jika data belum ada di cache lokal.
    final snapshot = await ref.get();
    if (!snapshot.exists || snapshot.value == null) return;
    
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    final currentStock = (data['stock'] ?? 1) as int;
    final newStock = (currentStock + stockChange).clamp(0, 9999);
    
    await ref.update({
      'stock': newStock,
      'status': newStock > 0 ? 'Tersedia' : 'Dipinjam',
    });
  }

  // ── PERPUSTAKAAN ──────────────────────────────────────────────────────────

  /// Stream realtime semua lokasi perpustakaan dari RTDB.
  /// Subscriber baru langsung menerima data cache terakhir jika sudah tersedia.
  Stream<List<LibraryLocation>> getLibrariesStream() {
    return Stream<List<LibraryLocation>>.multi((controller) {
      if (_lastLibraries != null) controller.add(_lastLibraries!);
      final sub = _librariesController.stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = sub.cancel;
    });
  }

  void dispose() {
    _booksSubscription?.cancel();
    _librariesSubscription?.cancel();
  }
}

