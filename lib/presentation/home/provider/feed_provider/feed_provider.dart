import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_all_story_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_story_by_id_usecase.dart';
import 'package:intermediate_first_submission/presentation/home/provider/feed_provider/feed_state.dart';

class HomeFeedProvider extends ChangeNotifier {
  final GetAllStoryUsecase getAllStoryUsecase;
  final GetStoryByIdUsecase getStoryByIdUsecase;

  HomeFeedProvider({
    required this.getAllStoryUsecase,
    required this.getStoryByIdUsecase,
  });

  HomeState _state = const HomeState();
  HomeState get state => _state;

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
    _state = _state.copyWith(status: HomeStatus.loading);
    notifyListeners();

    try {
      final result = await getAllStoryUsecase.call(token: token);

      if (result.error == true) {
        _state = _state.copyWith(
          status: HomeStatus.error,
          message: result.message,
        );
      } else {
        _listStoryResponse = result;
        _listStoryData = result.listStory;
        _state = _state.copyWith(status: HomeStatus.success);
      }
    } catch (e) {
      _state = _state.copyWith(status: HomeStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  // get story by id trigger method
}
