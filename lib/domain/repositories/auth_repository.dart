import 'package:intermediate_first_submission/domain/enitities/auth/login_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/register_response_entity.dart';

abstract class AuthRepository {
  Future<RegisterResponseEntity> createAccount({
    required String email,
    required String password,
    required String name,
  });

  Future<LoginResponseEntity> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}
