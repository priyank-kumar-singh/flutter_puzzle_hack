import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

part 'bomb_event.dart';
part 'bomb_state.dart';

class BombBloc extends Bloc<BombEvent, BombState> {
  SMITrigger? play, explode, stop, reset;

  BombBloc() : super(const BombIdle()) {
    on<BombEvent>((event, emit) {
      on<BombTrigger>(_onBombTriggerSelected);
    });
  }

  void _onBombTriggerSelected(BombTrigger event, Emitter<BombState> emit) {
    BombState newState;
    switch (event.trigger) {
      case 'play':
        play?.fire();
        newState = const BombPlay();
        break;
      case 'explode':
        explode?.fire();
        newState = const BombExplode();
        break;
      case 'stop':
        stop?.fire();
        newState = const BombExit();
        break;
      default:
        reset?.fire();
        newState = const BombIdle();
        break;
    }
    emit(newState);
  }
}
