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
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      rating: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
    );
  }
}