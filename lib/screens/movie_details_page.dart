import 'package:flutter/material.dart';
import 'package:notflix/models/most.dart';
import 'package:notflix/models/movie_details.dart';
import 'package:notflix/services/movie_details_service.dart';

class MovieDetailsPage extends StatefulWidget {
  final Most? movie;
  
  const MovieDetailsPage({super.key, this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieDetailsService _detailsService = MovieDetailsService();
  bool _isLoading = true;
  Details? _movieDetails;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails();
  }

  Future<void> _loadMovieDetails() async {
    if (widget.movie == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Film bilgisi bulunamadı";
      });
      return;
    }

    try {
      final details = await _detailsService.detailsMovie(widget.movie!.title);
      if (details.isNotEmpty) {
        setState(() {
          _movieDetails = details.first;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = "Film detayları bulunamadı";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Hata: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Most movieData = widget.movie ?? Most(
      title: "Film Bulunamadı",
      poster: "https://via.placeholder.com/300x450?text=Film+Bulunamadi",
      year: "N/A"
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(movieData.title),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _buildMovieDetails(movieData),
    );
  }

  Widget _buildMovieDetails(Most movie) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            movie.poster,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Yıl: ${movie.year}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                if (_movieDetails != null) ...[
                  const SizedBox(height: 16),
                  const Text(
                    "Özet:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _movieDetails!.overview,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Puan: ${_movieDetails!.rating}/10",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Yayın Tarihi: ${_movieDetails!.releaseDate}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}