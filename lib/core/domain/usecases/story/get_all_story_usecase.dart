import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/repositories/story_repository.dart';

class GetAllStoryUsecase {
  final StoryRepository storyRepository;
  const GetAllStoryUsecase(this.storyRepository);

  Future<ListStoryResponseEntity> call({
    required String token,
    required String size,
    required String page,
  }) {
    return storyRepository.getAllStory(token: token, size: size, page: page);
  }
}
