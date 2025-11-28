import 'package:intermediate_first_submission/domain/enitities/login_response_entity.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  const LoginUsecase(this.authRepository);

  Future<LoginResponseEntity> call({required email, required password}) {
    return authRepository.logIn(email: email, password: password);
  }
}
