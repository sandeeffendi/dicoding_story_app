import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/app/story_app.dart';
import 'package:intermediate_first_submission/presentation/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  await di.init(prefs);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>())],
      child: StoryApp(),
    ),
  );
}
