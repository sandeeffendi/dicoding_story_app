import 'package:intermediate_first_submission/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';

class StoryResponseModel extends StoryResponseEntity {
  StoryResponseModel({
    required super.error,
    required super.message,
    required super.listStory,
  });

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      StoryResponseModel(
        error: json["error"],
        message: json["message"],
        listStory: (json["listStory"] as List)
            .map((item) => StoryModel.fromJson(item))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "listStory": listStory
        .map((story) => (story as StoryModel).toJson())
        .toList(),
  };
}
