// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddStoryResponseModel _$AddStoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _AddStoryResponseModel(
  error: json['error'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$AddStoryResponseModelToJson(
  _AddStoryResponseModel instance,
) => <String, dynamic>{'error': instance.error, 'message': instance.message};
