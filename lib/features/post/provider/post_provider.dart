import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_request_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/add_story_withtoken_usecase.dart';
import 'package:intermediate_first_submission/features/post/provider/post_state.dart';

class PostProvider extends ChangeNotifier {
  final AddStoryWithtokenUsecase addStoryWithtokenUsecase;

  PostProvider({required this.addStoryWithtokenUsecase});

  PostState _state = const PostState();
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

  Future<List<int>> fileToInt(File photo) async {
    return await photo.readAsBytes();
  }

  // add story with token trigger method
  Future<void> addStory({
    required String token,
    String description = '',
    required File photo,
    double? lat,
    double? lon,
  }) async {
    _state = _state.copyWith(status: PostStatus.loading);
    notifyListeners();

    try {
      final photoToInt = await fileToInt(photo);

      final result = await addStoryWithtokenUsecase.call(
        token: token,
        description: description,
        photo: photoToInt,
        lat: lat,
        lon: lon,
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
