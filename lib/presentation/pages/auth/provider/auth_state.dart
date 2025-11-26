enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.message});

  bool get isLoading => status == AuthStatus.loading;
  bool get isError => status == AuthStatus.error;
  bool get isSuccess => status == AuthStatus.success;

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
