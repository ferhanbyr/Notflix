import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notflix/models/most.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_movies';

  // Favorilere film ekle
  static Future<void> addToFavorites(Most movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    // Film zaten favorilerde değilse ekle
    String movieJson = jsonEncode({
      'title': movie.title,
      'poster': movie.poster,
      'year': movie.year,
    });
    
    if (!favorites.contains(movieJson)) {
      favorites.add(movieJson);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Favorilerden film çıkar
  static Future<void> removeFromFavorites(Most movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    String movieJson = jsonEncode({
      'title': movie.title,
      'poster': movie.poster,
      'year': movie.year,
    });
    
    favorites.remove(movieJson);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  // Film favorilerde mi kontrol et
  static Future<bool> isFavorite(Most movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    String movieJson = jsonEncode({
      'title': movie.title,
      'poster': movie.poster,
      'year': movie.year,
    });
    
    return favorites.contains(movieJson);
  }

  // Tüm favori filmleri getir
  static Future<List<Most>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    return favorites.map((movieJson) {
      Map<String, dynamic> movieMap = jsonDecode(movieJson);
      return Most(
        title: movieMap['title'],
        poster: movieMap['poster'],
        year: movieMap['year'],
      );
    }).toList();
  }

  // Tüm favorileri temizle
  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
} 