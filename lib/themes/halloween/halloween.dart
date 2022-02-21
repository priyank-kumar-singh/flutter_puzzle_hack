import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';

import 'theme.dart';

class Halloween extends ThemeOne {
  Halloween() : super();

  @override
  String get name => 'Halloween';

  @override
  String semanticsLabel(BuildContext context) => context.l10n.dashatarGreenDashLabelText;

  @override
  Color get backgroundColor => const Color(0xFF65819E);

  @override
  Color get defaultColor => Colors.purple.shade600;

  @override
  Color get buttonColor => Colors.purple.shade300;

  @override
  Color get menuInactiveColor => Colors.white;

  @override
  Color get countdownColor => Colors.white;

  @override
  String get audioAsset => Assets.audio.skateboard;

  @override
  String get themeAsset => Assets.images.halloween.ghost.path;

  @override
  String get backgroundImage => Assets.rive.halloweenMoon.path;

  @override
  String get anchorAsset => Assets.rive.bat.path;

  @override
  bool get mirrorAnchorAsset => true;
}
