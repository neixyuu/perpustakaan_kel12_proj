import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Bantuan',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).cardColor,
foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Contact Support Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.support_agent_rounded, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  'Butuh Bantuan Lebih Lanjut?',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hubungi pustakawan atau admin kami untuk kendala peminjaman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {}, // Add action like launchUrl for WhatsApp or Email
                  child: const Text('Hubungi Admin'),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Pertanyaan Sering Diajukan',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

         // FAQ Items
          _buildFAQItem('Berapa lama batas waktu pinjaman?', 'Batas waktu standar untuk meminjam buku adalah 7 hari. Anda dapat memperpanjangnya 1 kali melalui aplikasi.', context),
          _buildFAQItem('Bagaimana jika terlambat mengembalikan?', 'Keterlambatan pengembalian buku akan dikenakan denda harian sesuai dengan peraturan perpustakaan.', context),
          _buildFAQItem('Apakah saya bisa meminjam lebih dari 3 buku?', 'Saat ini, batas maksimal peminjaman adalah 3 buku secara bersamaan untuk anggota reguler.', context),

        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, BuildContext context,) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.teal,
          title: Text(
            question,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                answer,
                style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
