import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logOut() {
    final sessionService = GetIt.instance<SessionServices>();
    sessionService.clearSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('ini adalah homepage')),

          SizedBox(height: 20),

          FilledButton(
            onPressed: () {
              logOut();
              Navigator.pushReplacementNamed(context, StoryAppRouter.splash);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
