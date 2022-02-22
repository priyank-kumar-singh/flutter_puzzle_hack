


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Puzzle Hack';

  @override
  String get headerTitle => 'Flutter Puzzle Hack';

  @override
  String get themeChangeTooltip => 'Changing the theme will reset your score';

  @override
  String get restartTooltip => 'Restarting the puzzle will reset your score';

  @override
  String get numberOfMoves => 'Moves';

  @override
  String get numberOfTilesLeft => 'Tiles';

  @override
  String get startGame => 'Start Game';

  @override
  String get restart => 'Restart';

  @override
  String get getReady => 'Get ready...';

  @override
  String get waiting => 'Waiting...';

  @override
  String get bye => 'Bye...';

  @override
  String get next => 'Next';

  @override
  String get view => 'View';

  @override
  String get countdownGo => 'GO!';

  @override
  String tileLabelText(String value, String x, String y) {
    return 'Value: $value, position: $x, $y';
  }

  @override
  String numberOfMovesAndTilesLeftLabelText(String numberOfMoves, String tilesLeft) {
    return 'Moves: $numberOfMoves, tiles: $tilesLeft';
  }

  @override
  String durationLabelText(String hours, String minutes, String seconds) {
    return '$hours hours $minutes minutes $seconds seconds';
  }

  @override
  String get halloweenSemanticsLabel => 'Gia the Ghost';
}
