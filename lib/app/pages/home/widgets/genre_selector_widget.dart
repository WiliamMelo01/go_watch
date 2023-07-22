import 'package:flutter/material.dart';
import 'package:go_watch/app/constants/style.dart';
import 'package:go_watch/app/data/models/genre_model.dart';
import 'package:go_watch/app/store/genre_store.dart';
import 'package:go_watch/app/store/movie_store.dart';
import 'package:skeletons/skeletons.dart';

class GenreSelectorWidget extends StatefulWidget {
  final GenreStore genreStore;
  final MovieStore movieStore;

  const GenreSelectorWidget(
      {Key? key, required this.genreStore, required this.movieStore})
      : super(key: key);

  @override
  State<GenreSelectorWidget> createState() => _GenreSelectorWidgetState();
}

class _GenreSelectorWidgetState extends State<GenreSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          widget.genreStore.error,
          widget.genreStore.isLoading,
          widget.genreStore.state,
          widget.genreStore.selectedGenre
        ]),
        builder: (context, child) {
          if (widget.genreStore.isLoading.value) {
            return SizedBox(
              width: double.infinity,
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 30,
                        width: 70,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          if (widget.genreStore.error.value.isNotEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text("Ocorreu um ao buscar as categorias"),
              ),
            );
          }

          if (widget.genreStore.state.value.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text("Nenhuma categoria encontrada"),
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(
                    parent: BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal)),
                itemCount: widget.genreStore.state.value.length,
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final GenreModel item = widget.genreStore.state.value[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.genreStore.state.value[index].id !=
                          widget.genreStore.selectedGenre.value) {
                        widget.genreStore.selectGenre(item.id);
                        widget.movieStore.getMoviesByGenre(item.id);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: item.id != widget.genreStore.selectedGenre.value
                            ? secondaryColor
                            : Colors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 15,
                        ),
                        child: Center(
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
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
