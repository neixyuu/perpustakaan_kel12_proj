import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/transaction_service.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          'Detail Buku',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          ListenableBuilder(
            listenable: FavoritesService.instance,
            builder: (context, _) {
              final isFav = FavoritesService.instance.isFavorite(book.id);
              return IconButton(
                icon: Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFav ? Colors.red : Colors.grey.shade400,
                ),
                onPressed: () {
                  FavoritesService.instance.toggle(book);
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(
                      content: Text(isFav
                          ? '${book.title} dihapus dari favorit'
                          : '${book.title} ditambahkan ke favorit ❤️'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ));
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Image
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Hero(
                  tag: 'book_cover_${book.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        book.imageUrl,
                        height: 220,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 220,
                          width: 150,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.book,
                              size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Info Card
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        book.genre,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      book.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      book.author,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('Stok', '${book.stock}'),
                      _buildStatColumn('Rak', book.rack),
                      _buildStatColumn(
                        'Harga',
                        book.canBuy
                            ? currencyFormat.format(book.price)
                            : '-',
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  Text(
                    'Deskripsi',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: book.stock > 0
                      ? () => _handlePinjam(context)
                      : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor),
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Pinjam',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              if (book.canBuy) const SizedBox(width: 16),
              if (book.canBuy)
                Expanded(
                  child: ElevatedButton(
                    onPressed: book.stock > 0
                        ? () => _handleBeli(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Beli',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> _handlePinjam(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await TransactionService.instance.borrowBook(book);
      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
              content: Text('Buku berhasil dipinjam!')));
        Navigator.pop(context); // Close detail screen
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal meminjam: ${e.toString()}')));
      }
    }
  }

  Future<void> _handleBeli(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await TransactionService.instance.buyBook(book);
      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
              content: Text('Buku berhasil dibeli!')));
        Navigator.pop(context); // Close detail screen
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal membeli: ${e.toString()}')));
      }
    }
  }
}
