import '../models/post_model.dart';
import 'package:flutter/material.dart';
import '../blocs/time_blocs/time_cubit.dart';
import 'package:pratical_bloc_demo/widgets/timer_icon.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final bool isRead;
  final VoidCallback onTap;

  const PostListItem({
    required this.post,
    required this.isRead,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(10),
          color: isRead ? Colors.white : Colors.yellow[100],
          child: Row(
            children: [
              Expanded(child: Text(post.title)),
              TimerIcon(postId: post.id), // Display the timer icon
            ],
          ),
        ),
      ),
    );
  }
}
