import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';

abstract class StoryRepository {
  Future<StoryResponseEntity> getAllStory({required String token});
}
