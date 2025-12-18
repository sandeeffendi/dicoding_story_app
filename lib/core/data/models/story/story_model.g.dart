// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => _StoryModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  photoUrl: json['photoUrl'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lat: (json['lat'] as num?)?.toDouble() ?? 0,
  lon: (json['lon'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$StoryModelToJson(_StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
    };
