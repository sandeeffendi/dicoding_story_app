import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;

    if (location.startsWith(StoryAppRouter.feed)) {
      currentIndex = 0;
    } else if (location.startsWith(StoryAppRouter.explore)) {
      currentIndex = 1;
    } else if (location.startsWith(StoryAppRouter.post)) {
      currentIndex = 2;
    } else if (location.startsWith(StoryAppRouter.archive)) {
      currentIndex = 3;
    } else if (location.startsWith(StoryAppRouter.profile)) {
      currentIndex = 4;
    }

    return Scaffold(
      body: widget.child,

      // bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/feed');
              break;
            case 1:
              context.go('/explore');
              break;
            case 2:
              context.push('/post');
              break;
            case 3:
              context.go('/archive');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurface.withAlpha(
          (0.6 * 255).round(),
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: theme.colorScheme.surface,
        items: const [
          // bottom nav bar item Feed
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),

          // bottom nav bar item Explore
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),

          // bottom nav bar item Post
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Post',
          ),

          // bottom nav bar item Archive
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            activeIcon: Icon(Icons.archive),
            label: 'Archive',
          ),

          // bottom nav bar item Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
