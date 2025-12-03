import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final archived = List.generate(
      20,
      (index) => {
        'id': 'archive_$index',
        'photoUrl': 'assets/images/mock.png',
        'name': 'Archived Post ${index + 1}',
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.archiveTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
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
        itemCount: archived.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.asset(
                archived[index]['photoUrl']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withAlpha(
                      (0.7 * 255).round(),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.archive,
                    color: theme.colorScheme.onSurface,
                    size: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
