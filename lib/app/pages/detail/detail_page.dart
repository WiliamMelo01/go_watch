import 'package:flutter/material.dart';
import 'package:go_watch/app/constants/style.dart';
import 'package:go_watch/app/data/http/client.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';
import 'package:go_watch/app/pages/detail/widgets/loading_widget.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:go_watch/app/store/movie_detail.dart';

class DetailPage extends StatefulWidget {
  final int movieId;

  const DetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MovieDetailStore movieDetailStore =
      MovieDetailStore(repository: MovieRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    movieDetailStore.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {

    goToPreviousPage(){
      Navigator.of(context).pop();
    }


    return Scaffold(
      backgroundColor: primaryColor,
      body: AnimatedBuilder(
          animation: Listenable.merge([
            movieDetailStore.error,
            movieDetailStore.isLoading,
            movieDetailStore.state
          ]),
          builder: (context, index) {
            if (movieDetailStore.isLoading.value) {
              return const LoadingWidget();
            }

            if (movieDetailStore.error.value.isNotEmpty) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Text(
                    movieDetailStore.error.value,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (movieDetailStore.state.value.isEmpty()) {
              return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: const Text(
                      "Não foi encontrado nenhum detalhe sobre este filme.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
              );
            } else {
              final MovieModel movie = movieDetailStore.state.value;
              return Stack(
                children: [
                  ListView(
                    children: [
                      Image.network(movie.posterImage.isNotEmpty
                          ? "https://image.tmdb.org/t/p/w500${movie.posterImage}"
                          : "https://res.cloudinary.com/dblxw7p0c/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1689993546/No-Image-Placeholder.svg_otu95v.jpg?_s=public-apps"),
                      const MarginWidget(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ),
                            const MarginWidget(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    child: Center(
                                      child: Text(
                                        movie.genres![0].name,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const MarginWidget(
                                  width: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    child: Center(
                                      child: Text(
                                        movie.releaseDate.substring(0, 4),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const MarginWidget(
                              height: 20,
                            ),
                            const Text(
                              "Sinopse",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const MarginWidget(
                              height: 15,
                            ),
                            Text(
                              movie.description.isNotEmpty
                                  ? movie.description
                                  : "Não foi encontrado nenhuma sinopse para este filme.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            const MarginWidget(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: MaterialButton(
                        padding: const EdgeInsets.all(0),
                        color: Colors.black.withOpacity(0.005),
                        onPressed: goToPreviousPage,
                        child: Transform.translate(
                          offset: const Offset(3.0, 0),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
