import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

class BombBloc extends Bloc<BombEvent, _BombState> {
  SMITrigger? _play, _explode, _stop, _reset;

  BombBloc() : super(const _BombState(BombState.idle)) {
    on<BombPlay>(_onBombPlay);
    on<BombExplode>(_onBombExplode);
    on<BombStop>(_onBombStop);
    on<BombReset>(_onBombReset);
  }

  void registerTriggers(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'state_machine_1',
      onStateChange: (_, s) => _onStateChange(s),
    );
    artboard.addController(controller!);
    _play = controller.findInput<bool>('play') as SMITrigger;
    _explode = controller.findInput<bool>('explode') as SMITrigger;
    _stop = controller.findInput<bool>('stop') as SMITrigger;
    _reset = controller.findInput<bool>('reset') as SMITrigger;
    controller.findInput<bool>('black_residue')?.value = true;
    _play?.fire();
  }

  void _onStateChange(String state) {
    switch (state) {
      case 'ExitState':
        add(const BombStop(fireMethod: false));
    }
  }

  void _onBombPlay(BombPlay event, Emitter<_BombState> emit) async {
    _play?.fire();
    emit(const _BombState(BombState.play));
  }

  void _onBombExplode(BombExplode event, Emitter<_BombState> emit) async {
    _explode?.fire();
    emit(const _BombState(BombState.explode));
  }

  void _onBombStop(BombStop event, Emitter<_BombState> emit) async {
    if (event.fireMethod) {
      _stop?.fire();
    }
    emit(const _BombState(BombState.exit));
  }

  void _onBombReset(BombReset event, Emitter<_BombState> emit) async {
    _reset?.fire();
    emit(const _BombState(BombState.idle));
  }
}

// Bomb bloc events
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


// Bomb bloc states
enum BombState { idle, play, explode, exit }

class _BombState extends Equatable {
  const _BombState(this.status);

  final BombState status;

  @override
  List<Object> get props => [status];
}
