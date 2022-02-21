import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rive/rive.dart';

part 'rivebackground_event.dart';
part 'rivebackground_state.dart';

class RivebackgroundBloc extends Bloc<RivebackgroundEvent, RivebackgroundState> {
  RivebackgroundBloc() : super(const RivebackgroundInitial()) {
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
