part of 'bomb_bloc.dart';

enum BombStatus { idle, play, explode, exit }

class BombState extends Equatable {
  const BombState(this.status);

  final BombStatus status;

  @override
  List<Object> get props => [status.name];
}
