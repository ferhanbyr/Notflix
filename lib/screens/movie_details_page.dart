import 'package:flutter/material.dart';
import 'package:notflix/models/most.dart';
import 'package:notflix/models/movie_details.dart';
import 'package:notflix/services/movie_details_service.dart';
import 'package:notflix/services/favorites_service.dart';

class MovieDetailsPage extends StatefulWidget {
  final Most? movie;

  const MovieDetailsPage({super.key, this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieDetailsService _detailsService = MovieDetailsService();
  bool _isLoading = true;
  bool _isFavorite = false;
  Details? _movieDetails;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails();
    _checkFavoriteStatus();
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

  Future<void> _checkFavoriteStatus() async {
    if (widget.movie != null) {
      final isFav = await FavoritesService.isFavorite(widget.movie!);
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.movie == null) return;

    if (_isFavorite) {
      await FavoritesService.removeFromFavorites(widget.movie!);
    } else {
      await FavoritesService.addToFavorites(widget.movie!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Kullanıcıya geri bildirim göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Favorilere eklendi' : 'Favorilerden çıkarıldı',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: _isFavorite ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Most movieData = widget.movie ??
        Most(
            title: "Film Bulunamadı",
            poster: "https://via.placeholder.com/300x450?text=Film+Bulunamadi",
            year: "N/A");

    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? _buildLoadingView()
          : _errorMessage != null
              ? _buildErrorView(_errorMessage!)
              : _buildMovieDetails(movieData),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade900,
            Colors.black,
          ],
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade900,
            Colors.black,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieDetails(Most movie) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(movie),
        SliverToBoxAdapter(
          child: _buildDetailsContent(movie),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(Most movie) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'movie_poster_${movie.title}',
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    movie.year,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      shadows: const [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
              size: 28,
            ),
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsContent(Most movie) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color(0xFF0D0D2B),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_movieDetails != null) ...[
              _buildRatingSection(),
              const SizedBox(height: 24),
              _buildOverviewSection(),
              const SizedBox(height: 24),
              _buildInfoSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            
            Color.fromARGB(255, 9, 184, 227).withOpacity(0.3),
            Color.fromARGB(255, 246, 9, 214).withOpacity(0.3),
          ],
        ),
        border: Border.all(
          color: Colors.purple.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Text(
            "${_movieDetails!.rating}/10",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _movieDetails!.rating / 10,
                minHeight: 12,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 9, 184, 227), Color.fromARGB(255, 246, 9, 214)],
              
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            _movieDetails!.overview,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: Colors.blue.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Movie İnfo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow("Release Date", _movieDetails!.releaseDate),
          const Divider(color: Colors.white24),
          _buildInfoRow("Title", _movieDetails!.title),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
