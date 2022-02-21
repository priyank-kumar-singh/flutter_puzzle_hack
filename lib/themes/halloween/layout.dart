import 'package:flutter/material.dart';

import '../../puzzle/puzzle.dart';
import '../widgets/widgets.dart';

class HalloweenLayout extends DefaultPuzzleLayout {
  const HalloweenLayout();

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const RiveBackground();
  }
}
