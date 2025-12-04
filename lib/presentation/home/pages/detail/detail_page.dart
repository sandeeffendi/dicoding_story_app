import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late StoryEntity story;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(callback)
    
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        ),
      ),

      body: _BuildDetailPost(context: context,, story: null,),
    );
  }
}

class _BuildDetailPost extends StatelessWidget {
  final BuildContext context;
  final StoryEntity story;

  const _BuildDetailPost({required this.context, required this.story});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(children: [CircleAvatar(radius: 16)]),
        ),
      ],
    );
  }
}
