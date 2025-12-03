import 'package:intermediate_first_submission/domain/enitities/story/add_story_request_entity.dart';

class AddStoryRequestModel extends AddStoryRequestEntity {
  AddStoryRequestModel({required super.description, required super.photo});

  factory AddStoryRequestModel.fromJson(Map<String, dynamic> json) =>
      AddStoryRequestModel(
        description: json['description'] ?? 'not',
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {'description': description, 'photo': photo};
}
