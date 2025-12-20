import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';

part 'story_response_model.freezed.dart';
part 'story_response_model.g.dart';

@freezed
sealed class ListStoryResponseModel with _$ListStoryResponseModel {
  const factory ListStoryResponseModel({
    required bool error,
    required String message,
    required List<StoryModel> listStory,
  }) = _StoryResponseModel;

  factory ListStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ListStoryResponseModelFromJson(json);
}

extension StoryResponseModelMapper on ListStoryResponseModel {
  ListStoryResponseEntity toEntity() {
    return ListStoryResponseEntity(
      error: error,
      message: message,
      listStory: listStory.map((e) => e.toEntity()).toList(),
    );
  }
}
