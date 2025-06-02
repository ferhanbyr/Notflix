import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notflix/models/movie_details.dart';

class MovieDetailsService {
  // .env dosyasından API key'i alalım
  final String apiKey = dotenv.env['OMDB_API_KEY'] ?? '';

 Future<List<Details>> detailsMovie(String query) async {
  // API anahtarı boş ise hata fırlat
  if (apiKey.isEmpty) {
    throw Exception('OMDB API anahtarı bulunamadı. Lütfen .env dosyasında OMDB_API_KEY değişkeninin olduğundan emin olun.');
  }
  
    try {
  final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?t=${Uri.encodeComponent(query)}&apikey=$apiKey'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    
    if (data['Response'] == 'True') {
          // OMDB API tek film detayı döndürür
          return [
            Details(
              title: data['Title'] ?? '',
              overview: data['Plot'] ?? '',
              releaseDate: data['Released'] ?? '',
              rating: data['imdbRating'] != null && data['imdbRating'] != 'N/A' 
                  ? double.tryParse(data['imdbRating']) ?? 0.0 
                  : 0.0,
              posterPath: data['Poster'] != 'N/A' ? data['Poster'] : '',
            )
          ];
        } else {
          throw Exception(data['Error'] ?? 'Film bulunamadı');
        }
      } else {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Film detayları alınırken hata oluştu: $e');
      throw Exception('Film detayları alınırken bir hata oluştu');
  }
}
 }