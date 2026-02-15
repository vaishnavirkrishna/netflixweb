import 'dart:convert';
import 'package:flutter/foundation.dart'; 
import 'package:http/http.dart' as http;
import 'package:netflix/core/constants/api_constants.dart';
import 'package:netflix/data/models/movie.dart';

class TmdbService {
  final http.Client _client;

  TmdbService({http.Client? client}) : _client = client ?? http.Client();

  Uri _buildUri(String endpoint, {Map<String, String>? queryParams}) {
    final params = {'api_key': ApiConstants.apiKey, ...?queryParams};

    final queryString = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final tmdbUrl = 'https://api.themoviedb.org/3$endpoint?$queryString';

    if (kIsWeb) {
      return Uri.parse('https://corsproxy.io/?${Uri.encodeComponent(tmdbUrl)}');
    } else {
      return Uri.parse('https://api.codetabs.com/v1/proxy?quest=$tmdbUrl');
    }
  }
  // 

  Future<Map<String, dynamic>> _get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = _buildUri(endpoint, queryParams: queryParams);
    print('Calling: $uri');

    final response = await _client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    print('Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw Exception('API Error: ${response.statusCode}');
  }

  List<Movie> _parseMovies(Map<String, dynamic> data) {
    final results = data['results'] as List<dynamic>;
    return results
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Movie>> getTrending() async {
    final data = await _get('/trending/movie/week');
    return _parseMovies(data);
  }

  Future<List<Movie>> getTopRated() async {
    final data = await _get('/movie/top_rated');
    return _parseMovies(data);
  }

  Future<List<Movie>> getUpcoming() async {
    final data = await _get('/movie/upcoming');
    return _parseMovies(data);
  }

  Future<Movie> getMovieDetail(int id) async {
    final data = await _get('/movie/$id');
    return Movie.fromJson(data);
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];
    final data = await _get('/search/movie', queryParams: {'query': query});
    return _parseMovies(data);
  }
}
