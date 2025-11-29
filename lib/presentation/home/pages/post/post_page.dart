// create post page
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Post',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post submission
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Post created!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              );
              Navigator.pop(context);
            },
            child: Text(
              'Share',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image preview
          Container(
            width: double.infinity,
            height: 300,
            color: theme.colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 80,
              color: theme.colorScheme.onSurface.withAlpha((0.4 * 255).round()),
            ),
          ),
          // Description input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              maxLines: 5,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(
                    (0.6 * 255).round(),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
          ),
          // Location button
          ListTile(
            leading: Icon(
              Icons.location_on_outlined,
              color: theme.colorScheme.onSurface,
            ),
            title: Text('Add Location', style: theme.textTheme.bodyLarge),
            trailing: Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface,
            ),
            onTap: () {
              // Handle location selection
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
