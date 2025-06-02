import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:notflix/models/movie.dart';
import 'package:notflix/models/most.dart';
import 'package:notflix/screens/movie_details_page.dart';
import 'package:notflix/services/database_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Movie>>? _futureMovies;

  void _searchMovies(String value) {
    final query = _controller.text;
    if (query.isNotEmpty) {
      setState(() {
        _futureMovies = DatabaseService().searchMovies(query);
      });
    }
  }

  void _navigateToMovieDetails(Movie movie) {
    // Movie nesnesini Most nesnesine dönüştür
    Most movieAsMost = Most(
      title: movie.title,
      poster: movie.poster,
      year: movie.year,
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(movie: movieAsMost),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search",
            style: TextStyle(
                color: Color.fromARGB(255, 210, 210, 211),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              padding:
                  const EdgeInsets.all(3), // Border kalınlığı gibi davranır
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.purple,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 41, 56, 188).withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 7),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _searchMovies(value);
                          } else {
                            setState(() {
                              _futureMovies =
                                  null; // Arama kutusu boşsa listeyi temizle
                            });
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.white),
                      onPressed: () {
                        // Sesli arama işlevi buraya eklenebilir
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _futureMovies == null
                ? const Center(child: Text("Film araması yapın"))
                : FutureBuilder<List<Movie>>(
                    future: _futureMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Hata: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Sonuç bulunamadı."));
                      } else {
                        final movies = snapshot.data!;
                        return ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return InkWell(
                              onTap: () => _navigateToMovieDetails(movie),
                              child: ListTile(
                                leading: Hero(
                                  tag: 'movie_poster_${movie.title}',
                                  child: Image.network(
                                movie.poster,
                                width: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                                ),
                              title: Text(movie.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(movie.year,
                                  style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.bold)),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
