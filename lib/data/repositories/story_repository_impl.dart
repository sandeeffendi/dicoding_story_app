import 'package:intermediate_first_submission/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  final MainRemoteDatasource remoteDatasource;
  const StoryRepositoryImpl(this.remoteDatasource);

  @override
  Future<StoryResponseEntity> getAllStory({required String token}) async {
    final response = await remoteDatasource.getAllStory(token: token);

    return StoryResponseEntity(
      error: response.error,
      message: response.message,
      listStory: response.listStory,
    );
  }

  @override
  Future<DetailStoryResponseEntity> getStoryById({
    required String token,
    required String id,
  }) async {
    final response = await remoteDatasource.getStoryById(token: token, id: id);

    return DetailStoryResponseEntity(
      error: response.error,
      message: response.message,
      story: response.story,
    );
  }
}
