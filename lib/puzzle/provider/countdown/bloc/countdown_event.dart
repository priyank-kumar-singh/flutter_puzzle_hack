part of 'countdown_bloc.dart';

abstract class CountdownEvent extends Equatable {
  const CountdownEvent();

  @override
  List<Object?> get props => [];
}

class CountdownStarted extends CountdownEvent {
  const CountdownStarted();
}

class CountdownTicked extends CountdownEvent {
  const CountdownTicked();
}

class CountdownStopped extends CountdownEvent {
  const CountdownStopped();
}

class CountdownReset extends CountdownEvent {
  const CountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [CountdownBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
