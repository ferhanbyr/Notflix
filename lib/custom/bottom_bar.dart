import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notflix/screens/favorites.dart';
import 'package:notflix/screens/profile_page.dart';
import 'package:notflix/screens/home.dart';
import 'package:notflix/screens/profile_page.dart';




class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),       
    const FavoritesPage(),     // Listeleme Sayfası
    const ProfilePage(),     // Favoriler Sayfası
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
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
      ),
    );
  }
}
