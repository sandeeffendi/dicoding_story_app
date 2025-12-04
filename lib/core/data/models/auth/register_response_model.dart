import 'package:intermediate_first_submission/core/domain/enitities/auth/register_response_entity.dart';

class RegisterResponseModel extends RegisterResponseEntity {
  RegisterResponseModel({required super.error, required super.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(error: json["error"], message: json["message"]);

  Map<String, dynamic> toJson() => {"error": error, "message": message};
}
