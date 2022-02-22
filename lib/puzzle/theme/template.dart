import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/themes/constants.dart';
import 'package:flutter_puzzle_hack/puzzle/layout/default.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../layout/template.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  PuzzleTheme({List<String>? storyline, List<String>? endStory, List<String>? tips}) {
    _tiles = ImageHelper.split(themeAsset, gridSize);
    this.storyline = storyline ?? [];
    this.endStory = endStory ?? [];
    this.tips = tips ?? [];
  }

  // List of splitted tile images
  late final List<Uint8List> _tiles;

  late final List<String> storyline;

  late final List<String> endStory;

  int get shuffleLine => storyline.length - 1;

  late final List<String> tips;

  /// The display name of this theme.
  String get name;

  /// The text color of [name].
  Color get nameColor;

  /// The text color of the puzzle title.
  Color get titleColor;

  /// The background color of this theme.
  Color get backgroundColor;

  /// Background image
  String? get backgroundImage => null;

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

  /// TextStyle for numbers displayed over the tiles
  TextStyle get numbersTextStyle => ThemeConstants.headline3;

  /// Whether to show numbers over tiles or not
  bool get showNumbersOnly => false;

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

  // THE color of the cog icon
  Color get settingIconColor;

  /// The icon color of the audio control when audio isn't mute
  Color get audioControlOn;

  /// The icon color of the audio control when audio is mute
  Color get audioControlOff => buttonColor;

  /// The semantics label of this sub theme.
  String semanticsLabel(BuildContext context);

  /// The path to the image asset of this theme.
  String get themeAsset;

  /// The path to the audio asset of this sub theme.
  String get audioAsset;

  /// The anchor who gives tips and tricks of the game.
  String get anchorAsset;

  /// Mirror Anchor Asset
  bool get mirrorAnchorAsset => false;

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate => const MyPuzzleLayout();

  // Grid Size
  int get gridSize => 4;

  Uint8List assetForTile(int tile) => _tiles.elementAt(tile - 1);

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
    settingIconColor,
    audioControlOff,
    audioControlOn,
    themeAsset,
    audioAsset,
    gridSize,
    backgroundImage,
    anchorAsset,
    mirrorAnchorAsset,
  ];
}
