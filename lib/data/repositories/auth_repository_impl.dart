import 'package:intermediate_first_submission/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/login_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/register_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final MainRemoteDatasource remoteDatasource;
  const AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<RegisterResponseEntity> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await remoteDatasource.createAccount(
      name: name,
      email: email,
      password: password,
    );

    return RegisterResponseEntity(
      error: response.error,
      message: response.message,
    );
  }

  @override
  Future<LoginResponseEntity> logIn({
    required String email,
    required String password,
  }) async {
    final response = await remoteDatasource.logIn(
      email: email,
      password: password,
    );

    return LoginResponseEntity(
      error: response.error,
      message: response.message,
      loginResult: response.loginResult,
    );
  }
}
