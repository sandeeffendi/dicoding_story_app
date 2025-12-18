import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/login_result_entity.dart';

part 'login_result_model.freezed.dart';
part 'login_result_model.g.dart';

@freezed
sealed class LoginResultModel with _$LoginResultModel {
  const factory LoginResultModel({
    required String userId,
    required String name,
    required String token,
  }) = _LoginResultModel;

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);
}

// extension mapper
extension LoginResultModelMapper on LoginResultModel {
  LoginResultEntity toEntity() {
    return LoginResultEntity(userId: userId, name: name, token: token);
  }
}
