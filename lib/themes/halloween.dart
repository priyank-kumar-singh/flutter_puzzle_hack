import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';

import 'theme.dart';

class Halloween extends ThemeX {
  Halloween() : super() {
    storyline.addAll([
      'Hello I\'m Laszlo.',
      'The witch attacked me and made me a bat.\nWill you help, please?',
      'Thanks! Now listen Carefully...',
      'In order to revert witch\'s magic we need to first call our friendly ghost - Gia.',
      'I just found out she\'s been captured and locked. You need arrange all the pieces of the puzzle to free her.',
    ]);
  }

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
