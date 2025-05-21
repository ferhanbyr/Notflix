import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notflix/models/movie_details.dart';

class MovieDetailsService {
  // .env dosyasından API key'i alalım
  final String apiKey = dotenv.env['OMDB_API_KEY'] ?? '';

  // ignore: non_constant_identifier_names
 Future<List<Details>> detailsMovie(String query) async {
  // API anahtarı boş ise hata fırlat
  if (apiKey.isEmpty) {
    throw Exception('OMDB API anahtarı bulunamadı. Lütfen .env dosyasında OMDB_API_KEY değişkeninin olduğundan emin olun.');
  }
  
  final response = await http.get(
    Uri.parse('http://www.omdbapi.com/?i=$query&apikey=$apiKey'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    
    if (data['Response'] == 'True') {
      if (data['Search'] != null) {
        return (data['Search'] as List)
            .map((detailsJson) => Details.fromJson(detailsJson))
            .toList();
      } else {
        throw Exception(data['Error'] ?? 'No movies found');
      }
    } else {
      throw Exception(data['Error'] ?? 'API Error');
    }
  } else {
    throw Exception('Sunucu hatası');
  }
}
 }