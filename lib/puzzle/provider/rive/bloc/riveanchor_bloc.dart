import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'riveanchor_event.dart';
part 'riveanchor_state.dart';

class RiveanchorBloc extends Bloc<RiveanchorEvent, RiveanchorState> {
  RiveanchorBloc() : super(RiveanchorInitial()) {
    
  }
}
