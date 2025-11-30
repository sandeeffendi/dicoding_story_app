import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';

abstract class StoryRepository {
  // get all story
  Future<ListStoryResponseEntity> getAllStory({required String token});

  // get story by id
  Future<DetailStoryResponseEntity> getStoryById({
    required String token,
    required String id,
  });
}
