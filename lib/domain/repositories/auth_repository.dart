import 'package:intermediate_first_submission/domain/enitities/login_result_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/register_response_entity.dart';

abstract class AuthRepository {
  Future<RegisterResponseEntity> createAccount({
    required String email,
    required String password,
    required String name,
  });

  Future<LoginResultEntity> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}
