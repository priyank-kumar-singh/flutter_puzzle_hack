part of 'bomb_bloc.dart';

abstract class BombState extends Equatable {
  const BombState();

  @override
  List<Object> get props => [];
}

class BombIdle extends BombState {
  const BombIdle();
}

class BombPlay extends BombState {
  const BombPlay();
}

class BombExplode extends BombState {
  const BombExplode();
}

class BombExit extends BombState {
  const BombExit();
}
