import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/app/theme/story_app_text_theme.dart';
import 'package:intermediate_first_submission/app/theme/story_app_theme.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:intermediate_first_submission/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, 'Montserrat', 'Poppins');
    MaterialTheme theme = MaterialTheme(textTheme);
    final provider = context.watch<ProfileProvider>();

    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // Indonesian,
        Locale('en'), // English
      ],
      themeMode: ThemeMode.system,
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: 'Dicoding Flutter Story App First Submission',
      routerConfig: storyAppRouter.router,
      locale: provider.locale,
    );
  }
}
