import 'package:firebase_auth/firebase_auth.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/models/transaction_model.dart';
import 'package:perpustakaan/services/firestore_service.dart';

class TransactionService {
  TransactionService._internal();
  static final TransactionService instance = TransactionService._internal();

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? 'guest_user';

  /// Meminjam buku
  Future<void> borrowBook(BookModel book) async {
    if (book.stock <= 0) {
      throw Exception('Maaf, stok buku sedang habis.');
    }

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final dueDate = DateTime.now().add(const Duration(days: 7)); // Pinjam 7 hari

    final transaction = TransactionModel(
      id: id,
      userId: _userId,
      bookId: book.id,
      bookTitle: book.title,
      bookAuthor: book.author,
      bookImageUrl: book.imageUrl,
      type: 'pinjam',
      status: 'aktif',
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );

    await FirestoreService.instance.createTransaction(transaction);
    await FirestoreService.instance.updateBookStock(book.id, -1);
  }

  /// Membeli buku
  Future<void> buyBook(BookModel book) async {
    if (!book.canBuy) {
      throw Exception('Buku ini tidak tersedia untuk dibeli.');
    }
    if (book.stock <= 0) {
      throw Exception('Maaf, stok buku sedang habis.');
    }

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    final transaction = TransactionModel(
        id: id,
        userId: _userId,
        bookId: book.id,
        bookTitle: book.title,
        bookAuthor: book.author,
        bookImageUrl: book.imageUrl,
        type: 'beli',
        status: 'selesai',
        createdAt: DateTime.now(),
    );

    await FirestoreService.instance.createTransaction(transaction);
    await FirestoreService.instance.updateBookStock(book.id, -1);
  }

  /// Mengembalikan buku yang dipinjam
  Future<void> returnBook(TransactionModel transaction) async {
    if (transaction.type != 'pinjam' || transaction.status != 'aktif') {
      throw Exception('Kondisi transaksi tidak valid untuk pengembalian.');
    }

    await FirestoreService.instance.updateTransactionStatus(transaction.id, 'dikembalikan');
    await FirestoreService.instance.updateBookStock(transaction.bookId, 1);
  }
}
