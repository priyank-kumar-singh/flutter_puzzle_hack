import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_puzzle_hack/models/models.dart';

part 'my_puzzle_event.dart';
part 'my_puzzle_state.dart';

/// {@template dashatar_puzzle_bloc}
/// A bloc responsible for starting the puzzle.
/// {@endtemplate}
class MyPuzzleBloc
    extends Bloc<MyPuzzleEvent, MyPuzzleState> {
  /// {@macro dashatar_puzzle_bloc}
  MyPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(MyPuzzleState(secondsToBegin: secondsToBegin)) {
    on<PuzzleCountdownStarted>(_onCountdownStarted);
    on<PuzzleCountdownTicked>(_onCountdownTicked);
    on<PuzzleCountdownStopped>(_onCountdownStopped);
    on<PuzzleCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const PuzzleCountdownTicked()));
  }

  void _onCountdownStarted(
    PuzzleCountdownStarted event,
    Emitter<MyPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    PuzzleCountdownTicked event,
    Emitter<MyPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    PuzzleCountdownStopped event,
    Emitter<MyPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    PuzzleCountdownReset event,
    Emitter<MyPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
