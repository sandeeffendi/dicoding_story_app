import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/detail_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/get_story_by_id_usecase.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_state.dart';

class DetailProvider extends ChangeNotifier {
  final GetStoryByIdUsecase getStoryByIdUsecase;
  DetailProvider({required this.getStoryByIdUsecase});

  DetailState _state = DetailState();
  DetailState get state => _state;

  StoryEntity? _storydata;
  StoryEntity? get storyData => _storydata;

  DetailStoryResponseEntity? _detailStoryResponse;
  DetailStoryResponseEntity? get detailStoryResponse => _detailStoryResponse;

  // get story by id trigger method
  Future<void> getStoryById({required String token, required String id}) async {
    _state = _state.copyWith(status: DetailStatus.loading);
    notifyListeners();

    try {
      final result = await getStoryByIdUsecase.call(token: token, id: id);

      if (result.error == true) {
        _state = _state.copyWith(
          status: DetailStatus.error,
          message: result.message,
        );
      } else {
        _detailStoryResponse = result;
        _storydata = result.story;
        _state = _state.copyWith(status: DetailStatus.success);
      }
    } catch (e) {
      _state = _state.copyWith(
        status: DetailStatus.error,
        message: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }
}
