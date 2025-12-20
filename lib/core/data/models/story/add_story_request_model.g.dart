// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_story_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddStoryRequestModel _$AddStoryRequestModelFromJson(
  Map<String, dynamic> json,
) => _AddStoryRequestModel(
  description: json['description'] as String,
  photo: (json['photo'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$AddStoryRequestModelToJson(
  _AddStoryRequestModel instance,
) => <String, dynamic>{
  'description': instance.description,
  'photo': instance.photo,
};
