import 'package:intermediate_first_submission/domain/enitities/story/list_story_entity.dart';

class StoryResponseEntity {
  bool error;
  String message;
  ListStoryEntity listStory;

  StoryResponseEntity({
    required this.error,
    required this.message,
    required this.listStory,
  });
}
