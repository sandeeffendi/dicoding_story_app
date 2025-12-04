// Home Screen - Feed
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:intermediate_first_submission/presentation/home/provider/feed_provider/feed_provider.dart';
import 'package:intermediate_first_submission/presentation/home/provider/feed_provider/feed_state.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeago;

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late SessionServices sessionServices;

  @override
  void initState() {
    super.initState();

    sessionServices = GetIt.instance<SessionServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = sessionServices.getAccessToken();
      context.read<HomeFeedProvider>().getAllStory(token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          'Dicodinggram',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send_outlined, color: theme.colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),

      body: Consumer<HomeFeedProvider>(
        builder: (context, homeProvider, child) {
          final listStories = homeProvider.listStoryData;

          // Error state
          if (homeProvider.state.status == HomeStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Caught an error, ${homeProvider.state.message}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      homeProvider.getAllStory(
                        sessionServices.getAccessToken().toString(),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Loading state
          if (homeProvider.state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Empty state
          if (homeProvider.listStoryData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 64),
                  const Text('No Post Availabale'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => homeProvider.getAllStory(
                      sessionServices.getAccessToken().toString(),
                    ),
                    child: const Text('Load Post'),
                  ),
                ],
              ),
            );
          }

          // Success state
          return RefreshIndicator(
            onRefresh: () => homeProvider.getAllStory(
              sessionServices.getAccessToken().toString(),
            ),
            child: ListView.builder(
              itemCount: listStories!.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      _BuildStoryList(context: context, stories: listStories),
                      Divider(
                        height: 1,
                        color: theme.colorScheme.outline.withAlpha(
                          (0.2 * 255).round(),
                        ),
                      ),
                      _BuildPostItem(
                        context: context,
                        story: listStories[index],
                      ),
                    ],
                  );
                }
                return _BuildPostItem(
                  context: context,
                  story: listStories[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _BuildPostItem extends StatelessWidget {
  const _BuildPostItem({required this.context, required this.story});

  final BuildContext context;
  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(story.photoUrl),
              ),
              const SizedBox(width: 8),
              Text(
                story.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurface),
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        // Image
        Image.network(
          story.photoUrl,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
        ),
        
        // Action buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.send_outlined,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.likedTitle,
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    'Mulyono ',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('And ', style: theme.textTheme.labelSmall),
                  Text(
                    'Others ',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 4),
              
              // user name
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${story.name} ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: story.description),
                  ],
                ),
              ),
              
              const SizedBox(height: 4),
              
              // created at
              Text(
                timeago.format(story.createdAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(
                    (0.6 * 255).round(),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
      ],
    );
  }
}

class _BuildStoryList extends StatelessWidget {
  const _BuildStoryList({required this.context, required this.stories});

  final BuildContext context;
  final List<StoryEntity> stories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.secondary,
                        theme.colorScheme.tertiary,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.surface,
                      border: Border.all(
                        color: theme.colorScheme.surface,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(stories[index].photoUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 70,
                  child: Text(
                    stories[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
