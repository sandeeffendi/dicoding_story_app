import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/story_repository.dart';

class GetStoryByIdUsecase {
  final StoryRepository storyRepository;
  const GetStoryByIdUsecase(this.storyRepository);

  Future<DetailStoryResponseEntity> call({
    required String token,
    required String id,
  }) {
    return storyRepository.getStoryById(token: token, id: id);
  }
}