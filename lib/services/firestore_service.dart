import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perpustakaan/models/book_model.dart';

class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Koleksi referensi ───────────────────────────────────────────────────
  CollectionReference get _booksCol => _db.collection('books');
  CollectionReference _favoritesCol(String userId) =>
      _db.collection('users').doc(userId).collection('favorites');

  // ── BUKU ────────────────────────────────────────────────────────────────

  /// Stream realtime semua buku dari Firestore
  Stream<List<BookModel>> getBooksStream() {
    return _booksCol.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => BookModel.fromFirestore(doc)).toList());
  }

  /// Seed: upload dummy data ke Firestore (jalankan sekali saja)
  Future<void> seedBooks() async {
    final snapshot = await _booksCol.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      // Data sudah ada, skip seeding
      return;
    }
    final batch = _db.batch();
    for (final book in dummyBooks) {
      final ref = _booksCol.doc(book.id);
      batch.set(ref, book.toMap());
    }
    await batch.commit();
  }

  // ── FAVORIT ───────────────────────────────────────────────────────────

  /// Stream id buku yang difavoritkan oleh user
  Stream<List<String>> getFavoriteIdsStream(String userId) {
    return _favoritesCol(userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.id).toList(),
        );
  }

  /// Stream buku favorit lengkap milik user
  Stream<List<BookModel>> getFavoriteBooksStream(String userId) {
    return _favoritesCol(userId).snapshots().asyncMap((snapshot) async {
      final ids = snapshot.docs.map((doc) => doc.id).toList();
      if (ids.isEmpty) return [];

      // Ambil dokumen buku berdasarkan ID favorit
      final futures = ids.map((id) => _booksCol.doc(id).get());
      final docs = await Future.wait(futures);
      return docs
          .where((doc) => doc.exists)
          .map((doc) => BookModel.fromFirestore(doc))
          .toList();
    });
  }

  /// Toggle favorit — tambah jika belum ada, hapus jika sudah ada
  Future<void> toggleFavorite(String userId, String bookId) async {
    final ref = _favoritesCol(userId).doc(bookId);
    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'addedAt': FieldValue.serverTimestamp()});
    }
  }

  /// Cek apakah buku sudah difavoritkan
  Future<bool> isFavorite(String userId, String bookId) async {
    final doc = await _favoritesCol(userId).doc(bookId).get();
    return doc.exists;
  }
}
