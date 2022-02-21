


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get puzzleChangeTooltip => 'Changing the theme will reset your score';

  @override
  String get puzzleRestartTooltip => 'Restarting the puzzle will reset your score';

  @override
  String get puzzleChallengeTitle => 'Puzzle Challenge';

  @override
  String get puzzleNumberOfMoves => 'Moves';

  @override
  String get puzzleNumberOfTilesLeft => 'Tiles';

  @override
  String get puzzleShuffle => 'Shuffle';

  @override
  String get puzzleCompleted => 'Well done. Congrats!';

  @override
  String get dashatarStartGame => 'Start Game';

  @override
  String get dashatarGetReady => 'Get ready...';

  @override
  String get dashatarRestart => 'Restart';

  @override
  String get dashatarCountdownGo => 'GO!';

  @override
  String get dashatarSuccessCompleted => 'Puzzle challenge completed';

  @override
  String get dashatarSuccessWellDone => 'Well done.\nCongrats!';

  @override
  String get dashatarSuccessScore => 'Score';

  @override
  String dashatarSuccessNumberOfMoves(String numberOfMoves) {
    return '$numberOfMoves Moves';
  }

  @override
  String puzzleTileLabelText(String value, String x, String y) {
    return 'Value: $value, position: $x, $y';
  }

  @override
  String puzzleNumberOfMovesAndTilesLeftLabelText(String numberOfMoves, String tilesLeft) {
    return 'Moves: $numberOfMoves, tiles: $tilesLeft';
  }

  @override
  String puzzleDurationLabelText(String hours, String minutes, String seconds) {
    return '$hours hours $minutes minutes $seconds seconds';
  }

  @override
  String get dashatarBlueDashLabelText => 'Dumbbell Dash';

  @override
  String get dashatarGreenDashLabelText => 'Skateboard Dash';

  @override
  String get dashatarYellowDashLabelText => 'Sandwich Dash';

  @override
  String get dashatarSuccessShareYourScoreTitle => 'Share your score!';

  @override
  String get dashatarSuccessShareYourScoreMessage => 'Share this puzzle to challenge your friends and be sure to check out the Flutter Puzzle Hack.';

  @override
  String get dashatarSuccessShareText => 'Just solved the #FlutterPuzzleHack! Check it out ↓';
}
