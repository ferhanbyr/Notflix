import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Image.asset(
          'lib/assets/poster/anime.png',
          width: 200,
          height: 200,
        ),

      ),
    );
  }
}