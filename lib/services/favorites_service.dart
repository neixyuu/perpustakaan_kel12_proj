import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/services/firestore_service.dart';

/// Service favorit dengan local state + sync ke Firestore.
/// Saat login bypass aktif, userId = "guest_user".
/// Saat Firebase Auth aktif, userId = uid asli dari FirebaseAuth.
class FavoritesService extends ChangeNotifier {
  FavoritesService._internal();
  static final FavoritesService instance = FavoritesService._internal();

  // Local cache id buku favorit (untuk UI responsif tanpa tunggu Firestore)
  final Set<String> _favoriteIds = {};
  // Local cache objek buku favorit
  final List<BookModel> _favorites = [];

  List<BookModel> get favorites => List.unmodifiable(_favorites);
  bool isFavorite(String bookId) => _favoriteIds.contains(bookId);

  /// Ambil userId aktif — guest jika bypass, uid asli jika sudah login
  String get _userId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'guest_user';

  /// Inisialisasi: mulai listen stream favorit dari Firestore
  void init() {
    FirestoreService.instance
        .getFavoriteBooksStream(_userId)
        .listen((books) {
      _favorites
        ..clear()
        ..addAll(books);
      _favoriteIds
        ..clear()
        ..addAll(books.map((b) => b.id));
      notifyListeners();
    });
  }

  /// Toggle favorit: update lokal dulu (optimistic UI) lalu sync ke Firestore
  Future<void> toggle(BookModel book) async {
    final wasFav = _favoriteIds.contains(book.id);

    // Update lokal (optimistic)
    if (wasFav) {
      _favoriteIds.remove(book.id);
      _favorites.removeWhere((b) => b.id == book.id);
    } else {
      _favoriteIds.add(book.id);
      _favorites.add(book);
    }
    notifyListeners();

    // Sync ke Firestore (di background)
    try {
      await FirestoreService.instance.toggleFavorite(_userId, book.id);
    } catch (_) {
      // Rollback jika gagal
      if (wasFav) {
        _favoriteIds.add(book.id);
        _favorites.add(book);
      } else {
        _favoriteIds.remove(book.id);
        _favorites.removeWhere((b) => b.id == book.id);
      }
      notifyListeners();
    }
  }
}
