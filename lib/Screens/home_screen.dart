import '../services/api_service.dart';
import 'package:flutter/material.dart';
import '../widgets/post_list_item.dart';
import '../blocs/post_blocs/post_state.dart';
import '../blocs/post_blocs/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/post_repository.dart';
import 'package:pratical_bloc_demo/screens/detail_screen.dart';
import 'package:pratical_bloc_demo/utils/local_storage_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(PostRepository(
        apiService: ApiService(),
        localStorageService: LocalStorageService(),
      ))
        ..fetchPosts(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  final isRead = state.readStatus[post.id] ?? false;

                  return PostListItem(
                    post: post,
                    isRead: isRead,
                    onTap: () {
                      context.read<PostCubit>().markPostAsRead(post.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(postId: post.id),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
