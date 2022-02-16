import 'dart:ui';

import 'package:flutter_puzzle_hack/config/config.dart';

import '../layout/puzzle_layout_delegate.dart';
import '../layout/simple_puzzle_layout_delegate.dart';

/// {@template simple_theme}
/// The simple puzzle theme.
/// {@endtemplate}
class SimpleTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const SimpleTheme() : super();

  @override
  String get name => 'Simple';

  @override
  bool get hasTimer => false;

  @override
  Color get nameColor => ThemeConstants.grey1;

  @override
  Color get titleColor => ThemeConstants.primary1;

  @override
  Color get backgroundColor => ThemeConstants.white;

  @override
  Color get defaultColor => ThemeConstants.primary5;

  @override
  Color get buttonColor => ThemeConstants.primary6;

  @override
  Color get hoverColor => ThemeConstants.primary3;

  @override
  Color get pressedColor => ThemeConstants.primary7;

  @override
  bool get isLogoColored => true;

  @override
  Color get menuActiveColor => ThemeConstants.grey1;

  @override
  Color get menuUnderlineColor => ThemeConstants.primary6;

  @override
  Color get menuInactiveColor => ThemeConstants.grey2;

  @override
  String get audioControlOnAsset => 'assets/images/audio_control/simple_on.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/simple_off.png';

  @override
  PuzzleLayoutDelegate get layoutDelegate => const SimplePuzzleLayoutDelegate();

  @override
  List<Object?> get props => [
        name,
        audioControlOnAsset,
        audioControlOffAsset,
        hasTimer,
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
      ];
}
