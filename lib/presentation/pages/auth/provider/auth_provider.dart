import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/domain/enitities/login_response_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/login_result_entity.dart';
import 'package:intermediate_first_submission/domain/enitities/register_response_entity.dart';
import 'package:intermediate_first_submission/domain/usecases/create_account_usecase.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/provider/auth_state.dart';

class AuthProvider extends ChangeNotifier {
  final CreateAccountUsecase createAccountUsecase;

  AuthProvider({required this.createAccountUsecase});

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  AuthState _state = AuthState();
  AuthState get state => _state;

  LoginResultEntity? _user;
  LoginResultEntity? get user => _user;

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
        _state = _state.copyWith(status: AuthStatus.success);
      }
    } catch (e) {
      _state = _state.copyWith(status: AuthStatus.error, message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }
}
