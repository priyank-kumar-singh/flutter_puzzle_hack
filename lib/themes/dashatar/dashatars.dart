import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';

import 'puzzle_theme.dart';

class DashatarBlue extends DashatarTheme {
  const DashatarBlue() : super();

  @override
  String get subtheme => 'blue';

  @override
  String semanticsLabel(BuildContext context) => context.l10n.dashatarBlueDashLabelText;

  @override
  Color get backgroundColor => ThemeConstants.bluePrimary;

  @override
  Color get defaultColor => ThemeConstants.blue90;

  @override
  Color get buttonColor => ThemeConstants.blue50;

  @override
  Color get menuInactiveColor => ThemeConstants.blue50;

  @override
  Color get countdownColor => ThemeConstants.blue50;

  @override
  String get audioAsset => 'assets/audio/dumbbell.mp3';
}

class DashatarGreen extends DashatarTheme {
  const DashatarGreen() : super();

  @override
  String get subtheme => 'green';

  @override
  String semanticsLabel(BuildContext context) => context.l10n.dashatarGreenDashLabelText;

  @override
  Color get backgroundColor => ThemeConstants.greenPrimary;

  @override
  Color get defaultColor => ThemeConstants.green90;

  @override
  Color get buttonColor => ThemeConstants.green50;

  @override
  Color get menuInactiveColor => ThemeConstants.green50;

  @override
  Color get countdownColor => ThemeConstants.green50;

  @override
  String get audioAsset => 'assets/audio/skateboard.mp3';
}

class DashatarYellow extends DashatarTheme {
  const DashatarYellow() : super();

  @override
  String get subtheme => 'yellow';

  @override
  String semanticsLabel(BuildContext context) => context.l10n.dashatarYellowDashLabelText;

  @override
  Color get backgroundColor => ThemeConstants.yellowPrimary;

  @override
  Color get defaultColor => ThemeConstants.yellow90;

  @override
  Color get buttonColor => ThemeConstants.yellow50;

  @override
  Color get menuInactiveColor => ThemeConstants.yellow50;

  @override
  Color get countdownColor => ThemeConstants.yellow50;

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';
}
