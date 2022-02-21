part of 'countdown_bloc.dart';

/// The status of [CountdownState].
enum MyPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

class CountdownState extends Equatable {
  const CountdownState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  MyPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? MyPuzzleStatus.loading
      : (secondsToBegin == 0
          ? MyPuzzleStatus.started
          : MyPuzzleStatus.notStarted);

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  CountdownState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return CountdownState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
