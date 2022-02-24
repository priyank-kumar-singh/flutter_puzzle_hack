// ignore_for_file: constant_identifier_names

export 'assets/assets.gen.dart';
export 'assets/fonts.gen.dart';
export 'assets/path.dart';

export 'keys.dart';

/// Breakpoints for different screen layouts
abstract class Breakpoints {
  static const small = 576;
  static const medium = 1200;
  static const large = 1440;
}

abstract class BoardSize {
  static const small = 312.0;
  static const medium = 424.0;
  static const large = 472.0;
}

abstract class TileFontSize {
  static const small = 36.0;
  static const medium = 50.0;
  static const large = 54.0;
}

abstract class PuzzleAnimation {
  static const textStyle = Duration(milliseconds: 530);
  static const backgroundColorChange = Duration(milliseconds: 530);
  static const logoChange = Duration(milliseconds: 530);
  static const puzzleTileScale = Duration(milliseconds: 230);
}

abstract class SocialMediaLinks {
  static const github = 'https://www.github.com/priyank-kumar-singh';
  static const linkedin = 'https://www.linkedin.com/in/priyank-kumar-singh-705';
  static const twitter = 'https://www.twitter.com/priyankkumars18';
  static const youtube = 'https://www.youtube.com/channel/UCNdptkGGmUsmjuIL8sQ5NpA';
  static const slidePuzzle = 'https://slide-puzzle-6ac4a.web.app/';
}

const kHeaderButtonSize_small = 24.0;
const kHeaderButtonSize = 33.0;

const kTileBorderRadius = 12.0;
