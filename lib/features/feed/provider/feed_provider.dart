import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/get_all_story_usecase.dart';
import 'package:intermediate_first_submission/features/feed/provider/feed_state.dart';

class HomeFeedProvider extends ChangeNotifier {
  final GetAllStoryUsecase getAllStoryUsecase;

  HomeFeedProvider({required this.getAllStoryUsecase});

  HomeState _state = const HomeState();
  HomeState get state => _state;

  final List<StoryEntity> _listStoryData = [];
  List<StoryEntity> get listStoryData => _listStoryData;

  ListStoryResponseEntity? _listStoryResponse;
  ListStoryResponseEntity? get listStoryResponse => _listStoryResponse;

  int pageItem = 1;
  int sizeItem = 10;
  bool _isFetching = false;
  bool _hasMore = true;

  // get all story trigger method
  Future<void> getAllStory(String token) async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    if (pageItem == 1) {
      _state = _state.copyWith(status: HomeStatus.loading);
    } else {
      _state = _state.copyWith(status: HomeStatus.paginationLoading);
    }

    notifyListeners();

    try {
      final result = await getAllStoryUsecase.call(
        token: token,
        size: sizeItem.toString(),
        page: pageItem.toString(),
      );

      if (result.error == true) {
        _state = _state.copyWith(
          status: HomeStatus.error,
          message: result.message,
        );
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        _listStoryData.addAll(result.listStory);
        _hasMore = result.listStory.length == sizeItem;
        pageItem++;

        _state = _state.copyWith(status: HomeStatus.success);
      }
    } catch (e) {
      _state = _state.copyWith(status: HomeStatus.error, message: e.toString());
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> resetPagination(String token) async {
    pageItem = 1;
    _hasMore = true;
    _listStoryData.clear();
    _state = _state.copyWith(status: HomeStatus.initial);
    notifyListeners();

    await getAllStory(token);
  }
}
