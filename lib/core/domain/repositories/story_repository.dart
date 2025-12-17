import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_request_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';

abstract class StoryRepository {
  // get all story
  Future<ListStoryResponseEntity> getAllStory({
    required String token,
    required String size,
    required String page,
  });

  // get story by id
  Future<DetailStoryResponseEntity> getStoryById({
    required String token,
    required String id,
  });

  // post story with token
  Future<AddStoryResponseEntity> addStoryWithToken({
    required String token,
    required AddStoryRequestEntity storyRequest,
  });
}
