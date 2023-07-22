import 'package:go_watch/app/data/models/genre_model.dart';

class MovieModel {
  final int id;
  final String posterImage;
  final String carouselImage;
  final String title;
  final String description;
  final List<int> genresIds;
  final List<GenreModel>? genres;
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.posterImage,
    required this.carouselImage,
    required this.title,
    required this.description,
    required this.genresIds,
    required this.releaseDate,
    this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
        id: map["id"],
        title: map["title"] ?? "NO Title Found",
        description: map["overview"] ?? "",
        carouselImage: map["backdrop_path"] ?? "",
        posterImage: map["poster_path"] ?? "",
        genresIds: List<int>.from(
          map["genre_ids"] ?? [],
        ),
        genres: (map["genres"] as List<dynamic>?)
            ?.map((genre) => GenreModel.fromJson(genre))
            .toList(),
        releaseDate: map["release_date"] ?? "????");
  }

  isEmpty() {
    return carouselImage.isEmpty &&
        description.isEmpty &&
        posterImage.isEmpty &&
        genresIds.isEmpty &&
        id == 0 &&
        title.isEmpty &&
        releaseDate.isEmpty;
  }
}
