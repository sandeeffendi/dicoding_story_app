import 'package:intermediate_first_submission/core/domain/enitities/story/story_entity.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState {
  final HomeStatus status;
  final String? message;
  final StoryEntity? storyData;

  const HomeState({
    this.status = HomeStatus.initial,
    this.message,
    this.storyData,
  });

  bool get isLoading => status == HomeStatus.loading;
  bool get isError => status == HomeStatus.error;
  bool get isSuccess => status == HomeStatus.success;

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    StoryEntity? storyData,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      storyData: storyData,
    );
  }
}
