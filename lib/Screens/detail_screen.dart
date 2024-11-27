import '../models/post_model.dart';
import '../services/api_service.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int postId;

  const DetailScreen({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post $postId')),
      body: FutureBuilder<Post>(
        future: ApiService().fetchPostDetail(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.body),
            );
          } else {
            return const Center(child: Text('No Data Found'));
          }
        },
      ),
    );
  }
}
