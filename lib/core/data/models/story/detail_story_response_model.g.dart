// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetailStoryResponseModel _$DetailStoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _DetailStoryResponseModel(
  error: json['error'] as bool,
  message: json['message'] as String,
  story: StoryModel.fromJson(json['story'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DetailStoryResponseModelToJson(
  _DetailStoryResponseModel instance,
) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
  'story': instance.story,
};
