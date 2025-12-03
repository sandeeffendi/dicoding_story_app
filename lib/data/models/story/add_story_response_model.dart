import 'package:intermediate_first_submission/domain/enitities/story/add_story_response_entity.dart';

class AddStoryResponseModel extends AddStoryResponseEntity {
  AddStoryResponseModel({required super.error, required super.message});

  factory AddStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      AddStoryResponseModel(error: json['error'], message: json['message']);

  Map<String, dynamic> toJson() => {'error': error, 'message': message};
}
