import 'package:intermediate_first_submission/core/data/models/auth/login_result_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    required super.error,
    required super.message,
    required super.loginResult,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResultModel.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "loginResult": loginResult,
  };
}
