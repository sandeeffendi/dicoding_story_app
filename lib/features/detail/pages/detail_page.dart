import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_provider.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_state.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late SessionServices sessionServices;
  @override
  void initState() {
    super.initState();
    sessionServices = GetIt.instance<SessionServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = sessionServices.getAccessToken();
      context.read<DetailProvider>().getStoryById(token: token!, id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.postsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        ),
      ),

      body: SingleChildScrollView(
        child: Consumer<DetailProvider>(
          builder: (context, detailProvider, child) {
            // error state
            if (detailProvider.state.status == DetailStatus.error) {
              return Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.wifi_tethering_error_rounded_outlined,
                      size: 64,
                      color: Colors.red,
                    ),

                    Text('Caught an error ${detailProvider.state.message}'),

                    const SizedBox(height: 8),

                    ElevatedButton.icon(
                      onPressed: () {
                        detailProvider.getStoryById(
                          token: sessionServices.getAccessToken().toString(),
                          id: widget.id,
                        );
                      },
                      label: const Text('Retry'),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            }

            // loading state
            if (detailProvider.state.status == DetailStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // empty state
            if (detailProvider.storyData == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.inbox_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 64),
                    ElevatedButton(
                      onPressed: () => detailProvider.getStoryById(
                        token: sessionServices.getAccessToken().toString(),
                        id: widget.id,
                      ),
                      child: const Text('Load Story'),
                    ),
                  ],
                ),
              );
            }

            // success state
            return RefreshIndicator(
              onRefresh: () => detailProvider.getStoryById(
                token: sessionServices.getAccessToken().toString(),
                id: widget.id,
              ),
              child: Column(
                children: [
                  _BuildDetailPost(
                    context: context,
                    story: detailProvider.storyData!,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BuildDetailPost extends StatelessWidget {
  final BuildContext context;
  final StoryEntity story;

  const _BuildDetailPost({required this.context, required this.story});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(story.photoUrl),
              ),
              const SizedBox(width: 8),
              Text(story.name),
              const Spacer(),
              IconButton(
                onPressed: (story.lat == 0 && story.lon == 0)
                    ? () {}
                    : () {
                        context.push(
                          '${StoryAppRouter.location}/${story.lat}/${story.lon}',
                        );
                      },
                icon: Icon(
                  (story.lat == 0 && story.lon == 0)
                      ? Icons.more_vert
                      : Icons.location_pin,
                  color: (story.lat == 0 && story.lon == 0)
                      ? theme.colorScheme.onSurface
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),

        // story image
        Image.network(
          story.photoUrl,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
        ),

        // action buttons
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send_outlined,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_border,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        // caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.likedTitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mulyono ',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.andTitle,
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    ' Others',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // username
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${story.name} ',
                      style: theme.textTheme.bodyLarge?.copyWith(
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
                timeago.format(story.createdAt, locale: locale),
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
