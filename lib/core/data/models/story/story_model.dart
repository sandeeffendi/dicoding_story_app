import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
sealed class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    @Default(0) double? lat,
    @Default(0) double? lon,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

extension StoryModelMapper on StoryModel {
  StoryEntity toEntity() {
    return StoryEntity(
      id: id,
      name: name,
      description: description,
      photoUrl: photoUrl,
      createdAt: createdAt,
      lat: lat,
      lon: lon,
    );
  }
}
