part of 'theme_bloc.dart';

class PuzzleThemeState extends Equatable {
  const PuzzleThemeState({
    required this.themes,
    required this.theme,
  });

  /// The list of all available [DashatarTheme]s.
  final List<PuzzleTheme> themes;

  /// Currently selected [DashatarTheme].
  final PuzzleTheme theme;

  @override
  List<Object> get props => [themes, theme];

  PuzzleThemeState copyWith({
    List<PuzzleTheme>? themes,
    PuzzleTheme? theme,
  }) {
    return PuzzleThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
