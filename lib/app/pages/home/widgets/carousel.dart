import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_watch/app/store/popular_movie_store.dart';
import 'package:skeletons/skeletons.dart';

class Carousel extends StatelessWidget {
  final PopularMovieStore popularMovieStore;

  const Carousel({Key? key, required this.popularMovieStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      width: double.infinity,
      height: 140,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: AnimatedBuilder(
            animation: Listenable.merge([
              popularMovieStore.isLoading,
              popularMovieStore.error,
              popularMovieStore.state,
            ]),
            builder: (context, index) {
              if (popularMovieStore.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const SkeletonLine(
                      style: SkeletonLineStyle(
                        width: double.infinity,
                        height: 140,
                      ),
                    ),
                  ),
                );
              }

              if (popularMovieStore.error.value.isNotEmpty) {
                return const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text("Ocorreu um ao carregar o carrousel"),
                  ),
                );
              }

              if (popularMovieStore.state.value.isEmpty) {
                return const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text("Nenhuma item foi encontrado"),
                  ),
                );
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 140,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                  ),
                  items: popularMovieStore.state.value.map((movie) {
                    return Container(
                      width: double.infinity,
                      height: 140,
                      margin: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w1280${movie.carouselImage}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
