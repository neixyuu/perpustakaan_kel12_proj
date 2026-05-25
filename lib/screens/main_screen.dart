import 'package:flutter/material.dart';
import 'package:perpustakaan/screens/favorites_screen.dart';
import 'package:perpustakaan/screens/home_screen.dart';
import 'package:perpustakaan/screens/profile_screen.dart';
import 'package:perpustakaan/screens/search_screen.dart';
import 'package:perpustakaan/services/favorites_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ListenableBuilder(
        listenable: FavoritesService.instance,
        builder: (_, __) {
          final favCount = FavoritesService.instance.favorites.length;
          return BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Cari',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: favCount > 0,
                  label: Text('$favCount'),
                  child: const Icon(Icons.favorite_border_rounded),
                ),
                activeIcon: Badge(
                  isLabelVisible: favCount > 0,
                  label: Text('$favCount'),
                  child: const Icon(Icons.favorite_rounded),
                ),
                label: 'Favorit',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}
