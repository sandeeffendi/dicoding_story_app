import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/features/auth/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _hasNavigated = false;
  late SplashProvider _provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = context.read<SplashProvider>();
  }

  @override
  void initState() {
    super.initState();
    _hasNavigated = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _provider.resetToInitial();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _provider.startFadeInAnimation();
      });
    });
  }

  void _onAnimationEnd() {
    _provider.onAnimationEnd();
  }

  void _navigateToNextPage() {
    if (_provider.isLoggedIn()) {
      context.go(StoryAppRouter.home);
    } else {
      context.go(StoryAppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SplashProvider>().state;

    if (state.isNavigating && !_hasNavigated) {
      _hasNavigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _navigateToNextPage();
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: state.opacity,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          onEnd: _onAnimationEnd,
          child: Image.asset(
            'assets/images/dicoding-header-logo.png',
            height: 50,
          ),
        ),
      ),
    );
  }
}
