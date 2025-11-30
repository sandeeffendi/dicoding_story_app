// Profile Screen
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SessionServices sessionServices;

  @override
  void initState() {
    super.initState();

    sessionServices = GetIt.instance<SessionServices>();
  }

  void logOut() {
    sessionServices.clearSession();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final userPosts = List.generate(
      24,
      (index) => {'id': 'post_$index', 'photoUrl': 'assets/images/mock.png'},
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          'username',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box_outlined,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: theme.colorScheme.onSurface),
            onPressed: () {
              logOut();
              context.go(StoryAppRouter.login);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/mock.png'),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn(context, '123', 'Posts'),
                          _buildStatColumn(context, '1.2K', 'Followers'),
                          _buildStatColumn(context, '456', 'Following'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Display Name',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Bio goes here...', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.colorScheme.outline),
                      foregroundColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      'Edit Profile',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: theme.colorScheme.outline.withAlpha((0.2 * 255).round()),
          ),
          // Grid of posts
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: userPosts.length,
            itemBuilder: (context, index) {
              return Image.asset(
                userPosts[index]['photoUrl']!,
                fit: BoxFit.cover,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String count, String label) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
