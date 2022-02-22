import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

class RiveAnchorBloc extends Bloc<RiveAnchorEvent, RiveAnchorState> {
  SMITrigger? _play, _reset, _restart;
  int? _storyInitial, _storyFinale;

  RiveAnchorBloc() : super(const RiveAnchorState()) {
    on<RiveAnchorPlay>(_onAnchorFly);
    on<RiveAnchorReset>(_onAnchorReset);
    on<RiveAnchorStoryForward>(_onStoryForward);
  }

  void registerStoryCount(int initial, int end) {
    _storyInitial = initial;
    _storyFinale = end;
  }

  void registerTriggers(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);
    _play = controller.findInput<bool>('bat') as SMITrigger;
    _restart = controller.findInput<bool>('restart') as SMITrigger;
    _reset = controller.findInput<bool>('reset') as SMITrigger;
    _play?.fire();
  }

  void _onAnchorFly(RiveAnchorPlay event, Emitter<RiveAnchorState> emit) async {
    if (state.status == RiveAnchorStatus.flying || state.status == RiveAnchorStatus.flyingIdle) {
      emit(const RiveAnchorState());
      _restart?.fire();
      await Future.delayed(const Duration(milliseconds: 3000));
      emit(const RiveAnchorState(diagIndex: 0, status: RiveAnchorStatus.flying));
    } else {
      _play?.fire();
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(const RiveAnchorState(diagIndex: 0, status: RiveAnchorStatus.flying));
    }

  }

  void _onAnchorReset(RiveAnchorReset event, Emitter<RiveAnchorState> emit) async {
    _reset?.fire();
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(const RiveAnchorState());
  }

  void _onStoryForward(RiveAnchorStoryForward event, Emitter<RiveAnchorState> emit) async {
    if (state.status == RiveAnchorStatus.flying) {
      if (state.diagIndex + 1 == _storyInitial) {
        emit(state.newState(RiveAnchorStatus.flyingIdle));
      } else {
        emit(state.from(index: state.diagIndex + 1));
      }
    } else if (state.status == RiveAnchorStatus.flyingIdle) {
      _reset?.fire();
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(state.from(index: 0, status: RiveAnchorStatus.backToLaszlow));
    } else if (state.status == RiveAnchorStatus.backToLaszlow) {
      if (state.diagIndex + 1 == _storyFinale) {
        _play?.fire();
        await Future.delayed(const Duration(milliseconds: 2000));
        emit(state.newState(RiveAnchorStatus.exit));
      } else {
        emit(state.from(index: state.diagIndex + 1));
      }
    }
  }
}

// Rive anchor Events
abstract class RiveAnchorEvent extends Equatable {
  const RiveAnchorEvent();

  @override
  List<Object> get props => [];
}

class RiveAnchorPlay extends RiveAnchorEvent {
  const RiveAnchorPlay();
}

class RiveAnchorReset extends RiveAnchorEvent {
  const RiveAnchorReset();
}

class RiveAnchorStoryForward extends RiveAnchorEvent {
  const RiveAnchorStoryForward();
}


// Rive Anchor States
enum RiveAnchorStatus {idle, flying, flyingIdle, backToLaszlow, exit}

class RiveAnchorState extends Equatable {
  const RiveAnchorState({this.diagIndex = -1, this.status = RiveAnchorStatus.idle});

  final int diagIndex;
  final RiveAnchorStatus status;

  @override
  List<Object> get props => [diagIndex, status];

  RiveAnchorState from({int? index, RiveAnchorStatus? status}) {
    return RiveAnchorState(
      diagIndex: index ?? diagIndex,
      status: status ?? this.status,
    );
  }

  RiveAnchorState newState(RiveAnchorStatus status) {
    return RiveAnchorState(status: status);
  }
}
