import 'package:flutter/material.dart';
import 'package:go_watch/app/data/http/client.dart';
import 'package:go_watch/app/data/repositories/genre_repository.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';
import 'package:go_watch/app/pages/home/widgets/carousel.dart';
import 'package:go_watch/app/pages/home/widgets/genre_selector_widget.dart';
import 'package:go_watch/app/pages/home/widgets/header_widget.dart';
import 'package:go_watch/app/pages/home/widgets/movies_by_gender_list.dart';
import 'package:go_watch/app/pages/home/widgets/popular_movies_list.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:go_watch/app/shared/widgets/title_widget.dart';
import 'package:go_watch/app/store/genre_store.dart';
import 'package:go_watch/app/store/movie_store.dart';
import 'package:go_watch/app/store/popular_movie_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GenreStore genreStore =
      GenreStore(repository: GenreRepository(client: HttpClient()));
  final PopularMovieStore popularMovieStore =
      PopularMovieStore(repository: MovieRepository(client: HttpClient()));
  final MovieStore movieStore =
      MovieStore(repository: MovieRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    genreStore.getGenres();
    popularMovieStore.getMovies();
    movieStore.getMoviesByGenre(genreStore.selectedGenre.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 25, left: 15),
        children: [
          Column(
            children: [
              const HeaderWidget(),
              Carousel(popularMovieStore: popularMovieStore),
              const MarginWidget(
                height: 25,
              ),
              const TitleWidget(title: 'Categorias'),
              const MarginWidget(
                height: 15,
              ),
              GenreSelectorWidget(
                  genreStore: genreStore, movieStore: movieStore),
              const MarginWidget(
                height: 25,
              ),
              AnimatedBuilder(
                  animation: Listenable.merge([genreStore.selectedGenre]),
                  builder: (context, index) {
                    final String selectedGenreName;
                    if (genreStore.state.value.isNotEmpty) {
                      selectedGenreName = genreStore.state.value
                          .firstWhere((genre) =>
                              genre.id == genreStore.selectedGenre.value)
                          .name;
                    } else {
                      selectedGenreName = "Ação";
                    }

                    return TitleWidget(title: selectedGenreName);
                  }),
              const MarginWidget(
                height: 15,
              ),
              MoviesListByGenre(movieByGenreStore: movieStore),
              const MarginWidget(
                height: 15,
              ),
              const TitleWidget(title: 'Filmes Populares'),
              const MarginWidget(
                height: 15,
              ),
              PopularMoviesList(popularMovieStore: popularMovieStore),
              const MarginWidget(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
