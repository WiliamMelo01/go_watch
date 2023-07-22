class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.name, required this.id});

  factory GenreModel.fromJson(Map<String, dynamic> map) {
    return GenreModel(name: map["name"], id: map["id"]);
  }
}
