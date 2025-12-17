import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';

class DetailStoryResponseEntity {
  bool error;
  String message;
  StoryEntity story;

  DetailStoryResponseEntity({
    required this.error,
    required this.message,
    required this.story,
  });
}
