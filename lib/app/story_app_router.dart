import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/core/config/flavor_config.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/features/archive/pages/archive_page.dart';
import 'package:intermediate_first_submission/features/auth/pages/login/login_page.dart';
import 'package:intermediate_first_submission/features/auth/pages/register/register_page.dart';
import 'package:intermediate_first_submission/features/auth/pages/splash_page.dart';
import 'package:intermediate_first_submission/features/detail/pages/detail_maps_page.dart';
import 'package:intermediate_first_submission/features/detail/pages/detail_page.dart';
import 'package:intermediate_first_submission/features/explore/pages/explore_page.dart';
import 'package:intermediate_first_submission/features/feed/pages/feed_page.dart';
import 'package:intermediate_first_submission/features/home/pages/home_page.dart';
import 'package:intermediate_first_submission/features/post/pages/post_location_page.dart';
import 'package:intermediate_first_submission/features/post/pages/post_page.dart';
import 'package:intermediate_first_submission/features/profile/pages/profile_page.dart';

final storyAppRouter = StoryAppRouter();

class StoryAppRouter {
  late final GoRouter router;

  // auth page constant
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // home page constant
  static const String feed = '/feed';
  static const String post = '/post';
  static const String explore = '/explore';
  static const String archive = '/archive';
  static const String profile = '/profile';
  static const String detail = '/detail';
  static const String location = '/location';
  static const String postLocation = '/pickLocation';

  /* --- Routes --- */
  StoryAppRouter() {
    router = GoRouter(
      // redirect route handler
      redirect: (context, state) {
        final session = GetIt.instance<SessionServices>();
        final isLoggedIn = session.isLoggedIn();

        if (state.matchedLocation == splash) return null;

        // Block post location route for free flavor
        if (!FlavorConfig.isMapsEnabled) {
          if (state.matchedLocation == postLocation) {
            return home;
          }
        }

        final isAuthPage =
            state.matchedLocation == login || state.matchedLocation == register;
        if (!isLoggedIn && !isAuthPage) return login;

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
        // splash page route
        GoRoute(path: splash, builder: (context, state) => const SplashPage()),

        // login page route
        GoRoute(path: login, builder: (context, state) => const LoginPage()),

        // register page route
        GoRoute(
          path: register,
          builder: (context, state) => const RegisterPage(),
        ),

        /* --- Main Routes & Shell Routes --- */
        ShellRoute(
          builder: (context, state, child) => HomePage(child: child),
          routes: [
            // home page route
            GoRoute(path: home, builder: (context, state) => const FeedPage()),

            // feed page route
            GoRoute(path: feed, builder: (context, state) => const FeedPage()),

            // explore page route
            GoRoute(
              path: explore,
              builder: (context, state) => const ExplorePage(),
            ),

            // archive page route
            GoRoute(
              path: archive,
              builder: (context, state) => const ArchivePage(),
            ),

            // profile page route
            GoRoute(
              path: profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),

        // post page route
        GoRoute(
          path: post,
          builder: (context, state) => const CreatePostPage(),
        ),

        // detail page route
        GoRoute(
          path: '$detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return DetailPage(id: id!);
          },
        ),

        // detial maps route
        GoRoute(
          path: '$location/:lat/:lon',
          builder: (context, state) {
            final double lat = double.parse(state.pathParameters['lat']!);
            final double lon = double.parse(state.pathParameters['lon']!);

            return DetailMapsPage(storyLat: lat, storyLon: lon);
          },
        ),

        // post location route
        GoRoute(
          path: postLocation,
          builder: (context, state) => const PostLocationPage(),
        ),
      ],
    );
  }
}
