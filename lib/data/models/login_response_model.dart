import 'package:intermediate_first_submission/data/models/login_result_model.dart';
import 'package:intermediate_first_submission/domain/enitities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity{
  LoginResponseModel({required super.error, required super.message, required super.loginResult});


  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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