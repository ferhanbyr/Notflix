import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notflix/models/movie.dart';

class DatabaseService {
  final String apiKey = dotenv.env['OMDB_API_KEY'] ?? '';

  // ignore: non_constant_identifier_names
 Future<List<Movie>> searchMovies(String query) async {
  final response = await http.get(
    Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    
    if (data['Response'] == 'True') {
      if (data['Search'] != null) {
        return (data['Search'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
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