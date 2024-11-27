import 'post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/post_repository.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;

  PostCubit(this.postRepository) : super(PostState.initial());

  Future<void> fetchPosts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final posts = await postRepository.getPosts();

      final readStatus = {for (var post in posts) post.id: false};
      emit(state.copyWith(
          isLoading: false, posts: posts, readStatus: readStatus));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void markPostAsRead(int postId) async {
    try {
      await postRepository.markPostAsRead(postId);
      final updatedReadStatus = Map<int, bool>.from(state.readStatus);
      updatedReadStatus[postId] = true;
      emit(state.copyWith(readStatus: updatedReadStatus));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
