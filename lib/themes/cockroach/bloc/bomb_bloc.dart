import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

part 'bomb_event.dart';
part 'bomb_state.dart';

class BombBloc extends Bloc<BombEvent, BombState> {
  SMITrigger? _play, _explode, _stop, _reset;

  BombBloc() : super(const BombState(BombStatus.idle)) {
    on<BombPlay>(_onBombPlay);
    on<BombExplode>(_onBombExplode);
    on<BombStop>(_onBombStop);
    on<BombReset>(_onBombReset);
  }

  void registerTriggers(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'state_machine_1',
      onStateChange: (_, s) => onStateChange(s),
    );
    artboard.addController(controller!);
    _play = controller.findInput<bool>('play') as SMITrigger;
    _explode = controller.findInput<bool>('explode') as SMITrigger;
    _stop = controller.findInput<bool>('stop') as SMITrigger;
    _reset = controller.findInput<bool>('reset') as SMITrigger;
    controller.findInput<bool>('black_residue')?.value = true;
    _play?.fire();
  }

  void onStateChange(String state) {
    switch (state) {
      case 'ExitState':
        add(const BombStop(fireMethod: false));
    }
  }

  void _onBombPlay(BombPlay event, Emitter<BombState> emit) async {
    _play?.fire();
    emit(const BombState(BombStatus.play));
  }

  void _onBombExplode(BombExplode event, Emitter<BombState> emit) async {
    _explode?.fire();
    emit(const BombState(BombStatus.explode));
  }

  void _onBombStop(BombStop event, Emitter<BombState> emit) async {
    if (event.fireMethod) {
      _stop?.fire();
    }
    emit(const BombState(BombStatus.exit));
  }

  void _onBombReset(BombReset event, Emitter<BombState> emit) async {
    _reset?.fire();
    emit(const BombState(BombStatus.idle));
  }
}
