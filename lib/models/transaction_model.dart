import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String bookId;
  final String bookTitle;
  final String bookAuthor;
  final String bookImageUrl;
  final String type; // 'pinjam' atau 'beli'
  final String status; // 'aktif', 'dikembalikan', 'selesai'
  final DateTime createdAt;
  final DateTime? dueDate;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.type,
    required this.status,
    required this.createdAt,
    this.dueDate,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      bookId: data['bookId'] ?? '',
      bookTitle: data['bookTitle'] ?? '',
      bookAuthor: data['bookAuthor'] ?? '',
      bookImageUrl: data['bookImageUrl'] ?? '',
      type: data['type'] ?? 'pinjam',
      status: data['status'] ?? 'aktif',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'bookId': bookId,
        'bookTitle': bookTitle,
        'bookAuthor': bookAuthor,
        'bookImageUrl': bookImageUrl,
        'type': type,
        'status': status,
        'createdAt': Timestamp.fromDate(createdAt),
        'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      };
}
