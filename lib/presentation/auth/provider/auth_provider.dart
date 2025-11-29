import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/login_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/login_result_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/auth/register_response_entity.dart';
import 'package:intermediate_first_submission/domain/usecases/auth/create_account_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/auth/login_usecase.dart';
import 'package:intermediate_first_submission/presentation/auth/provider/auth_state.dart';

class AuthProvider extends ChangeNotifier {
  final CreateAccountUsecase createAccountUsecase;
  final LoginUsecase loginUsecase;

  AuthProvider({
    required this.createAccountUsecase,
    required this.loginUsecase,
  });

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  AuthState _state = AuthState();
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
}
