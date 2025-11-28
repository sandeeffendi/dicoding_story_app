import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/login/login_page.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/register/register_page.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/splash_page.dart';
import 'package:intermediate_first_submission/presentation/pages/home/home_page.dart';

class StoryAppRouter {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = 'register';
  static const String home = 'home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // splash route
      case splash:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
          settings: settings,
        );

      // login route
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      // register route
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('404 - Page not Found'))),
        );
    }
  }
}
