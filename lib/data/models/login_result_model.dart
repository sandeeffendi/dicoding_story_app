import 'package:intermediate_first_submission/domain/enitities/login_result_entity.dart';

class LoginResultModel extends LoginResultEntity {
  LoginResultModel({
    required super.userId,
    required super.name,
    required super.token,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "token": token,
  };
}
