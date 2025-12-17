import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/app/story_app.dart';
import 'package:intermediate_first_submission/features/auth/provider/auth_provider.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_provider.dart';
import 'package:intermediate_first_submission/features/feed/provider/feed_provider.dart';
import 'package:intermediate_first_submission/features/post/provider/post_provider.dart';
import 'package:intermediate_first_submission/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart';
import 'core/di/di.dart' as di;
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('id', IdMessages());

  final prefs = await SharedPreferences.getInstance();

  await di.init(prefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<HomeFeedProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<PostProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<DetailProvider>()),
      ],
      child: const StoryApp(),
    ),
  );
}
