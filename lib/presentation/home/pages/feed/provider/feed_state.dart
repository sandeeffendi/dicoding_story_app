import 'package:intermediate_first_submission/domain/enitities/story/story_entity.dart';

enum FeedStatus { initial, loading, success, error }

class FeedState {
  final FeedStatus status;
  final String? message;
  final StoryEntity? storyData;

  const FeedState({
    this.status = FeedStatus.initial,
    this.message,
    this.storyData,
  });

  bool get isLoading => status == FeedStatus.loading;
  bool get isError => status == FeedStatus.error;
  bool get isSuccess => status == FeedStatus.success;

  FeedState copyWith({
    FeedStatus? status,
    String? message,
    StoryEntity? storyData,
  }) {
    return FeedState(
      status: status ?? this.status,
      message: message ?? this.message,
      storyData: storyData,
    );
  }
}
