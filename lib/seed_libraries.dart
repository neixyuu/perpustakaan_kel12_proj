import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final db = FirebaseDatabase.instance.ref('libraries');
  
  final libraries = {
    'pusat': {
      'name': 'Perpustakaan Daerah Palembang',
      'address': 'Jl. Kapten A. Rivai No.5, Palembang',
      'hours': 'Sen–Jum: 08.00–16.00',
      'phone': '0711-358222',
      'latitude': -2.9860641,
      'longitude': 104.7554959,
    },
    'unsri': {
      'name': 'Perpustakaan Universitas Sriwijaya',
      'address': 'Jl. Raya Palembang-Prabumulih KM 32, Indralaya',
      'hours': 'Sen–Jum: 07.30–17.00',
      'phone': '0711-580069',
      'latitude': -3.2284,
      'longitude': 104.6536,
    },
    'uin': {
      'name': 'Perpustakaan UIN Raden Fatah',
      'address': 'Jl. Prof. K.H. Zainal Abidin Fikri, Palembang',
      'hours': 'Sen–Jum: 08.00–16.00',
      'phone': '0711-362427',
      'latitude': -2.9693,
      'longitude': 104.7406,
    },
    'polsri': {
      'name': 'Perpustakaan Politeknik Sriwijaya',
      'address': 'Jl. Srijaya Negara, Bukit Besar, Palembang',
      'hours': 'Sen–Jum: 08.00–15.30',
      'phone': '0711-353414',
      'latitude': -2.9753,
      'longitude': 104.7298,
    },
    'kota': {
      'name': 'Perpustakaan Kota Palembang',
      'address': 'Jl. Merdeka No.1, Palembang',
      'hours': 'Sen–Sab: 08.00–17.00',
      'phone': '0711-350123',
      'latitude': -2.9943,
      'longitude': 104.7591,
    },
  };

  await db.set(libraries);
  print('Berhasil update data lokasi ke versi original!');
}
