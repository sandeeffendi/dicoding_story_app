// create post page
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/presentation/home/provider/post_provider/post_provider.dart';
import 'package:intermediate_first_submission/presentation/home/provider/post_provider/post_state.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  late PostProvider postProvider;
  late SessionServices sessionServices;
  String? token;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<PostProvider>().resetAddStoryState();
    });

    sessionServices = GetIt.instance<SessionServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      token = sessionServices.getAccessToken();
      postProvider = context.read<PostProvider>();
    });
  }

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
          // create post button
          Consumer<PostProvider>(
            builder: (context, postProvider, child) {
              final imageFile = postProvider.pickedImage;

              // error
              if (postProvider.state.status == PostStatus.error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to create post. Please try again later.${postProvider.state.message}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onInverseSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  );
                });
              }

              // loading state
              if (postProvider.state.status == PostStatus.loading) {
                return Center(child: CircularProgressIndicator());
              }

              // success 
              if (postProvider.state.status == PostStatus.sucess) {
                // Handle post submission
                WidgetsBinding.instance.addPostFrameCallback((_) {
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
                  context.go(StoryAppRouter.splash);
                });
              }

              return TextButton(
                onPressed: postProvider.state.status == PostStatus.loading
                    ? null
                    : () {
                        postProvider.addStory(
                          token: token ?? '',
                          description: _descriptionController.text.isEmpty
                              ? ''
                              : _descriptionController.text,
                          photo: imageFile!,
                        );
                      },
                child: Text(
                  'Share',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            return Column(
              children: [
                // Image preview
                Container(
                  width: double.infinity,
                  height: 300,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();

                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Camera'),
                                  onTap: () async {
                                    Navigator.pop(context);

                                    final XFile? picked = await picker
                                        .pickImage(source: ImageSource.camera);

                                    if (picked == null) return;

                                    postProvider.setPickedImage(
                                      File(picked.path),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Gallery'),
                                  onTap: () async {
                                    Navigator.pop(context);

                                    final XFile? picked = await picker
                                        .pickImage(source: ImageSource.gallery);

                                    if (picked == null) return;

                                    postProvider.setPickedImage(
                                      File(picked.path),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: postProvider.pickedImage != null
                        ? Image.file(
                            postProvider.pickedImage!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 80,
                            color: theme.colorScheme.onSurface.withAlpha(
                              (0.4 * 255).round(),
                            ),
                          ),
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
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                        ),
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
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
