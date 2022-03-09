/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/click.mp3
  String get click => 'assets/audio/click.mp3';

  /// File path: assets/audio/shuffle.mp3
  String get shuffle => 'assets/audio/shuffle.mp3';

  /// File path: assets/audio/skateboard.mp3
  String get skateboard => 'assets/audio/skateboard.mp3';

  /// File path: assets/audio/tile_move.mp3
  String get tileMove => 'assets/audio/tile_move.mp3';
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/github.png
  AssetGenImage get github => const AssetGenImage('assets/icons/github.png');

  /// File path: assets/icons/linkedin.png
  AssetGenImage get linkedin =>
      const AssetGenImage('assets/icons/linkedin.png');

  /// File path: assets/icons/timer.png
  AssetGenImage get timer => const AssetGenImage('assets/icons/timer.png');

  /// File path: assets/icons/twitter.png
  AssetGenImage get twitter => const AssetGenImage('assets/icons/twitter.png');

  /// File path: assets/icons/volume_off.png
  AssetGenImage get volumeOff =>
      const AssetGenImage('assets/icons/volume_off.png');

  /// File path: assets/icons/volume_on.png
  AssetGenImage get volumeOn =>
      const AssetGenImage('assets/icons/volume_on.png');

  /// File path: assets/icons/youtube.png
  AssetGenImage get youtube => const AssetGenImage('assets/icons/youtube.png');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesHalloweenGen get halloween => const $AssetsImagesHalloweenGen();
}

class $AssetsRiveGen {
  const $AssetsRiveGen();

  /// File path: assets/rive/bat.riv
  RiveGenImage get bat => const RiveGenImage('assets/rive/bat.riv');

  /// File path: assets/rive/halloween_moon.riv
  RiveGenImage get halloweenMoon =>
      const RiveGenImage('assets/rive/halloween_moon.riv');

  /// File path: assets/rive/zombie.riv
  RiveGenImage get zombie => const RiveGenImage('assets/rive/zombie.riv');
}

class $AssetsImagesHalloweenGen {
  const $AssetsImagesHalloweenGen();

  /// File path: assets/images/halloween/ghost.png
  AssetGenImage get ghost =>
      const AssetGenImage('assets/images/halloween/ghost.png');
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsRiveGen rive = $AssetsRiveGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class RiveGenImage {
  const RiveGenImage(this._assetName);

  final String _assetName;

  RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    List<RiveAnimationController> controllers = const [],
    OnInitCallback? onInit,
  }) {
    return RiveAnimation.asset(
      _assetName,
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;
}
