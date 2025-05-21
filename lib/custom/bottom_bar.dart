import 'package:flutter/material.dart';
import 'package:notflix/screens/favorites.dart';
import 'package:notflix/screens/home.dart';
import 'package:notflix/screens/movie_list.dart';




class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),        // Arama Sayfası
    const MovieListPage(),     // Listeleme Sayfası
    const FavoritesPage(),     // Favoriler Sayfası
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex], // Aktif sayfa gösterilir
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 170, 33, 243),
        unselectedItemColor: const Color.fromARGB(255, 49, 49, 186),
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Filmler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
        ],
      ),
    );
  }
}
