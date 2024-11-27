import '../../models/post_model.dart';

class PostState {
  final bool isLoading;
  final List<Post> posts;
  final Map<int, bool> readStatus;
  final String? error;

  PostState({
    required this.isLoading,
    required this.posts,
    required this.readStatus,
    this.error,
  });

  PostState copyWith({
    bool? isLoading,
    List<Post>? posts,
    Map<int, bool>? readStatus,
    String? error,
    Map<int, int>? remainingTimeMap,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      readStatus: readStatus ?? this.readStatus,
      error: error,
    );
  }

  // Initial state
  factory PostState.initial() {
    return PostState(
      isLoading: false,
      posts: [],
      readStatus: {},
      error: null,
    );
  }
}
