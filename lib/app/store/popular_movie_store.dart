import 'package:flutter/material.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';

class PopularMovieStore {

  final IMovieRepository repository;

  PopularMovieStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<MovieModel>> state = ValueNotifier([]);

  Future<void> getMovies()async{

    isLoading.value = true;

    try{
      final result = await repository.getPopularMovies();
      state.value = result;
    }catch(e){
      error.value = e.toString();
    }

    isLoading.value = false;

  }

}