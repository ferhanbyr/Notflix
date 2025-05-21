class Categories {
  final String title;
  final String poster;

  Categories({required this.title, required this.poster});

 

  static List<Categories> getCategories() {
    return [
      Categories(title: 'Romantic', poster: 'lib/assets/poster/anime.png'),
      Categories(title: 'Action', poster: 'lib/assets/poster/action.png'),
      Categories(title: 'Comedy', poster: 'lib/assets/poster/anime.png'),
      Categories(title: 'Drama', poster: 'lib/assets/poster/action.png'),
      Categories(title: 'Horror', poster: 'lib/assets/poster/action.png'),
      Categories(title: 'Anime', poster: 'lib/assets/poster/anime.png'),
    ];
  }
}
