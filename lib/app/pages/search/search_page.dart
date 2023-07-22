import 'package:flutter/material.dart';
import 'package:go_watch/app/constants/style.dart';
import 'package:go_watch/app/data/http/client.dart';
import 'package:go_watch/app/data/models/movie_model.dart';
import 'package:go_watch/app/data/repositories/genre_repository.dart';
import 'package:go_watch/app/data/repositories/movie_repository.dart';
import 'package:go_watch/app/pages/detail/detail_page.dart';
import 'package:go_watch/app/pages/search/widget/loading.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:go_watch/app/store/genre_store.dart';
import 'package:go_watch/app/store/search_movies_store.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchMovieStore searchMovieStore =
      SearchMovieStore(repository: MovieRepository(client: HttpClient()));
  final GenreStore genreStore =
      GenreStore(repository: GenreRepository(client: HttpClient()));
  final FocusNode inputFocusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  unFocusInput() {
    inputFocusNode.unfocus();
  }

  searchMovie() {
    if (textEditingController.text.isNotEmpty) {
      searchMovieStore.searchMovieByTitle(textEditingController.value.text);
      unFocusInput();
    }
  }

  @override
  void initState() {
    super.initState();
    genreStore.getGenres();
    searchMovieStore.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    goToDetailPage(int movieId) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPage(
                movieId: movieId,
              )));
    }

    return SafeArea(
      child: GestureDetector(
        onTap: unFocusInput,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              const MarginWidget(
                height: 25,
              ),
              TextField(
                focusNode: inputFocusNode,
                controller: textEditingController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: searchMovie,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: secondaryColor,
                  hintText: "Pesquise por títulos",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const MarginWidget(
                height: 40,
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: Listenable.merge(
                    [
                      searchMovieStore.error,
                      searchMovieStore.isLoading,
                      searchMovieStore.state,
                      genreStore.isLoading
                    ],
                  ),
                  builder: (context, index) {
                    if (searchMovieStore.isLoading.value ||
                        genreStore.isLoading.value) {
                      return const Loading();
                    }

                    if (searchMovieStore.error.value.isNotEmpty) {
                      return Center(
                        child: Text(searchMovieStore.error.value.toString()),
                      );
                    }

                    if (searchMovieStore.state.value.isEmpty) {
                      return const Center(
                        child: Text("Nenhum filme foi encontrado."),
                      );
                    }

                    return ListView.separated(
                      itemCount: searchMovieStore.state.value.length,
                      separatorBuilder: (context, index) => const MarginWidget(
                        height: 30,
                      ),
                      itemBuilder: (context, index) {
                        final MovieModel item =
                            searchMovieStore.state.value[index];
                        return GestureDetector(
                          onTap: () => goToDetailPage(item.id),
                          child: Container(
                            margin:
                                index == searchMovieStore.state.value.length - 1
                                    ? const EdgeInsets.only(bottom: 30)
                                    : EdgeInsets.zero,
                            width: double.infinity,
                            height: 190,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 180,
                                    width: 120,
                                    child: Image.network(item
                                            .posterImage.isNotEmpty
                                        ? "https://image.tmdb.org/t/p/w500${item.posterImage}"
                                        : "https://res.cloudinary.com/dblxw7p0c/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1689993546/No-Image-Placeholder.svg_otu95v.jpg?_s=public-apps"),
                                  ),
                                ),
                                const MarginWidget(
                                  width: 25,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      item.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const MarginWidget(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        int maxLines =
                                            ((constraints.maxHeight / 16) * 0.8)
                                                .floor();
                                        maxLines = maxLines > 0 ? maxLines : 1;
                                        return Text(
                                          item.description.isNotEmpty
                                              ? item.description
                                              : "No description available for this movie",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: maxLines,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 25,
                                      child: item.genresIds.isNotEmpty
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                      horizontal: 15,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        genreStore.state.value
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    item.genresIds[
                                                                        0])
                                                            .name,
                                                        style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.8),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                      horizontal: 15,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        item.releaseDate
                                                                .isNotEmpty
                                                            ? item.releaseDate
                                                                .substring(0, 4)
                                                            : "????",
                                                        style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
