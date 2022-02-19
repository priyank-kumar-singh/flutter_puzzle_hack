part of 'theme_bloc.dart';

abstract class PuzzleThemeEvent extends Equatable {
  const PuzzleThemeEvent();
}

class PuzzleThemeChanged extends PuzzleThemeEvent {
  const PuzzleThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [PuzzleThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
