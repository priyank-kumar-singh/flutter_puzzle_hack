part of 'my_puzzle_bloc.dart';

abstract class MyPuzzleEvent extends Equatable {
  const MyPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class PuzzleCountdownStarted extends MyPuzzleEvent {
  const PuzzleCountdownStarted();
}

class PuzzleCountdownTicked extends MyPuzzleEvent {
  const PuzzleCountdownTicked();
}

class PuzzleCountdownStopped extends MyPuzzleEvent {
  const PuzzleCountdownStopped();
}

class PuzzleCountdownReset extends MyPuzzleEvent {
  const PuzzleCountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [MyPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
