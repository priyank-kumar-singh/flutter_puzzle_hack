part of 'bomb_bloc.dart';

enum BombState { idle, play, explode, exit }

class _BombState extends Equatable {
  const _BombState(this.status);

  final BombState status;

  @override
  List<Object> get props => [status];
}
