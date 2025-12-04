// Explore Screen
import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final posts = List.generate(
      30,
      (index) => {'id': 'post_$index', 'photoUrl': 'assets/images/mock.png'},
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchTitle,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(
                  (0.6 * 255).round(),
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: theme.colorScheme.onSurface.withAlpha(
                  (0.6 * 255).round(),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to detail
            },
            child: Image.asset(posts[index]['photoUrl']!, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
