import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/presentation/auth/pages/login/login_page.dart';
import 'package:intermediate_first_submission/presentation/auth/pages/register/register_page.dart';
import 'package:intermediate_first_submission/presentation/auth/splash_page.dart';
import 'package:intermediate_first_submission/presentation/home/home_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/archive/archive_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/explore/explore_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/feed/feed_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/post/post_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/profile/profile_page.dart';

class StoryAppRouter {
  // auth page
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = 'register';
  static const String home = 'home';

  // home page
  static const String feed = '/feed';
  static const String post = '/post';
  static const String explore = '/explore';
  static const String archive = '/archive';
  static const String profile = '/profile';

  /* --- Routes --- */
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* --- Auth Pages Router --- */
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

      /* --- Home Pages Router -- */
      // home route
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());

      // feed route
      case feed:
        return MaterialPageRoute(builder: (_) => FeedPage());

      // explore route
      case explore:
        return MaterialPageRoute(builder: (_) => ExplorePage());

      // post route
      case post:
        return MaterialPageRoute(builder: (_) => CreatePostPage());

      // archive route
      case archive:
        return MaterialPageRoute(builder: (_) => ArchivePage());

      // profile page
      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('404 - Page not Found'))),
        );
    }
  }
}
