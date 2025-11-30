import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/presentation/auth/pages/login/login_page.dart';
import 'package:intermediate_first_submission/presentation/auth/pages/register/register_page.dart';
import 'package:intermediate_first_submission/presentation/auth/splash_page.dart';
import 'package:intermediate_first_submission/presentation/home/home_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/archive/archive_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/explore/explore_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/feed/feed_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/post/post_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/profile/profile_page.dart';

final storyAppRouter = StoryAppRouter();

class StoryAppRouter {
  late final GoRouter router;

  // auth page constant
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = 'register';
  static const String home = '/home';

  // home page constant
  static const String feed = '/feed';
  static const String post = '/post';
  static const String explore = '/explore';
  static const String archive = '/archive';
  static const String profile = '/profile';

  /* --- Routes --- */
  StoryAppRouter() {
    router = GoRouter(
      // redirect route handler
      redirect: (context, state) {
        final session = GetIt.instance<SessionServices>();
        final isLoggedIn = session.isLoggedIn();

        if (state.matchedLocation == splash) return null;

        if (!isLoggedIn) return login;

        if (isLoggedIn && (state.matchedLocation == login)) {
          return home;
        }
        return null;
      },

      // initial route
      initialLocation: '/splash',

      // generate rote
      routes: [
        /* --- Auth Pages Route --- */
        GoRoute(path: splash, builder: (context, state) => SplashPage()),
        GoRoute(path: login, builder: (context, state) => LoginPage()),
        GoRoute(path: register, builder: (context, state) => RegisterPage()),

        /* --- Main Routes & Shell Routes --- */
        ShellRoute(
          builder: (context, state, child) => HomePage(child: child),
          routes: [
            GoRoute(path: home, builder: (context, state) => FeedPage()),
            GoRoute(path: feed, builder: (context, state) => FeedPage()),
            GoRoute(path: explore, builder: (context, state) => ExplorePage()),
            GoRoute(path: archive, builder: (context, state) => ArchivePage()),
            GoRoute(path: profile, builder: (context, state) => ProfilePage()),
          ],
        ),

        GoRoute(path: post, builder: (context, state) => CreatePostPage()),
      ],
    );
  }
}
