import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:path/path.dart' as p;

import 'layout_delegate.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  const PuzzleTheme();

  /// The display name of this theme.
  String get name;

  /// Sub theme name
  String get subtheme;

  /// The text color of [name].
  Color get nameColor;

  /// The text color of the puzzle title.
  Color get titleColor;

  /// The background color of this theme.
  Color get backgroundColor;

  /// The default color of this theme.
  ///
  /// Applied to the text color of the score and
  /// the default background color of puzzle tiles.
  Color get defaultColor;

  /// The button color of this theme.
  ///
  /// Applied to the background color of buttons.
  Color get buttonColor;

  /// The hover color of this theme.
  ///
  /// Applied to the background color of a puzzle tile
  /// that is hovered over.
  Color get hoverColor;

  /// The pressed color of this theme.
  ///
  /// Applied to the background color of a puzzle tile
  /// that was pressed.
  Color get pressedColor;

  /// Whether Flutter logo is colored or white.
  ///
  /// Applied to the color of [AppLogo] displayed
  /// in the top left corner of the header.
  bool get isLogoColored;

  /// The active menu color.
  ///
  /// Applied to the text color of the currently active
  /// theme in menu.
  Color get menuActiveColor;

  /// The underline menu color.
  ///
  /// Applied to the underline of the currently active
  /// theme in menu, on a small layout.
  Color get menuUnderlineColor;

  /// The inactive menu color.
  ///
  /// Applied to the text color of the currently inactive
  /// theme in menu.
  Color get menuInactiveColor;

  /// The text color of the countdown timer.
  Color get countdownColor;

  /// The semantics label of this sub theme.
  String semanticsLabel(BuildContext context);

  /// The path to the image asset of this sub theme.
  ///
  /// This asset is shown in the Theme picker Asset
  String get themeAsset;

  /// The path to the success image asset of this sub theme.
  ///
  /// This asset is shown in the success state of the puzzle.
  String get successThemeAsset;

  /// The path to the audio asset of this sub theme.
  String get audioAsset;

  /// The path to the directory with assets for all puzzle tiles.
  String get assetsDirectory;

  /// The path to the dash asset for the given [tile].
  ///
  /// The puzzle consists of 15 Dash tiles which correct board positions
  /// are as follows:
  ///
  ///  1   2   3   4
  ///  5   6   7   8
  ///  9  10  11  12
  /// 13  14  15
  ///
  // /// The dash asset for the i-th tile may be found in the file i.png.

  String assetForTile(Tile tile) =>
      p.join(assetsDirectory, '${tile.value.toString()}.png');

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate;
}
