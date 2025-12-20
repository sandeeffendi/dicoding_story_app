import 'dart:typed_data';

import 'package:intermediate_first_submission/core/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/core/data/models/story/add_story_request_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/add_story_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/detail_story_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/story_response_model.dart';
import 'package:intermediate_first_submission/core/data/repositories/service/image_compression_service.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_request_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/repositories/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  final MainRemoteDatasource remoteDatasource;
  final ImageCompressionService imageCompressionService;
  const StoryRepositoryImpl(
    this.remoteDatasource,
    this.imageCompressionService,
  );

  @override
  Future<ListStoryResponseEntity> getAllStory({
    required String token,
    required String size,
    required page,
  }) async {
    final response = await remoteDatasource.getAllStory(
      token: token,
      size: size,
      page: page,
    );

    return response.toEntity();
  }

  @override
  Future<DetailStoryResponseEntity> getStoryById({
    required String token,
    required String id,
  }) async {
    final response = await remoteDatasource.getStoryById(token: token, id: id);

    return response.toEntity();
  }

  @override
  Future<AddStoryResponseEntity> addStoryWithToken({
    required String token,
    required AddStoryRequestEntity storyRequest,
  }) async {
    final compressedImage = await compressBytes(storyRequest.photo);

    final response = await remoteDatasource.addStoryWithToken(
      token: token,
      story: AddStoryRequestModel(
        description: storyRequest.description ?? ' ',
        photo: compressedImage,
      ),
    );

    return response.toEntity();
  }

  Future<List<int>> compressBytes(List<int> bytes) async {
    final uint8 = Uint8List.fromList(bytes);

    final compressedUint8 = await imageCompressionService.compressUnder1MB(
      uint8,
    );

    return compressedUint8.toList();
  }
}
