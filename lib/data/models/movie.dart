import 'package:netflix/core/constants/api_constants.dart';

class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Unknown',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      overview: json['overview'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
  
  String get fullPosterUrl => posterPath != null
      ? '${ApiConstants.imageBaseUrl}$posterPath'
      : '';
      
  String get fullBackdropUrl => backdropPath != null
      ? '${ApiConstants.backdropBaseUrl}$backdropPath'
      : '';
}