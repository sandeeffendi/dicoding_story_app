import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/app/story_app.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>())],
      child: StoryApp(),
    ),
  );
}
