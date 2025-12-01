enum PostStatus { initial, loading, sucess, error }

class PostState {
  final PostStatus status;
  final String? message;

  const PostState({this.status = PostStatus.initial, this.message});

  bool get isLoading => status == PostStatus.loading;
  bool get isError => status == PostStatus.error;
  bool get isSuccess => status == PostStatus.sucess;

  PostState copyWith({PostStatus? status, String? message}) {
    return PostState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
