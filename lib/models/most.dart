import 'package:notflix/models/movie.dart';

class Most {
  final String title;
  final String poster;
  final String year;

  Most({required this.title, required this.poster, required this.year});

  factory Most.fromJson(Map<String, dynamic> json) {
    return Most(
      title: json['Title'] ?? 'Unknown',
      poster: json['Poster'] ?? '',
      year: json['Year'] ?? 'N/A',
    );
  }
  
  // Most nesnesini Movie nesnesine dönüştüren metot
  Movie toMovie() {
    return Movie(
      title: this.title,
      poster: this.poster,
      year: this.year,
    );
  }
}
