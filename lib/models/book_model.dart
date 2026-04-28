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
  final String publisher;
  final int year;
  final int pages;
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
    this.publisher = '',
    this.year = 0,
    this.pages = 0,
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
      publisher: data['publisher'] ?? '',
      year: (data['year'] ?? 0) as int,
      pages: (data['pages'] ?? 0) as int,
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
        'publisher': publisher,
        'year': year,
        'pages': pages,
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
    description:
        'Buku ini mengulas perjalanan panjang Kota Palembang dari masa kerajaan Sriwijaya hingga perkembangan modern. Menelusuri jejak peradaban yang kaya dan warisan budaya yang masih lestari hingga kini.',
    publisher: 'Pustaka Nusantara',
    year: 2020,
    pages: 320,
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
    description:
        'Eksplorasi mendalam tentang kejayaan Kerajaan Sriwijaya sebagai pusat perdagangan dan agama di Asia Tenggara. Buku ini menelusuri bukti-bukti arkeologi dan catatan sejarah yang tersimpan.',
    publisher: 'Gramedia Pustaka',
    year: 2019,
    pages: 280,
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
    description:
        'Foto dan cerita tentang Palembang di masa kolonial Belanda. Menampilkan dokumentasi visual kehidupan sehari-hari masyarakat Palembang dari abad ke-19 hingga awal kemerdekaan.',
    publisher: 'Balai Pustaka',
    year: 2018,
    pages: 150,
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
    description:
        'Dokumentasi lengkap berbagai tradisi dan budaya masyarakat Palembang yang kaya. Dari upacara adat, kesenian tradisional, hingga nilai-nilai kearifan lokal yang masih dijaga.',
    publisher: 'Pustaka Nusantara',
    year: 2021,
    pages: 240,
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
    description:
        'Resep-resep autentik masakan Palembang termasuk pempek, tekwan, dan mie celor. Panduan lengkap untuk memasak kuliner khas Palembang dengan bahan-bahan yang mudah ditemukan.',
    publisher: 'Dapur Indonesia',
    year: 2022,
    pages: 200,
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
    description:
        'Keindahan alam dan keanekaragaman hayati Sumatera Selatan dari Sungai Musi hingga Bukit Barisan. Menjelajahi flora, fauna, dan ekosistem yang unik di bumi Sriwijaya.',
    publisher: 'Alam Lestari',
    year: 2020,
    pages: 260,
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
    description:
        'Panduan lengkap bahasa dan dialek Melayu Palembang beserta kamus sehari-hari. Buku ini membantu pembaca memahami dan menggunakan bahasa Palembang dengan benar.',
    publisher: 'Lingkar Bahasa',
    year: 2017,
    pages: 310,
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
    description:
        'Peluang dan perkembangan ekonomi kreatif di Sumatera Selatan pasca pandemi. Mengulas strategi pengembangan UMKM, industri kreatif, dan potensi investasi di wilayah ini.',
    publisher: 'Karisma Publishing',
    year: 2023,
    pages: 290,
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
    description:
        'Kumpulan legenda dan cerita rakyat Palembang yang diwariskan turun-temurun. Mengisahkan tokoh-tokoh mitologi dan nilai-nilai moral yang terkandung dalam tradisi lisan masyarakat Palembang.',
    publisher: 'Balai Pustaka',
    year: 2016,
    pages: 180,
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
    description:
        'Kisah inovator muda Indonesia yang memanfaatkan teknologi untuk membangun daerahnya. Inspirasi nyata tentang bagaimana teknologi digital bisa memberdayakan masyarakat lokal.',
    publisher: 'TechPress Indonesia',
    year: 2023,
    pages: 340,
    price: 80000,
    canBuy: true,
    stock: 4,
  ),
];
