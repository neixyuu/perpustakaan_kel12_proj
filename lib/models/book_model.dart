import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String status;
  final String rack;
  final String imageUrl;
  final String description;
  final double price;
  final bool canBuy;
  final int stock;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.status,
    required this.rack,
    required this.imageUrl,
    required this.description,
    this.price = 0,
    this.canBuy = false,
    this.stock = 1,
  });

  /// Dari Firestore DocumentSnapshot
  factory BookModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookModel(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      genre: data['genre'] ?? '',
      status: data['status'] ?? 'Tersedia',
      rack: data['rack'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      canBuy: data['canBuy'] ?? false,
      stock: data['stock'] ?? 1,
    );
  }

  /// Untuk upload ke Firestore
  Map<String, dynamic> toMap() => {
        'title': title,
        'author': author,
        'genre': genre,
        'status': status,
        'rack': rack,
        'imageUrl': imageUrl,
        'description': description,
        'price': price,
        'canBuy': canBuy,
        'stock': stock,
      };
}

/// Data dummy — dipakai HANYA untuk seeding Firestore pertama kali
final List<BookModel> dummyBooks = [
  BookModel(
    id: 'book_01',
    title: 'Sejarah Palembang',
    author: 'Halim Alamsyah',
    genre: 'Sejarah',
    status: 'Tersedia',
    rack: 'Rak A1',
    imageUrl: 'https://picsum.photos/seed/book1/100/150',
    description: 'Buku ini mengulas perjalanan panjang Kota Palembang dari masa kerajaan Sriwijaya hingga era modern.',
    price: 50000,
    canBuy: true,
    stock: 5,
  ),
  BookModel(
    id: 'book_02',
    title: 'Jejak Kerajaan Sriwijaya',
    author: 'Siti Rahmah',
    genre: 'Sejarah',
    status: 'Tersedia',
    rack: 'Rak B2',
    imageUrl: 'https://picsum.photos/seed/book2/100/150',
    description: 'Eksplorasi mendalam tentang kejayaan Kerajaan Sriwijaya sebagai pusat perdagangan dan agama di Asia Tenggara.',
    price: 75000,
    canBuy: true,
    stock: 3,
  ),
  BookModel(
    id: 'book_03',
    title: 'Kota Palembang Tempo Dulu',
    author: 'M. Isa',
    genre: 'Sejarah',
    status: 'Tersedia',
    rack: 'Rak C3',
    imageUrl: 'https://picsum.photos/seed/book3/100/150',
    description: 'Foto dan cerita tentang Palembang di masa kolonial Belanda.',
    canBuy: false,
    stock: 2,
  ),
  BookModel(
    id: 'book_04',
    title: 'Budaya dan Tradisi Palembang',
    author: 'Yullana',
    genre: 'Budaya',
    status: 'Tersedia',
    rack: 'Rak D1',
    imageUrl: 'https://picsum.photos/seed/book4/100/150',
    description: 'Dokumentasi lengkap berbagai tradisi dan budaya masyarakat Palembang yang kaya.',
    price: 45000,
    canBuy: true,
    stock: 4,
  ),
  BookModel(
    id: 'book_05',
    title: 'Masakan Khas Palembang',
    author: 'Dewi Lestari',
    genre: 'Kuliner',
    status: 'Tersedia',
    rack: 'Rak E2',
    imageUrl: 'https://picsum.photos/seed/book5/100/150',
    description: 'Resep-resep autentik masakan Palembang termasuk pempek, tekwan, dan mie celor.',
    price: 60000,
    canBuy: true,
    stock: 6,
  ),
  BookModel(
    id: 'book_06',
    title: 'Alam Sumatera Selatan',
    author: 'Rizal Kurnia',
    genre: 'Alam',
    status: 'Tersedia',
    rack: 'Rak F1',
    imageUrl: 'https://picsum.photos/seed/book6/100/150',
    description: 'Keindahan alam dan keanekaragaman hayati Sumatera Selatan dari Sungai Musi hingga Bukit Barisan.',
    canBuy: false,
    stock: 1,
  ),
  BookModel(
    id: 'book_07',
    title: 'Bahasa Melayu Palembang',
    author: 'Ahmad Fauzi',
    genre: 'Bahasa',
    status: 'Tersedia',
    rack: 'Rak G3',
    imageUrl: 'https://picsum.photos/seed/book7/100/150',
    description: 'Panduan lengkap bahasa dan dialek Melayu Palembang beserta kamus sehari-hari.',
    price: 35000,
    canBuy: true,
    stock: 7,
  ),
  BookModel(
    id: 'book_08',
    title: 'Ekonomi Kreatif Sumsel',
    author: 'Budi Santoso',
    genre: 'Ekonomi',
    status: 'Tersedia',
    rack: 'Rak H2',
    imageUrl: 'https://picsum.photos/seed/book8/100/150',
    description: 'Peluang dan perkembangan ekonomi kreatif di Sumatera Selatan pasca pandemi.',
    price: 55000,
    canBuy: true,
    stock: 3,
  ),
  BookModel(
    id: 'book_09',
    title: 'Legenda Putri Kembang Dadar',
    author: 'Sri Wahyuni',
    genre: 'Sastra',
    status: 'Tersedia',
    rack: 'Rak I1',
    imageUrl: 'https://picsum.photos/seed/book9/100/150',
    description: 'Kumpulan legenda dan cerita rakyat Palembang yang diwariskan turun-temurun.',
    canBuy: false,
    stock: 2,
  ),
  BookModel(
    id: 'book_10',
    title: 'Teknologi untuk Negeri',
    author: 'Fajar Pratama',
    genre: 'Teknologi',
    status: 'Tersedia',
    rack: 'Rak J4',
    imageUrl: 'https://picsum.photos/seed/book10/100/150',
    description: 'Kisah inovator muda Indonesia yang memanfaatkan teknologi untuk membangun daerahnya.',
    price: 80000,
    canBuy: true,
    stock: 4,
  ),
];
