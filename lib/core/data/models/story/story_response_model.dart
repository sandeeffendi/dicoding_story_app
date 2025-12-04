import 'package:intermediate_first_submission/core/data/models/story/story_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';

class ListStoryResponseModel extends ListStoryResponseEntity {
  ListStoryResponseModel({
    required super.error,
    required super.message,
    required super.listStory,
  });

  factory ListStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      ListStoryResponseModel(
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
