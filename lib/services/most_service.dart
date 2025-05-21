import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:notflix/models/most.dart';

class MostService {
  final String apiKey = dotenv.env['OMDB_API_KEY'] ?? '';
  final String _baseUrl = 'http://www.omdbapi.com/';

  Future<List<Most>> fetchRandomMovies() async {
    List<String> queries = [
      'Batman', 'Superman', 'Matrix', 'Avengers', 'Iron Man',
      'Oppenheimer', 'Inception', 'Hobbit', 'Star Wars', 'Pirates'
    ];

    List<Most> movies = [];

    for (var query in queries) {
      final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?t=$query&apikey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["Response"] == "True") {
          movies.add(Most.fromJson(jsonData));
        } else {
          debugPrint("API response error: ${jsonData["Error"]}");
        }
      } else {
        debugPrint("HTTP error: ${response.statusCode}");
      }
    }

    return movies;
  }
}
