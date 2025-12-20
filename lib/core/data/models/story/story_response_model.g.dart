// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryResponseModel _$StoryResponseModelFromJson(Map<String, dynamic> json) =>
    _StoryResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryResponseModelToJson(_StoryResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
