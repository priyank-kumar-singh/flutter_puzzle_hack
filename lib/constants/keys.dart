import 'package:flutter/widgets.dart';

/// The global keys of [Puzzle].
///
/// Used to animate the transition when changing a theme.
abstract class Keys {
  static final puzzleLogoKey = GlobalKey(debugLabel: 'puzzle_logo');
  static final puzzleNameKey = GlobalKey(debugLabel: 'puzzle_name');
  static final puzzleTitleKey = GlobalKey(debugLabel: 'puzzle_title');
  static final numberOfMovesAndTilesLeftKey = GlobalKey(debugLabel: 'number_of_moves_and_tiles_left');
  static final audioControlKey = GlobalKey(debugLabel: 'audio_control');
  static final settingsBtnKey = GlobalKey(debugLabel: 'settings_btn');
}
