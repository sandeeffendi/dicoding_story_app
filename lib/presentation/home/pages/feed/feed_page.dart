// Home Screen - Feed
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // todo: implement data
    // Sample data - replace with your actual data
    final stories = List.generate(
      10,
      (index) => {
        'id': 'story_$index',
        'name': 'User ${index + 1}',
        'photoUrl': 'assets/images/mock.png',
      },
    );

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
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                _buildStoryList(context, stories),
                Divider(
                  height: 1,
                  color: theme.colorScheme.outline.withAlpha(
                    (0.2 * 255).round(),
                  ),
                ),
                _buildPostItem(context, stories[index]),
              ],
            );
          }
          return _buildPostItem(context, stories[index]);
        },
      ),
    );
  }

  Widget _buildStoryList(
    BuildContext context,
    List<Map<String, String>> stories,
  ) {
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
                      backgroundImage: AssetImage(stories[index]['photoUrl']!),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 70,
                  child: Text(
                    stories[index]['name']!,
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

  Widget _buildPostItem(BuildContext context, Map<String, String> story) {
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
                backgroundImage: AssetImage(story['photoUrl']!),
              ),
              const SizedBox(width: 8),
              Text(
                story['name']!,
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
        Image.asset(
          story['photoUrl']!,
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
              Text(
                '1,234 likes',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${story['name']} ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: 'This is a sample description...'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '2 hours ago',
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
