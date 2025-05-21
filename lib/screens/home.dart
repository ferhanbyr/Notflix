import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:notflix/models/categories.dart';
import 'package:notflix/models/most.dart';
import 'package:notflix/models/movie.dart';
import 'package:notflix/screens/movie_details_page.dart';
import 'package:notflix/screens/search.dart';
import 'package:notflix/services/most_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class MovieCard extends StatelessWidget {
  final Most movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(movie.poster),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Movie>>? _futureMovies;
  List<Most> _randomMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

 void fetchMovies() async {
  final movies = await MostService().fetchRandomMovies();
  setState(() {
    _randomMovies = movies;
    _isLoading = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.black,
  title: ShaderMask(
    shaderCallback: (Rect bounds) {
      return const LinearGradient(
        colors: <Color>[
           Color.fromARGB(255, 9, 246, 207),
          Color.fromARGB(255, 9, 184, 227),
          Color.fromARGB(255, 246, 9, 214),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    child: const Text(
      "NOTFLIX",
      style: TextStyle(
        fontFamily: "Poppins",
        letterSpacing: 1.5,
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.white, // bu color gerekli ama ShaderMask ile değişir
      ),
    ),
  ),
),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*Container(
              margin: const EdgeInsets.only(top: 10.0, left: 16.0),
              child: const Text(
                "What do you want to watch?",
                style: TextStyle(
                  color: Color.fromARGB(255, 209, 209, 209),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),*/
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              padding: const EdgeInsets.all(3), // Border kalınlığı gibi davranır
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                     Color.fromARGB(255, 9, 246, 207),
          Color.fromARGB(255, 9, 184, 227),
          Color.fromARGB(255, 246, 9, 214),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                        child: const Text('Search for movies...',
                          style:  TextStyle(color: Colors.white),
                         
                        ),
                      ),
                    
                    ),
                    Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 209, 209, 209),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Catogories",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: List.generate(10, (index) {
                  final category = Categories.getCategories()[
                      index % Categories.getCategories().length];
        
                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 160,
                    height: 190,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // 1. Dalgalı Arka Plan
                        Positioned(
                          top: 70,
                          right: 0,
                          left: 0,
                          child: ClipPath(
                            clipper: WaveClipperTwo(flip: true, reverse: true),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors
                                    .primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                category.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        // 2. Üstte Taşan Görsel
                        Positioned(
                          top: -10, // Taşma efekti
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              category.poster,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text(
          "Most Watched",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 252, 252),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
            ),
            const SizedBox(height: 16),
        
            _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: List.generate(
                  (_randomMovies.length / 2).ceil(),
                  (rowIndex) {
                    int firstIndex = rowIndex * 2;
                    int secondIndex = firstIndex + 1;
                      
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsPage(movie: _randomMovies[firstIndex]),
                                  ),
                                );
                              },
                              child: MovieCard(movie: _randomMovies[firstIndex]),
                            ),
                          ),
                          const SizedBox(width: 16),
                          if (secondIndex < _randomMovies.length)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsPage(movie: _randomMovies[secondIndex]),
                                    ),
                                  );
                                },
                                child: MovieCard(movie: _randomMovies[secondIndex]),
                              ),
                            )
                          else
                            const Spacer(), // Eşit yükseklik sağlamak için
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),/*
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
                              return ListTile(
                                leading: Image.network(
                                  movie.poster,
                                  width: 70,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                                title: Text(movie.title),
                                subtitle: Text(movie.year),
                              );
                            },
                          );
                        }
                      },
                    ),
            ),*/
          ],
        ),
      ),
    );
  }
}
