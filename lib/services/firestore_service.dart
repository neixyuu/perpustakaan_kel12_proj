import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perpustakaan/models/transaction_model.dart';

/// Mengelola data user-specific di Firestore:
/// - Favorit buku (per user)
/// - Riwayat transaksi
/// - Profil user
///
/// Catatan: Data buku & perpustakaan kini diambil dari Realtime Database.
class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _transactionsCol => _db.collection('transactions');
  CollectionReference _favoritesCol(String userId) =>
      _db.collection('users').doc(userId).collection('favorites');

  // ── FAVORIT ───────────────────────────────────────────────────────────

  /// Stream id buku yang difavoritkan oleh user
  Stream<List<String>> getFavoriteIdsStream(String userId) {
    return _favoritesCol(userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.id).toList(),
        );
  }

  /// Stream ID favorit untuk digunakan oleh FavoritesService
  Stream<Set<String>> getFavoriteIdsSetStream(String userId) {
    return _favoritesCol(userId)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toSet());
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

  // ── TRANSACTIONS ────────────────────────────────────────────────────────

  Stream<List<TransactionModel>> getUserTransactionsStream(String userId) {
    return _transactionsCol
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
      // Sort client-side to avoid needing a Firestore composite index
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    await _transactionsCol.doc(transaction.id).set(transaction.toMap());
  }

  Future<void> updateTransactionStatus(String id, String status) async {
    await _transactionsCol.doc(id).update({'status': status});
  }
}
