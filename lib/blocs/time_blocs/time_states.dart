class TimerState {
  final Map<int, int> remainingTimeMap; // Map of remaining time for each post
  final Set<int> pausedPostIds; // Set of paused post IDs

  TimerState({required this.remainingTimeMap, required this.pausedPostIds});

  TimerState copyWith(
      {Map<int, int>? remainingTimeMap, Set<int>? pausedPostIds}) {
    return TimerState(
      remainingTimeMap: remainingTimeMap ?? this.remainingTimeMap,
      pausedPostIds: pausedPostIds ?? this.pausedPostIds,
    );
  }
}
