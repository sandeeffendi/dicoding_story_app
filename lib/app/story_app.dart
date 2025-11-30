import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/app/theme/story_app_text_theme.dart';
import 'package:intermediate_first_submission/app/theme/story_app_theme.dart';

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, 'Montserrat', 'Poppins');
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: 'Dicoding Flutter Story App First Submission',
      routerConfig: storyAppRouter.router,
    );
  }
}
