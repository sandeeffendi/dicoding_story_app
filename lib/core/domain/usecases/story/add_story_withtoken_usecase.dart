import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_request_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/repositories/story_repository.dart';

class AddStoryWithtokenUsecase {
  final StoryRepository storyRepository;
  const AddStoryWithtokenUsecase(this.storyRepository);

  Future<AddStoryResponseEntity> call({
    required String token,
    required String description,
    required List<int> photo,
    double? lat,
    double? lon,
  }) {
    return storyRepository.addStoryWithToken(
      token: token,
      storyRequest: AddStoryRequestEntity(
        description: description,
        photo: photo,
        lat: lat,
        lon: lon,
      ),
    );
  }
}
