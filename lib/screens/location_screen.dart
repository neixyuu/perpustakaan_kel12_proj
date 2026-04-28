import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// Model data lokasi perpustakaan
class LibraryLocation {
  final String id;
  final String name;
  final String address;
  final String hours;
  final String phone;
  final LatLng latLng;

  const LibraryLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.hours,
    required this.phone,
    required this.latLng,
  });
}

// Data perpustakaan di Palembang
const List<LibraryLocation> _libraries = [
  LibraryLocation(
    id: 'pusat',
    name: 'Perpustakaan Daerah Palembang',
    address: 'Jl. Kapten A. Rivai No.5, Palembang',
    hours: 'Sen–Jum: 08.00–16.00',
    phone: '0711-358222',
    latLng: LatLng(-2.9860641, 104.7554959),
  ),
  LibraryLocation(
    id: 'unsri',
    name: 'Perpustakaan Universitas Sriwijaya',
    address: 'Jl. Raya Palembang-Prabumulih KM 32, Indralaya',
    hours: 'Sen–Jum: 07.30–17.00',
    phone: '0711-580069',
    latLng: LatLng(-3.2284, 104.6536),
  ),
  LibraryLocation(
    id: 'uin',
    name: 'Perpustakaan UIN Raden Fatah',
    address: 'Jl. Prof. K.H. Zainal Abidin Fikri, Palembang',
    hours: 'Sen–Jum: 08.00–16.00',
    phone: '0711-362427',
    latLng: LatLng(-2.9693, 104.7406),
  ),
  LibraryLocation(
    id: 'polsri',
    name: 'Perpustakaan Politeknik Sriwijaya',
    address: 'Jl. Srijaya Negara, Bukit Besar, Palembang',
    hours: 'Sen–Jum: 08.00–15.30',
    phone: '0711-353414',
    latLng: LatLng(-2.9753, 104.7298),
  ),
  LibraryLocation(
    id: 'kota',
    name: 'Perpustakaan Kota Palembang',
    address: 'Jl. Merdeka No.1, Palembang',
    hours: 'Sen–Sab: 08.00–17.00',
    phone: '0711-350123',
    latLng: LatLng(-2.9943, 104.7591),
  ),
];

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // flutter_map controller
  final MapController _mapController = MapController();
  LibraryLocation _selected = _libraries.first;

  // Pusat awal kamera
  static const LatLng _palembangCenter = LatLng(-2.9908, 104.7561);

  void _selectLibrary(LibraryLocation lib) {
    setState(() => _selected = lib);
    // Animasi kamera ke lokasi yang dipilih
    _mapController.move(lib.latLng, 16);
  }

  Future<void> _openInMaps(LibraryLocation lib) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${lib.latLng.latitude},${lib.latLng.longitude}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lokasi Perpustakaan',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // ── flutter_map (OpenStreetMap — GRATIS, tanpa API key) ─────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _palembangCenter,
              initialZoom: 12,
              minZoom: 5,
              maxZoom: 18,
            ),
            children: [
              // Tile layer OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.perpustakaan.app',
              ),

              // Marker layer
              MarkerLayer(
                markers: _libraries.map((lib) {
                  final isSelected = lib.id == _selected.id;
                  return Marker(
                    point: lib.latLng,
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () => _selectLibrary(lib),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Shadow
                            Container(
                              width: isSelected ? 44 : 36,
                              height: isSelected ? 44 : 36,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primary.withValues(alpha: 0.2)
                                    : Colors.red.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Pin icon
                            Icon(
                              Icons.location_on,
                              color: isSelected ? primary : Colors.red,
                              size: isSelected ? 38 : 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Attribution (required by OSM terms)
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    '© OpenStreetMap contributors',
                    onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright'),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Chip list atas ─────────────────────────────────────────────
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _libraries.length,
                itemBuilder: (_, i) {
                  final lib = _libraries[i];
                  final isSelected = lib.id == _selected.id;
                  return GestureDetector(
                    onTap: () => _selectLibrary(lib),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: isSelected ? Colors.white : primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            lib.name.split(' ').take(2).join(' '),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Detail Card bawah ──────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: _buildDetailCard(_selected),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(LibraryLocation lib) {
    final primary = Theme.of(context).primaryColor;
    return Container(
      key: ValueKey(lib.id),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nama perpustakaan
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.account_balance, color: primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lib.name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildInfoRow(Icons.location_on_outlined, lib.address),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time_outlined, lib.hours),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.phone_outlined, lib.phone),
          const SizedBox(height: 20),

          // Tombol aksi
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _selectLibrary(lib),
                  icon: const Icon(Icons.map_outlined, size: 18),
                  label: const Text('Lihat di Peta'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: primary),
                    foregroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openInMaps(lib),
                  icon: const Icon(Icons.directions, size: 18),
                  label: const Text('Petunjuk Arah'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}
