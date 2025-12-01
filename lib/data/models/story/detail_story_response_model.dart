import 'package:intermediate_first_submission/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';

class DetailStoryResponseModel extends DetailStoryResponseEntity {
  DetailStoryResponseModel({
    required super.error,
    required super.message,
    required super.story,
  });

  factory DetailStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailStoryResponseModel(
        error: json["error"],
        message: json["message"],
        story: StoryModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "story": story,
  };
}
