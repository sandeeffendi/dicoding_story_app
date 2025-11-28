import 'package:intermediate_first_submission/domain/enitities/story/list_story_entity.dart';

class ListStoryModel extends ListStoryEntity {
  ListStoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.photoUrl,
    required super.createdAt,
    required super.lat,
    required super.lon,
  });

  factory ListStoryModel.fromJson(Map<String, dynamic> json) => ListStoryModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photoUrl: json["photoUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photoUrl": photoUrl,
    "createdAt": createdAt.toIso8601String(),
    "lat": lat,
    "lon": lon,
  };
}
