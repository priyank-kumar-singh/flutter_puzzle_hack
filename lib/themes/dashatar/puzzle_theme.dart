import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/asset.dart';
import 'package:flutter_puzzle_hack/models/models.dart';
import 'package:flutter_puzzle_hack/puzzle/puzzle.dart';
import 'package:path/path.dart' as p;

import 'layout_delegate.dart';

/// {@template dashatar_theme}
/// The dashatar puzzle theme.
/// {@endtemplate}
abstract class DashatarTheme extends PuzzleTheme {
  const DashatarTheme() : super();

  @override
  String get name => 'Dashatar';

  @override
  Color get nameColor => ThemeConstants.white;

  @override
  Color get titleColor => ThemeConstants.white;

  @override
  Color get hoverColor => ThemeConstants.black2;

  @override
  Color get pressedColor => ThemeConstants.white2;

  @override
  bool get isLogoColored => false;

  @override
  Color get menuActiveColor => ThemeConstants.white;

  @override
  Color get menuUnderlineColor => ThemeConstants.white;

  /// The text color of the countdown timer.
  @override
  Color get countdownColor => ThemeConstants.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const DashatarPuzzleLayoutDelegate();

  @override
  String get themeAsset => AssetImages.dashatar + '$subtheme.png';

  @override
  String get successThemeAsset => AssetImages.dashatar + '${subtheme}_success.png';

  @override
  String get assetsDirectory => 'assets/images/dashatar/$subtheme/';

  @override
  String assetForTile(Tile tile) => p.join(assetsDirectory, '${tile.value.toString()}.png');

  @override
  List<Object?> get props => [
        name,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        layoutDelegate,
        countdownColor,
        themeAsset,
        successThemeAsset,
        audioAsset,
        assetsDirectory
      ];
}
