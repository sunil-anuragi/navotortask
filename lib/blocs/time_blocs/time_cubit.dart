import 'dart:async';
import 'time_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  int _tickInterval = 1000; // Tick interval is 1 second (1000 ms)

  TimerCubit() : super(TimerState(remainingTimeMap: {}, pausedPostIds: {}));

  // Start the timer for a specific postId
  void startTimer(int postId, int initialTime) {
    if (!state.pausedPostIds.contains(postId) &&
        !state.remainingTimeMap.containsKey(postId)) {
      // Initialize the post time and start the ticking
      final updatedTimeMap = Map<int, int>.from(state.remainingTimeMap);
      updatedTimeMap[postId] = initialTime;

      emit(state.copyWith(remainingTimeMap: updatedTimeMap));
      _startTicking();
    }
  }

  // Pause the timer for a specific postId
  void pauseTimer(int postId) {
    final updatedPausedPostIds = Set<int>.from(state.pausedPostIds)
      ..add(postId);
    emit(state.copyWith(pausedPostIds: updatedPausedPostIds));
  }

  // Reset the timer for a specific postId
  void resetTimer(int postId) {
    final updatedTimeMap = Map<int, int>.from(state.remainingTimeMap)
      ..remove(postId);
    emit(state.copyWith(remainingTimeMap: updatedTimeMap));
  }

  // Decrease the remaining time for all active timers
  void tick() {
    // Make a copy of the remainingTimeMap before modifying it
    final updatedTimeMap = Map<int, int>.from(state.remainingTimeMap);

    updatedTimeMap.forEach((postId, remainingTime) {
      if (!state.pausedPostIds.contains(postId) && remainingTime > 0) {
        updatedTimeMap[postId] = remainingTime - 1;
      } else if (remainingTime == 0) {
        updatedTimeMap.remove(postId);
        pauseTimer(postId); // Mark as paused when time is up
      }
    });

    // Emit the updated state with the modified map
    emit(state.copyWith(remainingTimeMap: updatedTimeMap));
  }

  // Start ticking the timer every second
  void _startTicking() {
    _timer = Timer.periodic(Duration(milliseconds: _tickInterval), (timer) {
      tick();
    });
  }

  // Stop the timer
  void _stopTicking() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stopTicking();
    return super.close();
  }
}
