// Profile Screen
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:intermediate_first_submission/presentation/home/pages/profile/components/flag_icon.dart';
import 'package:intermediate_first_submission/presentation/home/provider/feed_provider/feed_provider.dart';
import 'package:intermediate_first_submission/presentation/home/provider/feed_provider/feed_state.dart';
import 'package:provider/provider.dart';

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
    final username = sessionServices.getUsename();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          username ?? 'Username',
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
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: theme.colorScheme.onSurface),
                onPressed: () {
                  return Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),

      // drawer
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: SizedBox(
                  height: 60,
                  child: Image.asset('assets/images/dicoding-header-logo.png'),
                ),
              ),
            ),

            // language preferences
            Center(child: FlagIcon()),

            // Logout button
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.logOutTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.logout_outlined),
                ],
              ),
              onTap: () {
                logOut();
                context.go(StoryAppRouter.splash);
              },
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          // Profile info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display profile picture
                Row(
                  children: [
                    const CircleAvatar(radius: 40),

                    // profile info
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn(
                            context,
                            '123',
                            AppLocalizations.of(context)!.postsTitle,
                          ),
                          _buildStatColumn(
                            context,
                            '1.2K',
                            AppLocalizations.of(context)!.followerTitle,
                          ),
                          _buildStatColumn(
                            context,
                            '456',
                            AppLocalizations.of(context)!.followingTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Display name
                Text(
                  username ?? 'Username',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // User Bio
                Text(
                  'Wi Wok De Tok,\nNat Onle Tok De Tok',
                  style: theme.textTheme.bodyMedium,
                ),

                const SizedBox(height: 12),

                // Edit Profile
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.colorScheme.outline),
                      foregroundColor: theme.colorScheme.onSurface,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.editProfileTitle,
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
          Consumer<HomeFeedProvider>(
            builder: (context, provider, child) {
              final listStories = provider.listStoryData;

              // error state
              if (provider.state.status == HomeStatus.error) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Caught an error, ${provider.state.message}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          provider.getAllStory(
                            sessionServices.getAccessToken().toString(),
                          );
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              // loading state
              if (provider.state.status == HomeStatus.loading) {
                return Center(child: CircularProgressIndicator());
              }

              // empty state
              if (provider.listStoryData == null) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 64),
                      Text('No Post Availabale'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => provider.getAllStory(
                          sessionServices.getAccessToken().toString(),
                        ),
                        child: Text('Load Post'),
                      ),
                    ],
                  ),
                );
              }

              // succes state
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: listStories!.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    listStories[index].photoUrl,
                    fit: BoxFit.cover,
                  );
                },
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
