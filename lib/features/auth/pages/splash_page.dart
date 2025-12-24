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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _hasNavigated = false;
    _initialized = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      // Reset synchronously BEFORE build() can see old state
      context.read<SplashProvider>().reset();

      // Start animation after frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<SplashProvider>().startAnimation();
        }
      });
    }
  }

  void _onAnimationEnd() {
    final provider = context.read<SplashProvider>();
    provider.onAnimationEnd();
  }

  void _navigateToNextPage() {
    final provider = context.read<SplashProvider>();
    if (provider.isLoggedIn()) {
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
        if (mounted) _navigateToNextPage();
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
