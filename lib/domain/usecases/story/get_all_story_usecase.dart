import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/story_repository.dart';

class GetAllStoryUsecase {
  final StoryRepository storyRepository;
  const GetAllStoryUsecase(this.storyRepository);

  Future<StoryResponseEntity> call({required String token}) {
    return storyRepository.getAllStory(token: token);
  }
}
