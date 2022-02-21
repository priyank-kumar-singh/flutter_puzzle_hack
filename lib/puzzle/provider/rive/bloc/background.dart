import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

class RiveBackgroundBloc extends Bloc<RivebackgroundEvent, RivebackgroundState> {
  RiveBackgroundBloc() : super(const RivebackgroundInitial()) {
    on<RiveBackgroundUpdate>(_onRivebackgroundUpdate);
  }

  void registerTriggers(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'state_machine',
      onStateChange: (_, s) => _onStateChange(s),
    );
    artboard.addController(controller!);
  }

  void _onStateChange(String state) {
    switch (state) {
      case 'ExitState':
        add(const RiveBackgroundUpdate());
    }
  }

  void _onRivebackgroundUpdate(RiveBackgroundUpdate event, Emitter<RivebackgroundState> emit) {
    emit(const RivebackgroundFinal());
  }
}

// Rive background events
abstract class RivebackgroundEvent extends Equatable {
  const RivebackgroundEvent();

  @override
  List<Object> get props => [];
}

class RiveBackgroundUpdate extends RivebackgroundEvent {
  const RiveBackgroundUpdate();
}

// Rive background state
abstract class RivebackgroundState extends Equatable {
  const RivebackgroundState();

  @override
  List<Object> get props => [];
}

class RivebackgroundInitial extends RivebackgroundState {
  const RivebackgroundInitial();
}

class RivebackgroundFinal extends RivebackgroundState {
  const RivebackgroundFinal();
}
