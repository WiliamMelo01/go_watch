import 'package:flutter/material.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';

class SearchMovieStore {

  final IMovieRepository repository;

  SearchMovieStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<MovieModel>> state = ValueNotifier([]);

  Future<void> getPopularMovies()async{

    isLoading.value = true;

    try{
      final result = await repository.getPopularMovies();
      state.value = result;
    }catch(e){
      error.value = e.toString();
    }

    isLoading.value = false;

  }

  Future<void> searchMovieByTitle(String title)async{
    isLoading.value = true;

    try{
      final result = await repository.getMoviesByTitle(title);
      state.value = result;
    }catch(e){
      error.value = e.toString();
    }

    isLoading.value = false;
  }

}