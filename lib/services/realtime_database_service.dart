import 'package:firebase_database/firebase_database.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/screens/location_screen.dart';

/// Service untuk membaca & menulis data dari Firebase Realtime Database.
/// - books/      → daftar buku (read + update stock)
/// - libraries/  → lokasi perpustakaan (read only)
class RealtimeDatabaseService {
  RealtimeDatabaseService._();
  static final RealtimeDatabaseService instance = RealtimeDatabaseService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // ── BUKU ────────────────────────────────────────────────────────────────

  /// Stream realtime semua buku dari RTDB
  Stream<List<BookModel>> getBooksStream() {
    return _db.ref('books').onValue.map((event) {
      final raw = event.snapshot.value;
      print('RTDB Books Raw Data: $raw');
      if (raw == null) return <BookModel>[];
      final data = Map<String, dynamic>.from(raw as Map);
      return data.entries
          .map((e) => BookModel.fromRTDB(e.key, Map<String, dynamic>.from(e.value as Map)))
          .toList();
    }).handleError((error) {
      print('RTDB Books Error: $error');
      throw error;
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
    await ref.runTransaction((currentData) {
      if (currentData == null) return Transaction.abort();
      final data = Map<String, dynamic>.from(currentData as Map);
      final currentStock = (data['stock'] ?? 1) as int;
      final newStock = (currentStock + stockChange).clamp(0, 9999);
      data['stock'] = newStock;
      data['status'] = newStock > 0 ? 'Tersedia' : 'Dipinjam';
      return Transaction.success(data);
    });
  }

  // ── PERPUSTAKAAN ─────────────────────────────────────────────────────────

  /// Stream realtime semua lokasi perpustakaan dari RTDB
  Stream<List<LibraryLocation>> getLibrariesStream() {
    return _db.ref('libraries').onValue.map((event) {
      final raw = event.snapshot.value;
      print('RTDB Libraries Raw Data: $raw');
      if (raw == null) return <LibraryLocation>[];
      final data = Map<String, dynamic>.from(raw as Map);
      return data.entries
          .map((e) => LibraryLocation.fromRTDB(
                e.key,
                Map<String, dynamic>.from(e.value as Map),
              ))
          .toList();
    }).handleError((error) {
      print('RTDB Libraries Error: $error');
      throw error;
    });
  }
}
