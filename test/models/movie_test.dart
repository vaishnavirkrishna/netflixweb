import 'package:flutter_test/flutter_test.dart';
import 'package:netflix/data/models/movie.dart';

void main() {
  group('Movie.fromJson', () {
    test('parses all fields correctly', () {
      final json = {
        'id': 550,
        'title': 'Fight Club',
        'overview': 'An insomniac office worker forms a fight club.',
        'release_date': '1999-10-15',
        'vote_average': 8.4,
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 550);
      expect(movie.title, 'Fight Club');
      expect(movie.overview, 'An insomniac office worker forms a fight club.');
      expect(movie.releaseDate, '1999-10-15');
      expect(movie.voteAverage, 8.4);
      expect(movie.posterPath, '/poster.jpg');
    });

    test('handles null poster_path gracefully', () {
      final json = {
        'id': 1,
        'title': 'Test Movie',
        'overview': '',
        'release_date': '2024-01-01',
        'vote_average': 7.0,
        'poster_path': null,
        'backdrop_path': null,
      };

      final movie = Movie.fromJson(json);

      expect(movie.posterPath, isNull);
      expect(movie.fullPosterUrl, ''); 
    });

    test('handles missing title gracefully', () {
      final json = {
        'id': 2,
        'overview': '',
        'release_date': '2024-01-01',
        'vote_average': 5.0,
      };

      final movie = Movie.fromJson(json);
      expect(movie.title, 'Unknown'); // your fallback value
    });

    test('fullPosterUrl builds correct URL', () {
      final json = {
        'id': 1,
        'title': 'Test',
        'overview': '',
        'release_date': '2024-01-01',
        'vote_average': 7.0,
        'poster_path': '/abc123.jpg',
      };

      final movie = Movie.fromJson(json);
      expect(movie.fullPosterUrl, 'https://image.tmdb.org/t/p/w500/abc123.jpg');
    });
  });
}
