part of 'rivebackground_bloc.dart';

abstract class RivebackgroundEvent extends Equatable {
  const RivebackgroundEvent();

  @override
  List<Object> get props => [];
}

class RiveBackgroundUpdate extends RivebackgroundEvent {
  const RiveBackgroundUpdate();
}
