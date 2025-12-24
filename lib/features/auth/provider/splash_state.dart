enum SplashPhase { fadeIn, visible, fadeOut, navigating }

class SplashState {
  final SplashPhase phase;
  final double opacity;

  const SplashState({this.phase = SplashPhase.fadeIn, this.opacity = 0.0});

  bool get isFadeIn => phase == SplashPhase.fadeIn;
  bool get isVisible => phase == SplashPhase.visible;
  bool get isFadeOut => phase == SplashPhase.fadeOut;
  bool get isNavigating => phase == SplashPhase.navigating;

  SplashState copyWith({SplashPhase? phase, double? opacity}) {
    return SplashState(
      phase: phase ?? this.phase,
      opacity: opacity ?? this.opacity,
    );
  }
}
