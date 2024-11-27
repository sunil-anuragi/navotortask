import 'package:flutter/material.dart';
import '../blocs/time_blocs/time_cubit.dart';
import '../blocs/time_blocs/time_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerIcon extends StatelessWidget {
  final int postId;

  const TimerIcon({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        final remainingTime = state.remainingTimeMap[postId] ?? 0;
        final isPaused = state.pausedPostIds.contains(postId);

        return Text('$remainingTime s');
      },
    );
  }
}
