part of 'rivebackground_bloc.dart';

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
