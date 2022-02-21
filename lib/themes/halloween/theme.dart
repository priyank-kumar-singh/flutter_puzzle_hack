import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/puzzle/puzzle.dart';

import 'layout.dart';

export 'halloween.dart';

abstract class ThemeOne extends PuzzleTheme {
  ThemeOne() : super();

  @override
  Color get nameColor => Colors.white;

  @override
  Color get titleColor => Colors.white;

  @override
  Color get hoverColor => ThemeConstants.black2;

  @override
  Color get pressedColor => ThemeConstants.white2;

  @override
  bool get isLogoColored => false;

  @override
  Color get menuActiveColor => Colors.white;

  @override
  Color get menuUnderlineColor => Colors.white;

  @override
  Color get countdownColor => Colors.white;

  @override
  Color get settingIconColor => Colors.white;

  @override
  Color get audioControlOn => Colors.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate => const HalloweenLayout();
}
