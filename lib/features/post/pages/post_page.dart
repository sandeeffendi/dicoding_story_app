// create post page
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/features/post/provider/post_provider.dart';
import 'package:intermediate_first_submission/features/post/provider/post_state.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
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
      context.read<PostProvider>().clearSelectedLocation();
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
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.newPostTitle,
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
                return const Center(child: CircularProgressIndicator());
              }

              // success
              if (postProvider.state.status == PostStatus.sucess) {
                // Handle post submission
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        // todo: add localization
                        AppLocalizations.of(context)!.postCreatedTitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onInverseSurface,
                        ),
                      ),
                    ),
                  );
                  postProvider.resetAddStoryState();
                  context.go(StoryAppRouter.feed, extra: true);
                });
              }

              // empty state
              if (imageFile == null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    AppLocalizations.of(context)!.shareTitle,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return TextButton(
                onPressed: postProvider.state.status == PostStatus.loading
                    ? null
                    : () async {
                        await postProvider.addStory(
                          token: token ?? '',
                          description: _descriptionController.text.isEmpty
                              ? ''
                              : _descriptionController.text,
                          photo: imageFile,
                          lat: postProvider.selectedLat,
                          lon: postProvider.selectedLon,
                        );
                      },
                child: Text(
                  AppLocalizations.of(context)!.shareTitle,
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
                                  leading: const Icon(Icons.camera_alt),
                                  title: Text(
                                    AppLocalizations.of(context)!.cameraTitle,
                                  ),
                                  onTap: () async {
                                    context.pop();

                                    final XFile? picked = await picker
                                        .pickImage(source: ImageSource.camera);

                                    if (picked == null) return;

                                    postProvider.setPickedImage(
                                      File(picked.path),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: Text(
                                    AppLocalizations.of(context)!.galleryTitle,
                                  ),
                                  onTap: () async {
                                    context.pop();

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
                      hintText: AppLocalizations.of(context)!.writeCaptionTitle,
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

                // add location button
                ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.onSurface,
                  ),
                  title: Text(
                    postProvider.selectedLocationName ??
                        AppLocalizations.of(context)!.addLocationTitle,
                    style: theme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: postProvider.selectedLat != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${postProvider.selectedLat}, ${postProvider.selectedLon}',
                            style: theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      : null,
                  trailing: Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurface,
                  ),
                  onTap: () {
                    // Handle location selection
                    context.push(StoryAppRouter.postLocation);
                  },
                ),

                // preview google maps if user has location data
                if (postProvider.selectedLat != null &&
                    postProvider.selectedLon != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            postProvider.selectedLat!,
                            postProvider.selectedLon!,
                          ),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('selected-location'),
                            position: LatLng(
                              postProvider.selectedLat!,
                              postProvider.selectedLon!,
                            ),
                          ),
                        },
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        liteModeEnabled: true, // Mode lite untuk preview statis
                      ),
                    ),
                  ),

                  // remove story location button
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 70,
                      right: 70,
                      bottom: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        postProvider.clearSelectedLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.removeLocationTitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
