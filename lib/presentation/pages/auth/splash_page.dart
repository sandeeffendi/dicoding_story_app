import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    // Fade In
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() => _opacity = 1.0);

    // Stay visible
    await Future.delayed(const Duration(seconds: 1));

    // Fade Out
    setState(() => _opacity = 0.0);

    // After fade out → Navigate
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    if (_isLoggedIn()) {
      Navigator.pushReplacementNamed(context, StoryAppRouter.home);
    } else {
      Navigator.pushReplacementNamed(context, StoryAppRouter.login);
    }
  }

  bool _isLoggedIn() {
    final sessionService = GetIt.instance<SessionServices>();
    return sessionService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Image.asset(
            'assets/images/dicoding-header-logo.png',
            height: 50,
          ),
        ),
      ),
    );
  }
}
