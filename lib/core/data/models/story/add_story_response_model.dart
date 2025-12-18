import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_response_entity.dart';

part 'add_story_response_model.freezed.dart';
part 'add_story_response_model.g.dart';

@freezed
sealed class AddStoryResponseModel with _$AddStoryResponseModel {
  const factory AddStoryResponseModel({
    required bool error,
    required String message,
  }) = _AddStoryResponseModel;

  factory AddStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddStoryResponseModelFromJson(json);
}

extension AddStoryResponseModelMapper on AddStoryResponseModel {
  AddStoryResponseEntity toEntity() {
    return AddStoryResponseEntity(error: error, message: message);
  }
}
