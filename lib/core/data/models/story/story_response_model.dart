import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';

part 'story_response_model.freezed.dart';
part 'story_response_model.g.dart';

@freezed
sealed class StoryResponseModel with _$StoryResponseModel {
  const factory StoryResponseModel({
    required bool error,
    required String message,
    required List<StoryModel> listStory,
  }) = _StoryResponseModel;

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseModelFromJson(json);
}

extension StoryResponseModelMapper on StoryResponseModel {
  ListStoryResponseEntity toEntity() {
    return ListStoryResponseEntity(
      error: error,
      message: message,
      listStory: listStory.map((e) => e.toEntity()).toList(),
    );
  }
}
