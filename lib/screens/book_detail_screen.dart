import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpustakaan/models/book_model.dart';
import 'package:perpustakaan/services/favorites_service.dart';
import 'package:perpustakaan/services/transaction_service.dart';
import 'package:perpustakaan/l10n/app_localizations.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // 1. Check if the app is currently in Dark Mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Setup dynamic colors that swap seamlessly between modes
    final dynamicCardColor = Theme.of(context).cardColor;
    final dynamicScaffoldBg = Theme.of(context).scaffoldBackgroundColor;
    final mainTextColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor = isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.07);

    return Scaffold(
      backgroundColor: dynamicScaffoldBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
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
                      color: isFav ? Colors.red.shade300 : Colors.white,
                    ),
                    onPressed: () {
                      FavoritesService.instance.toggle(book);
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(SnackBar(
                          content: Text(isFav
                              ? AppLocalizations.of(context)!.removedFromFavorites(book.title)
                              : AppLocalizations.of(context)!.addedToFavorites(book.title)),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ));
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.85),
                    ],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Hero(
                      tag: 'book_cover_${book.id}',
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            book.imageUrl,
                            height: 200,
                            width: 135,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 200,
                              width: 135,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.book,
                                  size: 60, color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              AppLocalizations.of(context)!.bookDetail,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: dynamicScaffoldBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: dynamicCardColor,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
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
                        const SizedBox(height: 12),
                        Text(
                          book.title,
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.person_outline,
                                size: 16, color: subTextColor),
                            const SizedBox(width: 4),
                            Text(
                              book.author,
                              style: TextStyle(
                                fontSize: 15,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: book.status == 'Tersedia'
                                ? Colors.green.withOpacity(0.15)
                                : Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: book.status == 'Tersedia'
                                      ? Colors.green
                                      : Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                book.status,
                                style: TextStyle(
                                  color: book.status == 'Tersedia'
                                      ? (isDark ? Colors.green.shade300 : Colors.green.shade700)
                                      : (isDark ? Colors.orange.shade300 : Colors.orange.shade700),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Book info row
                  Container(
                    color: dynamicCardColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Row(
                      children: [
                        _buildInfoItem(
                          context,
                          Icons.business_outlined,
                          AppLocalizations.of(context)!.publisher,
                          book.publisher.isNotEmpty ? book.publisher : '-',
                        ),
                        _buildDivider(context),
                        _buildInfoItem(
                          context,
                          Icons.calendar_today_outlined,
                          AppLocalizations.of(context)!.year,
                          book.year > 0 ? '${book.year}' : '-',
                        ),
                        _buildDivider(context),
                        _buildInfoItem(
                          context,
                          Icons.menu_book_outlined,
                          AppLocalizations.of(context)!.pages,
                          book.pages > 0 ? '${book.pages}' : '-',
                        ),
                        _buildDivider(context),
                        _buildInfoItem(
                          context,
                          Icons.inventory_2_outlined,
                          AppLocalizations.of(context)!.stock,
                          '${book.stock}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    color: dynamicCardColor,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.description,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          book.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: subTextColor,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Detail info
                  Container(
                    color: dynamicCardColor,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.bookInfo,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(context, AppLocalizations.of(context)!.author, book.author),
                        _buildDetailRow(
                            context,
                            AppLocalizations.of(context)!.publisher,
                            book.publisher.isNotEmpty
                                ? book.publisher
                                : '-'),
                        _buildDetailRow(context, AppLocalizations.of(context)!.publishYear,
                            book.year > 0 ? '${book.year}' : '-'),
                        _buildDetailRow(context, AppLocalizations.of(context)!.pageCount,
                            book.pages > 0 ? AppLocalizations.of(context)!.pagesUnit(book.pages) : '-'),
                        _buildDetailRow(context, AppLocalizations.of(context)!.genre, book.genre),
                        _buildDetailRow(context, AppLocalizations.of(context)!.shelfLocation, book.rack),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: dynamicCardColor,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 12,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Favorite
              ListenableBuilder(
                listenable: FavoritesService.instance,
                builder: (context, _) {
                  final isFav =
                      FavoritesService.instance.isFavorite(book.id);
                  return Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFav ? Colors.red : (isDark ? Colors.grey.shade400 : Colors.grey.shade500),
                      ),
                      onPressed: () {
                        FavoritesService.instance.toggle(book);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 14),
              // Pinjam
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      book.stock > 0 ? () => _handlePinjam(context) : null,
                  icon: const Icon(Icons.import_contacts_rounded),
                  label: Text(
                    book.stock > 0 ? AppLocalizations.of(context)!.borrowBook : AppLocalizations.of(context)!.outOfStock,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 40,
      width: 1,
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePinjam(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final isDarkPopup = Theme.of(ctx).brightness == Brightness.dark;
        final popupPreviewBg = isDarkPopup ? Colors.grey.shade800 : const Color(0xFFF5F7FA);
        final popupTextColor = isDarkPopup ? Colors.white : Colors.black87;
        final popupMutedColor = isDarkPopup ? Colors.grey.shade400 : Colors.grey.shade500;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).primaryColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.import_contacts_rounded,
                  color: Theme.of(ctx).primaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(ctx)!.confirmBorrow,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: popupTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(ctx)!.borrowDueInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: popupMutedColor,
                ),
              ),
              const SizedBox(height: 20),
              // Book preview
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: popupPreviewBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        book.imageUrl,
                        width: 40,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 40,
                          height: 56,
                          color: isDarkPopup ? Colors.grey.shade700 : Colors.grey.shade200,
                          child: Icon(Icons.book,
                              color: popupMutedColor, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: popupTextColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            book.author,
                            style: TextStyle(
                              fontSize: 12,
                              color: popupMutedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: isDarkPopup ? Colors.grey.shade700 : Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        AppLocalizations.of(ctx)!.cancel,
                        style: TextStyle(color: isDarkPopup ? Colors.white70 : Colors.black54),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: Text(AppLocalizations.of(ctx)!.yesBorrow),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await TransactionService.instance.borrowBook(book);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.borrowSuccess),
            behavior: SnackBarBehavior.floating,
          ));
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.borrowFailed(e.toString()))));
      }
    }
  }
}