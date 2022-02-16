import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../themes/dashatar/dashatar_theme.dart';
import '../themes/dashatar/green_dashatar_theme.dart';

part 'dashatar_theme_event.dart';
part 'dashatar_theme_state.dart';

/// {@template dashatar_theme_bloc}
/// Bloc responsible for the currently selected [DashatarTheme].
/// {@endtemplate}
class DashatarThemeBloc extends Bloc<DashatarThemeEvent, DashatarThemeState> {
  /// {@macro dashatar_theme_bloc}
  DashatarThemeBloc({required List<DashatarTheme> themes})
      : super(DashatarThemeState(themes: themes)) {
    on<DashatarThemeChanged>(_onDashatarThemeChanged);
  }

  void _onDashatarThemeChanged(
    DashatarThemeChanged event,
    Emitter<DashatarThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}