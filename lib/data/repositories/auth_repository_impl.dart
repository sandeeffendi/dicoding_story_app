import 'package:intermediate_first_submission/domain/enitities/login_result_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/register_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<RegisterResponseEntity> createAccount({required String email, required String password, required String name}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<LoginResultEntity> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}