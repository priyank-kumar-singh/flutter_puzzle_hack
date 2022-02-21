// ignore_for_file: constant_identifier_names

export 'assets/assets.gen.dart';
export 'assets/fonts.gen.dart';
export 'assets/path.dart';

export 'keys.dart';

/// Breakpoints for different screen layouts
abstract class Breakpoints {
  static const double small = 576;
  static const double medium = 1200;
  static const double large = 1440;
}

abstract class BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

abstract class PuzzleAnimation {
  static const textStyle = Duration(milliseconds: 530);
  static const backgroundColorChange = Duration(milliseconds: 530);
  static const logoChange = Duration(milliseconds: 530);
  static const puzzleTileScale = Duration(milliseconds: 230);
}

abstract class TileFontSize {
  static double small = 36;
  static double medium = 50;
  static double large = 54;
}

abstract class Texts {
  static const title = 'Flutter Puzzle Hack';
}


const kHeaderButtonSize_small = 24.0;
const kHeaderButtonSize = 33.0;

const kTileBorderRadius = 12.0;
