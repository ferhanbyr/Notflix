class Details {
  final String title;
  final String overview;
  final String releaseDate;
  final double rating;
  final String posterPath;

  Details({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.posterPath,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      title: json['Title'] ?? '',
      overview: json['Plot'] ?? '',
      releaseDate: json['Released'] ?? '',
      rating: json['imdbRating'] != null && json['imdbRating'] != 'N/A' 
          ? double.tryParse(json['imdbRating']) ?? 0.0 
          : 0.0,
      posterPath: json['Poster'] ?? '',
    );
  }
}