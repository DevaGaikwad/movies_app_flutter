import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

class ApiService {
  static const String API_KEY = '909594533c98883408adef5d56143539';
  static const String API_BASE_URL = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$API_BASE_URL/movie/popular?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(data['results'].map((movie) => Movie.fromJson(movie)));
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getLatestMovies() async {
    final response = await http.get(Uri.parse('$API_BASE_URL/movie/latest?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(data['results'].map((movie) => Movie.fromJson(movie)));
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
