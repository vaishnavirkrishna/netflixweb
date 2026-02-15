import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/data/models/movie.dart';
import 'package:netflix/data/services/tmdb_service.dart';

// Service provider
final tmdbServiceProvider = Provider<TmdbService>((ref) => TmdbService());

// Trending movies
final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) {
  return ref.watch(tmdbServiceProvider).getTrending();
});

// Top rated movies
final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) {
  return ref.watch(tmdbServiceProvider).getTopRated();
});

// Upcoming movies
final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) {
  return ref.watch(tmdbServiceProvider).getUpcoming();
});

// Movie detail
final movieDetailProvider = FutureProvider.family<Movie, int>((ref, id) {
  return ref.watch(tmdbServiceProvider).getMovieDetail(id);
});