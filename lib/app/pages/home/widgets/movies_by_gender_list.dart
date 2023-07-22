import 'package:flutter/material.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/pages/detail/detail_page.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:go_watch/app/store/movie_store.dart';
import 'package:skeletons/skeletons.dart';

class MoviesListByGenre extends StatelessWidget {
  final MovieStore movieByGenreStore;

  const MoviesListByGenre({Key? key, required this.movieByGenreStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToDetailPage(int movieId) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPage(
                movieId: movieId,
              )));
    }

    return AnimatedBuilder(
        animation: Listenable.merge([
          movieByGenreStore.error,
          movieByGenreStore.isLoading,
          movieByGenreStore.state,
        ]),
        builder: (context, index) {
          if (movieByGenreStore.isLoading.value) {
            return SizedBox(
              width: double.infinity,
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (context, index) => const MarginWidget(
                  width: 15,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 180,
                        width: 120,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          if (movieByGenreStore.error.value.isNotEmpty) {
            return Center(
              child: Text(
                movieByGenreStore.error.value,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (movieByGenreStore.state.value.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum filme foi encontrado",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movieByGenreStore.state.value.length,
                separatorBuilder: (context, index) => const MarginWidget(
                  width: 15,
                ),
                itemBuilder: (context, index) {
                  final MovieModel movie = movieByGenreStore.state.value[index];
                  return GestureDetector(
                    onTap: () => goToDetailPage(movie.id),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 180,
                        child: Image.network(
                            "https://image.tmdb.org/t/p/w500${movie.posterImage}"),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
