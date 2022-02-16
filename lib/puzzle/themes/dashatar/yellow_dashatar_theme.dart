import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';

import 'dashatar_theme.dart';

/// {@template yellow_dashatar_theme}
/// The yellow dashatar puzzle theme.
/// {@endtemplate}
class YellowDashatarTheme extends DashatarTheme {
  /// {@macro yellow_dashatar_theme}
  const YellowDashatarTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.dashatarYellowDashLabelText;

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
  String get themeAsset => 'assets/images/dashatar/gallery/yellow.png';

  @override
  String get successThemeAsset => 'assets/images/dashatar/success/yellow.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_dashatar_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/yellow';
}
