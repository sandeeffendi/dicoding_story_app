import 'package:intermediate_first_submission/core/domain/enitities/auth/login_result_entity.dart';

enum AuthStatus { initial, loading, registerSuccess, error, loginSuccess }

class AuthState {
  final AuthStatus status;
  final String? message;
  final LoginResultEntity? loginData;

  const AuthState({
    this.status = AuthStatus.initial,
    this.message,
    this.loginData,
  });

  bool get isLoading => status == AuthStatus.loading;
  bool get isError => status == AuthStatus.error;
  bool get isRegisterSuccess => status == AuthStatus.registerSuccess;
  bool get isLoginSuccess => status == AuthStatus.loginSuccess;

  AuthState copyWith({
    AuthStatus? status,
    String? message,
    LoginResultEntity? loginData,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      loginData: loginData,
    );
  }
}
