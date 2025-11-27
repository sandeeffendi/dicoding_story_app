import 'package:intermediate_first_submission/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/domain/enitities/login_result_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/register_response_entity.dart';
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
  Future<LoginResultEntity> logIn({
    required String email,
    required String password,
  }) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
