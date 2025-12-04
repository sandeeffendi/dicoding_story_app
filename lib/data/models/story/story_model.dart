import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';

class StoryModel extends StoryEntity {
  StoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.photoUrl,
    required super.createdAt,
    required super.lat,
    required super.lon,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photoUrl: json["photoUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    lat: json["lat"]?.toDouble() ?? 1.0,
    lon: json["lon"]?.toDouble() ?? 1.0,
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
