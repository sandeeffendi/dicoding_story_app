import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';

enum DetailStatus { initial, loading, success, error }

class DetailState {
  final DetailStatus status;
  final String? message;
  final StoryEntity? storyData;

  DetailState({
    this.status = DetailStatus.initial,
    this.message,
    this.storyData,
  });

  bool get isLoading => status == DetailStatus.loading;
  bool get isError => status == DetailStatus.error;
  bool get isSuccess => status == DetailStatus.success;

  DetailState copyWith({
    DetailStatus? status,
    String? message,
    StoryEntity? storyData,
  }) {
    return DetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      storyData: storyData ?? this.storyData,
    );
  }
}
