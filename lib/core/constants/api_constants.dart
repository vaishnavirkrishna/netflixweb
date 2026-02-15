class ApiConstants {
  static const String apiKey = '956f62db673d3832e44bdfff8ee25d84';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String backdropBaseUrl = 'https://image.tmdb.org/t/p/original';

  // Endpoints
  static const String trending = '/trending/movie/week';
  static const String topRated = '/movie/top_rated';
  static const String upcoming = '/movie/upcoming';
  static const String search = '/search/movie';

  static String movieDetail(int id) => '/movie/$id';
}
