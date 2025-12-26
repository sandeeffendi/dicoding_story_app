import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/features/auth/provider/splash_state.dart';

class SplashProvider extends ChangeNotifier {
  final SessionServices _sessionServices;

  SplashProvider(this._sessionServices);

  SplashState _state = const SplashState();
  SplashState get state => _state;

  void resetToInitial() {
    _state = const SplashState();
    notifyListeners();
  }

  void startFadeInAnimation() {
    _state = _state.copyWith(phase: SplashPhase.fadeIn, opacity: 1.0);
    notifyListeners();
  }

  void startAnimation() {
    _state = _state.copyWith(phase: SplashPhase.fadeIn, opacity: 1.0);
    notifyListeners();
  }

  Future<void> onAnimationEnd() async {
    if (_state.isFadeIn) {
      _state = _state.copyWith(phase: SplashPhase.visible);
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      _state = _state.copyWith(phase: SplashPhase.fadeOut, opacity: 0.0);
      notifyListeners();
    } else if (_state.isFadeOut) {
      // Fade out complete, ready to navigate
      _state = _state.copyWith(phase: SplashPhase.navigating);
      notifyListeners();
    }
  }

  // check if user is logged in
  bool isLoggedIn() => _sessionServices.isLoggedIn();

  // reset state to initial
  void reset() {
    _state = const SplashState();
    notifyListeners();
  }
}
