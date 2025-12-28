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

// login form state
class LoginFormState {
  final List<String> errors;
  final bool obscurePassword;
  final bool remember;

  const LoginFormState({
    this.errors = const [],
    this.obscurePassword = true,
    this.remember = false,
  });

  LoginFormState copyWith({
    List<String>? errors,
    bool? obscurePassword,
    bool? remember,
  }) {
    return LoginFormState(
      errors: errors ?? this.errors,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      remember: remember ?? this.remember,
    );
  }
}

// regsiter form state
class RegisterFormState {
  final List<String> errors;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToTerms;

  const RegisterFormState({
    this.errors = const [],
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.agreeToTerms = false,
  });

  RegisterFormState copyWith({
    List<String>? errors,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeToTerms,
  }) {
    return RegisterFormState(
      errors: errors ?? this.errors,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
    );
  }
}
