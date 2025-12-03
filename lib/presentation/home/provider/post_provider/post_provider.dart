import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intermediate_first_submission/domain/enitities/story/add_story_request_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/story/add_story_response_entity.dart';
import 'package:intermediate_first_submission/domain/usecases/story/add_story_withtoken_usecase.dart';
import 'package:intermediate_first_submission/presentation/home/provider/post_provider/post_state.dart';

class PostProvider extends ChangeNotifier {
  final AddStoryWithtokenUsecase addStoryWithtokenUsecase;

  PostProvider({required this.addStoryWithtokenUsecase});

  PostState _state = PostState();
  PostState get state => _state;

  AddStoryRequestEntity? _addStoryData;
  AddStoryRequestEntity? get addStoryData => _addStoryData;

  AddStoryResponseEntity? _addStoryResponse;
  AddStoryResponseEntity? get addStoryResponse => _addStoryResponse;

  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  void setPickedImage(File value) {
    _pickedImage = value;
    notifyListeners();
  }

  // add story with token trigger method
  Future<void> addStory({
    required String token,
    String description = '',
    required File photo,
  }) async {
    _state = _state.copyWith(status: PostStatus.loading);
    notifyListeners();

    try {
      final result = await addStoryWithtokenUsecase.call(
        token: token,
        description: description,
        photo: photo,
      );

      if (result.error == true) {
        _state = _state.copyWith(
          status: PostStatus.error,
          message: result.message,
        );
      } else {
        _addStoryResponse = result;
        _state = _state.copyWith(status: PostStatus.sucess);
      }
    } catch (e) {
      _state = _state.copyWith(status: PostStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetAddStoryState() {
    _state = _state.copyWith(status: PostStatus.initial);
    _addStoryData = null;
    _addStoryResponse = null;
    _pickedImage = null;

    notifyListeners();
  }
}
