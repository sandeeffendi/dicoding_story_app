import 'package:intermediate_first_submission/domain/enitities/register_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';

class CreateAccountUsecase {
  final AuthRepository authRepository;
  const CreateAccountUsecase(this.authRepository);

  Future<RegisterResponseEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return authRepository.createAccount(
      email: email,
      password: password,
      name: name,
    );
  }
}
