part of 'bomb_bloc.dart';

abstract class BombEvent extends Equatable {
  const BombEvent();

  @override
  List<Object> get props => [];
}

class BombTrigger extends BombEvent {
  const BombTrigger(this.trigger);

  final String trigger;

  @override
  List<Object> get props => [trigger];
}
