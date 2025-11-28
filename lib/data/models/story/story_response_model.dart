import 'package:intermediate_first_submission/data/models/story/list_story_model.dart';
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
        listStory: ListStoryModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "listStory": ListStoryModel,
  };
}
