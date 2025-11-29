import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/presentation/home/pages/archive/archive_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/explore/explore_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/feed/feed_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/post/post_page.dart';
import 'package:intermediate_first_submission/presentation/home/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedPage(),
    const ExplorePage(),
    const ArchivePage(),
    const ProfilePage(),
  ];

  void _onCreatePost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePostPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _screens[_currentIndex],

      // bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            _onCreatePost();
          } else {
            setState(() {
              _currentIndex = index > 2 ? index - 1 : index;
            });
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
