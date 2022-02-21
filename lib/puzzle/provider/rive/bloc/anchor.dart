import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

class RiveAnchorBloc extends Bloc<RiveAnchorEvent, RiveAnchorState> {
  SMITrigger? _play, _stop, _reset;
  List<String>? storyInitial, storyEnd;
  int currentDialogue = -1;

  RiveAnchorBloc() : super(const RiveAnchorIdle()) {
    on<RiveAnchorPlay>(_onAnchorFly);
    on<RiveAnchorReset>(_onAnchorReset);
    on<RiveAnchorStoryForward>(_onStoryForward);
    on<RiveAnchorStoryToEnd>(_onStoryToEnd);
  }

  void registerSpeech(List<String> storyInitial, storyEnd) {
    this.storyInitial = storyInitial;
    this.storyEnd = storyEnd;
  }

  void registerTriggers(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'state_machine',
    );
    artboard.addController(controller!);
    _play = controller.findInput<bool>('bat') as SMITrigger;
    _stop = controller.findInput<bool>('stop') as SMITrigger;
    _reset = controller.findInput<bool>('reset') as SMITrigger;
  }

  void _onAnchorFly(RiveAnchorPlay event, Emitter<RiveAnchorState> emit) {
    _play?.fire();
    emit(const RiveanchorFlying());
  }

  void _onAnchorReset(RiveAnchorReset event, Emitter<RiveAnchorState> emit) {
    currentDialogue = -1;
    _reset?.fire();
    emit(const RiveAnchorIdle());
  }

  void _onStoryForward(RiveAnchorStoryForward event, Emitter<RiveAnchorState> emit) {
    if (++currentDialogue == storyInitial?.length) {
      currentDialogue = -1;
      emit(const RiveAnchorStoryPause());
    } else {
      emit(RiveAnchorStoryStart(currentDialogue));
    }
  }

  void _onStoryToEnd(RiveAnchorStoryToEnd event, Emitter<RiveAnchorState> emit) {
    if (currentDialogue == -1) {
      _reset?.fire();
    }
    if (++currentDialogue == storyInitial?.length) {
      currentDialogue = 0;
      emit(const RiveAnchorExit());
    } else {
      emit(RiveAnchorStoryEnd(currentDialogue));
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

class RiveAnchorStoryForward extends RiveAnchorEvent {
  const RiveAnchorStoryForward();
}

class RiveAnchorStoryToEnd extends RiveAnchorEvent {
  const RiveAnchorStoryToEnd();
}

class RiveAnchorReset extends RiveAnchorEvent {
  const RiveAnchorReset();
}

// Rive Anchor States
abstract class RiveAnchorState extends Equatable {
  const RiveAnchorState([this.currentDialogue = 0]);

  final int currentDialogue;

  @override
  List<Object> get props => [currentDialogue];
}

class RiveAnchorIdle extends RiveAnchorState {
  const RiveAnchorIdle();
}

class RiveanchorFlying extends RiveAnchorState {
  const RiveanchorFlying() : super(-1);
}

class RiveAnchorStoryStart extends RiveAnchorState {
  const RiveAnchorStoryStart(int index) : super(index);
}

class RiveAnchorStoryPause extends RiveAnchorState {
  const RiveAnchorStoryPause() : super(-1);
}

class RiveAnchorStoryEnd extends RiveAnchorState {
  const RiveAnchorStoryEnd(int index) : super(index);
}

class RiveAnchorExit extends RiveAnchorState {
  const RiveAnchorExit() : super(-1);
}
