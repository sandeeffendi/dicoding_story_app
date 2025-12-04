import 'package:intermediate_first_submission/core/domain/enitities/auth/login_result_entity.dart';

class LoginResponseEntity {
  bool error;
  String message;
  LoginResultEntity loginResult;

  LoginResponseEntity({
    required this.error,
    required this.message,
    required this.loginResult,
  });
}
