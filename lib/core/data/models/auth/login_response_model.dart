import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/data/models/auth/login_result_model.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/login_response_entity.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@freezed
sealed class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required bool error,
    required String message,
    required LoginResultModel loginResult,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

// extension mapper
extension LoginResponseModelMapper on LoginResponseModel {
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      error: error,
      message: message,
      loginResult: loginResult.toEntity(),
    );
  }
}
