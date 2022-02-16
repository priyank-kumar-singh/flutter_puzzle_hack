import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';

import 'dashatar_theme.dart';
/// {@template blue_dashatar_theme}
/// The blue dashatar puzzle theme.
/// {@endtemplate}
class BlueDashatarTheme extends DashatarTheme {
  /// {@macro blue_dashatar_theme}
  const BlueDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.dashatarBlueDashLabelText;

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
  String get themeAsset => 'assets/images/dashatar/gallery/blue.png';

  @override
  String get successThemeAsset => 'assets/images/dashatar/success/blue.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/blue_dashatar_off.png';

  @override
  String get audioAsset => 'assets/audio/dumbbell.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/blue';
}
