import '../../models/post_model.dart';
import '../services/api_service.dart';
import '../utils/local_storage_service.dart';

class PostRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  PostRepository({required this.apiService, required this.localStorageService});

  /// Fetch posts from local storage or API
  Future<List<Post>> getPosts() async {
    try {
      final localPosts = await localStorageService.loadPosts();
      if (localPosts.isNotEmpty)
        return localPosts; // Return local posts if available

      final remotePosts = await apiService.fetchPosts();
      await localStorageService
          .savePosts(remotePosts); // Save remote posts locally
      return remotePosts;
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  /// Fetch details of a single post
  Future<Post> getPostDetail(int postId) async {
    try {
      return await apiService.fetchPostDetail(postId);
    } catch (e) {
      throw Exception('Failed to load post details: $e');
    }
  }

  /// Mark a post as read in local storage
  Future<void> markPostAsRead(int postId) async {
    try {
      await localStorageService.markAsRead(postId);
    } catch (e) {
      throw Exception('Failed to mark post as read: $e');
    }
  }
}
