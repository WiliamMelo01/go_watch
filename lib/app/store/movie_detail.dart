import 'package:flutter/material.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';

class MovieDetailStore {
  final IMovieRepository repository;

  MovieDetailStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<MovieModel> state = ValueNotifier(MovieModel(
    id: 0,
    posterImage: "",
    carouselImage: "",
    title: "",
    description: "",
    genresIds: [],
    releaseDate: "",
  ));

  Future<void> getMovieDetail(int movieId) async {
    isLoading.value = true;
    try {
      final result = await repository.getMovieDetail(movieId);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
