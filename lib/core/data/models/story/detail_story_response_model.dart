import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/detail_story_response_entity.dart';

part 'detail_story_response_model.freezed.dart';
part 'detail_story_response_model.g.dart';

@freezed
sealed class DetailStoryResponseModel with _$DetailStoryResponseModel {
  const factory DetailStoryResponseModel({
    required bool error,
    required String message,
    required StoryModel story,
  }) = _DetailStoryResponseModel;

  factory DetailStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseModelFromJson(json);
}

extension DetailStoryResponseMapper on DetailStoryResponseModel {
  DetailStoryResponseEntity toEntity() {
    return DetailStoryResponseEntity(
      error: error,
      message: message,
      story: story.toEntity(),
    );
  }
}
