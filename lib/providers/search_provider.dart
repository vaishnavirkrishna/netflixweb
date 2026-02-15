import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:netflix/data/models/movie.dart';
import 'package:netflix/providers/movies_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Movie>>((ref) {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return Future.value([]);
  return ref.watch(tmdbServiceProvider).searchMovies(query);
});
