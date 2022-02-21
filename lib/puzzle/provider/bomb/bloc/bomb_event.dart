part of 'bomb_bloc.dart';

abstract class BombEvent extends Equatable {
  const BombEvent();

  @override
  List<Object> get props => [];
}

class BombPlay extends BombEvent {
  const BombPlay();
}

class BombExplode extends BombEvent {
  const BombExplode();
}

class BombStop extends BombEvent {
  const BombStop({this.fireMethod = true});

  final bool fireMethod;

  @override
  List<Object> get props => [fireMethod];
}

class BombReset extends BombEvent {
  const BombReset();
}
