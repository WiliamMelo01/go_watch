import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_watch/app/data/http/client.dart';
import 'package:go_watch/app/data/models/movie_model.dart';

abstract class IMovieRepository {
  Future<List<MovieModel>> getMoviesByGenre(int genreId);
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getMoviesByTitle(String title);
  Future<MovieModel> getMovieDetail(int id);
}

class MovieRepository implements IMovieRepository {
  final IHttpClient client;

  MovieRepository({required this.client});

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final response = await client.get(
        "http://api.themoviedb.org/3/discover/movie?with_genres=$genreId&language=pt-BR",
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['THE_MOVIE_DB_ACCESS_TOKEN']}'
        });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final List<MovieModel> movieList = [];

      body['results'].map((item) {
        final MovieModel movie = MovieModel.fromJson(item);

        movieList.add(movie);
      }).toList();

      return movieList;
    }

    if (response.statusCode == 401) {
      throw Exception("Invalid authentication");
    }

    if (response.statusCode == 404) {
      throw Exception("Invalid Url");
    }

    throw Exception("Could not fetch genres");
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
        "https://api.themoviedb.org/3/movie/popular?language=pt-BR",
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['THE_MOVIE_DB_ACCESS_TOKEN']}'
        });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final List<MovieModel> movieList = [];

      body['results'].map((item) {
        final MovieModel movie = MovieModel.fromJson(item);

        movieList.add(movie);
      }).toList();

      return movieList;
    }

    if (response.statusCode == 401) {
      throw Exception("Invalid authentication");
    }

    if (response.statusCode == 404) {
      throw Exception("Invalid Url");
    }

    throw Exception("Could not fetch genres");
  }

  @override
  Future<List<MovieModel>> getMoviesByTitle(String title) async {
    final response = await client.get(
        "https://api.themoviedb.org/3/search/movie?query=${title.replaceAll(" ", "+")}&language=pt-BR",
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['THE_MOVIE_DB_ACCESS_TOKEN']}'
        });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final List<MovieModel> movieList = [];

      body['results'].map((item) {
        final MovieModel movie = MovieModel.fromJson(item);

        movieList.add(movie);
      }).toList();

      return movieList;
    }

    if (response.statusCode == 401) {
      throw Exception("Invalid authentication");
    }

    if (response.statusCode == 404) {
      throw Exception("Invalid Url");
    }

    throw Exception("Could not fetch genres");
  }

  @override
  Future<MovieModel> getMovieDetail(int id) async {
    final response = await client.get(
        "http://api.themoviedb.org/3/movie/$id?language=pt-BR",
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['THE_MOVIE_DB_ACCESS_TOKEN']}'
        });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final MovieModel movie = MovieModel.fromJson(body);

      return movie;
    }

    if (response.statusCode == 401) {
      throw Exception("Invalid authentication");
    }

    if (response.statusCode == 404) {
      throw Exception("Invalid Url");
    }

    throw Exception("Could not fetch genres");
  }
}
