// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_puzzle_hack/puzzle/puzzle.dart';

// part 'theme_event.dart';
// part 'theme_state.dart';

// /// {@template dashatar_theme_bloc}
// /// Bloc responsible for the currently selected [Theme].
// /// {@endtemplate}
// class MyThemeBlocOne extends Bloc<MyThemeEvent, MyThemeState> {
//   /// {@macro dashatar_theme_bloc}
//   MyThemeBlocOne({required PuzzleTheme inititalTheme, required List<PuzzleTheme> themes})
//       : super(MyThemeState(theme: inititalTheme, themes: themes)) {
//     on<PuzzleThemeChanged>(_onThemeChanged);
//   }

//   void _onThemeChanged(
//     PuzzleThemeChanged event,
//     Emitter<MyThemeState> emit,
//   ) {
//     emit(state.copyWith(theme: state.themes[event.themeIndex]));
//   }
// }

// /// {@template dashatar_theme_bloc}
// /// Bloc responsible for the currently selected [Theme].
// /// {@endtemplate}
// class MyThemeBlocTwo extends Bloc<MyThemeEvent, MyThemeState> {
//   /// {@macro dashatar_theme_bloc}
//   MyThemeBlocTwo({required PuzzleTheme inititalTheme, required List<PuzzleTheme> themes})
//       : super(MyThemeState(theme: inititalTheme, themes: themes)) {
//     on<PuzzleThemeChanged>(_onThemeChanged);
//   }

//   void _onThemeChanged(
//     PuzzleThemeChanged event,
//     Emitter<MyThemeState> emit,
//   ) {
//     emit(state.copyWith(theme: state.themes[event.themeIndex]));
//   }
// }
