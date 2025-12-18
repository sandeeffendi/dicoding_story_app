import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/add_story_request_entity.dart';

part 'add_story_request_model.freezed.dart';
part 'add_story_request_model.g.dart';

@freezed
sealed class AddStoryRequestModel with _$AddStoryRequestModel {
  const factory AddStoryRequestModel({
    required String description,
    required List<int> photo,
  }) = _AddStoryRequestModel;

  factory AddStoryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddStoryRequestModelFromJson(json);
}

extension AddStoryRequestModelMapper on AddStoryRequestModel {
  AddStoryRequestEntity toEntity() {
    return AddStoryRequestEntity(description: description, photo: photo);
  }
}

extension AddStoryRequestEntityMapper on AddStoryRequestModel {
  AddStoryRequestModel toModel() {
    return AddStoryRequestModel(description: description, photo: photo);
  }
}
