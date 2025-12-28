import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/login_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/login_result_entity.dart';
import 'package:intermediate_first_submission/core/domain/enitities/auth/register_response_entity.dart';
import 'package:intermediate_first_submission/core/domain/usecases/auth/create_account_usecase.dart';
import 'package:intermediate_first_submission/core/domain/usecases/auth/login_usecase.dart';
import 'package:intermediate_first_submission/features/auth/provider/auth_state.dart';

class AuthProvider extends ChangeNotifier {
  final CreateAccountUsecase createAccountUsecase;
  final LoginUsecase loginUsecase;

  AuthProvider({
    required this.createAccountUsecase,
    required this.loginUsecase,
  });

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  AuthState _state = const AuthState();
  AuthState get state => _state;

  LoginResultEntity? _loginData;
  LoginResultEntity? get loginData => _loginData;

  RegisterResponseEntity? _registerResponse;
  RegisterResponseEntity? get registerResponse => _registerResponse;

  LoginResponseEntity? _loginResponseEntity;
  LoginResponseEntity? get loginResponseEntity => _loginResponseEntity;

  // register trigger method
  Future<void> createAccount(String name, String email, String password) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    try {
      final result = await createAccountUsecase.call(
        name: name,
        email: email,
        password: password,
      );

      if (result.error == true) {
        _state = _state.copyWith(
          status: AuthStatus.error,
          message: result.message,
        );
      } else {
        _registerResponse = result;
        _state = _state.copyWith(status: AuthStatus.registerSuccess);
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  // submit button trigger method
  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  // login trigger method
  Future<void> logIn(String email, String password) async {
    _state = _state.copyWith(status: AuthStatus.loading);
    notifyListeners();

    try {
      final result = await loginUsecase.call(email: email, password: password);

      if (result.error == true) {
        _state = _state.copyWith(
          status: AuthStatus.error,
          message: result.message,
        );
      } else {
        _loginResponseEntity = result;
        _loginData = _loginResponseEntity!.loginResult;
        _state = _state.copyWith(
          status: AuthStatus.loginSuccess,
          message: result.message,
          loginData: result.loginResult,
        );
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  // LOGIN FORM STATE
  LoginFormState _loginFormState = const LoginFormState();
  LoginFormState get loginFormState => _loginFormState;

  void addLoginError(String error) {
    if (!_loginFormState.errors.contains(error)) {
      final newErrors = [..._loginFormState.errors, error];
      _loginFormState = _loginFormState.copyWith(errors: newErrors);
      notifyListeners();
    }
  }

  void removeLoginError(String error) {
    if (_loginFormState.errors.contains(error)) {
      final newErrors = _loginFormState.errors
          .where((e) => e != error)
          .toList();
      _loginFormState = _loginFormState.copyWith(errors: newErrors);
      notifyListeners();
    }
  }

  void toggleLoginPasswordVisibility() {
    _loginFormState = _loginFormState.copyWith(
      obscurePassword: !_loginFormState.obscurePassword,
    );
    notifyListeners();
  }

  void setRemember(bool value) {
    _loginFormState = _loginFormState.copyWith(remember: value);
    notifyListeners();
  }

  void resetLoginFormState() {
    _loginFormState = const LoginFormState();
    notifyListeners();
  }

  //  REGSITER FORM STATE
  RegisterFormState _registerFormState = const RegisterFormState();
  RegisterFormState get registerFormState => _registerFormState;

  void addRegisterError(String error) {
    if (!_registerFormState.errors.contains(error)) {
      final newErrors = [..._registerFormState.errors, error];
      _registerFormState = _registerFormState.copyWith(errors: newErrors);
      notifyListeners();
    }
  }

  void removeRegisterError(String error) {
    if (_registerFormState.errors.contains(error)) {
      final newErrors = _registerFormState.errors
          .where((e) => e != error)
          .toList();
      _registerFormState = _registerFormState.copyWith(errors: newErrors);
      notifyListeners();
    }
  }

  void toggleRegisterPasswordVisibility() {
    _registerFormState = _registerFormState.copyWith(
      obscurePassword: !_registerFormState.obscurePassword,
    );
    notifyListeners();
  }

  void toggleRegisterConfirmPasswordVisibility() {
    _registerFormState = _registerFormState.copyWith(
      obscureConfirmPassword: !_registerFormState.obscureConfirmPassword,
    );
    notifyListeners();
  }

  void setAgreeToTerms(bool value) {
    _registerFormState = _registerFormState.copyWith(agreeToTerms: value);
    notifyListeners();
  }

  void resetRegisterFormState() {
    _registerFormState = const RegisterFormState();
    notifyListeners();
  }

  // trigger rebuild password strength indicator method
  void triggerPasswordStrengthRebuild() {
    notifyListeners();
  }
}
