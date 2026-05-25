  import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/services/firestore_service.dart';
import 'package:perpustakaan/services/realtime_database_service.dart';

/// Service favorit dengan local state + sync ke Firestore.
/// IDs favorit → Firestore, data buku → Realtime Database.
class FavoritesService extends ChangeNotifier {
  FavoritesService._internal();
  static final FavoritesService instance = FavoritesService._internal();

  // Local cache id buku favorit
  final Set<String> _favoriteIds = {};
  // Local cache objek buku favorit (populated dari RTDB)
  final List<BookModel> _favorites = [];

  StreamSubscription? _authSub;
  StreamSubscription? _favSub;

  List<BookModel> get favorites => List.unmodifiable(_favorites);
  bool isFavorite(String bookId) => _favoriteIds.contains(bookId);

  String get _userId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'guest_user';

  /// Inisialisasi: otomatis listen ke perubahan AuthState (login/logout/startup),
  /// lalu listen ID favorit dari Firestore untuk user tersebut.
  void init() {
    _authSub?.cancel();
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      final uid = user?.uid ?? 'guest_user';
      
      _favSub?.cancel();
      _favSub = FirestoreService.instance
          .getFavoriteIdsStream(uid)
          .listen((ids) async {
        _favoriteIds
          ..clear()
          ..addAll(ids);

        // Ambil data buku dari RTDB berdasarkan ID favorit
        if (ids.isEmpty) {
          _favorites.clear();
          notifyListeners();
          return;
        }

        final futures = ids.map((id) =>
            RealtimeDatabaseService.instance.getBookById(id));
        final results = await Future.wait(futures);

        _favorites
          ..clear()
          ..addAll(results.whereType<BookModel>());

        notifyListeners();
      });
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
    } catch (e) {
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
