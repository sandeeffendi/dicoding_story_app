import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_all_story_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_story_by_id_usecase.dart';
import 'package:intermediate_first_submission/presentation/home/pages/feed/provider/feed_state.dart';

class FeedProvider extends ChangeNotifier {
  final GetAllStoryUsecase getAllStoryUsecase;
  final GetStoryByIdUsecase getStoryByIdUsecase;

  FeedProvider({
    required this.getAllStoryUsecase,
    required this.getStoryByIdUsecase,
  });

  FeedState _state = FeedState();
  FeedState get state => _state;

  List<StoryEntity>? _listStoryData;
  List<StoryEntity>? get listStoryData => _listStoryData;

  StoryEntity? _storyData;
  StoryEntity? get storyData => _storyData;

  ListStoryResponseEntity? _listStoryResponse;
  ListStoryResponseEntity? get listStoryResponse => _listStoryResponse;

  DetailStoryResponseEntity? _detailStoryResponseEntity;
  DetailStoryResponseEntity? get detailStoryResponseEntity =>
      _detailStoryResponseEntity;

  // get all story trigger method
  Future<void> getAllStory(String token) async {
    _state = _state.copyWith(status: FeedStatus.loading);
    notifyListeners();

    try {
      final result = await getAllStoryUsecase.call(token: token);

      if (result.error == true) {
        _state = _state.copyWith(
          status: FeedStatus.error,
          message: result.message,
        );
      } else {
        _listStoryResponse = result;
        _listStoryData = result.listStory;
        _state = _state.copyWith(status: FeedStatus.success);
      }
    } catch (e) {
      _state = _state.copyWith(status: FeedStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  // get story by id trigger method
}
