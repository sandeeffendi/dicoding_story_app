import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';

class ListStoryResponseEntity {
  bool error;
  String message;
  List<StoryEntity> listStory;

  ListStoryResponseEntity({
    required this.error,
    required this.message,
    required this.listStory,
  });
}
