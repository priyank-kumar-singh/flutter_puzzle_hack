import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../puzzle_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// {@template dashatar_theme_bloc}
/// Bloc responsible for the currently selected [DashatarTheme].
/// {@endtemplate}
class PuzzleThemeBloc extends Bloc<PuzzleThemeEvent, PuzzleThemeState> {
  /// {@macro dashatar_theme_bloc}
  PuzzleThemeBloc({required PuzzleTheme inititalTheme, required List<PuzzleTheme> themes})
      : super(PuzzleThemeState(theme: inititalTheme, themes: themes)) {
    on<PuzzleThemeChanged>(_onDashatarThemeChanged);
  }

  void _onDashatarThemeChanged(
    PuzzleThemeChanged event,
    Emitter<PuzzleThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
