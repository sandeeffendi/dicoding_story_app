import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/register_response_entity.dart';

part 'register_response_model.freezed.dart';
part 'register_response_model.g.dart';

@freezed
sealed class RegisterResponseModel with _$RegisterResponseModel {
  const factory RegisterResponseModel({
    required bool error,
    required String message,
  }) = _RegisterResponseModel;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);
}

// extension mapper
extension RegisterResponseModelMapper on RegisterResponseModel {
  RegisterResponseEntity toEntity() {
    return RegisterResponseEntity(error: error, message: message);
  }
}
