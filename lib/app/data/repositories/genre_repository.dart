import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_watch/app/data/http/client.dart';
import 'package:go_watch/app/data/models/genre_model.dart';

abstract class IGenreRepository {
  Future<List<GenreModel>> getGenres();
}

class GenreRepository implements IGenreRepository {
  final IHttpClient client;

  GenreRepository({required this.client});

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await client.get(
        "https://api.themoviedb.org/3/genre/movie/list?language=pt-BR",
        <String, String>{
          'Authorization': 'Bearer ${dotenv.env['THE_MOVIE_DB_ACCESS_TOKEN']}'
        });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final List<GenreModel> genreList = [];

      body['genres'].map((item) {
        final GenreModel genre = GenreModel.fromJson(item);

        genreList.add(genre);
      }).toList();

      return genreList;
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
