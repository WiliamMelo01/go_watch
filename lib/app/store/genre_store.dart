import 'package:flutter/material.dart';
import 'package:go_watch/app/data/models/genre_model.dart';
import 'package:go_watch/app/data/repositories/genre_repository.dart';

class GenreStore {
  final IGenreRepository repository;

  GenreStore({required this.repository});


  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<GenreModel>> state = ValueNotifier([]);
  // Gênero selecionado por padrão é ação ID 28
  final ValueNotifier<int> selectedGenre = ValueNotifier<int>(28);


  Future<void> getGenres() async {
    isLoading.value = true;

    try {
      final result = await repository.getGenres();
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  selectGenre(int index){
    selectedGenre.value = index;
  }

}
