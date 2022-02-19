// ignore_for_file: constant_identifier_names

abstract class Assets {
  static const path = 'assets/';
  static const audios = 'assets/audio/';
  static const fonts = 'assets/fonts/';
  static const icons = 'assets/icons/';
  static const images = 'assets/images/';
  static const rive = 'assets/rive/';
}

abstract class AssetAudios extends Assets {
  static const path = Assets.audios;

  static const shuffle = path + 'shuffle.mp3';
  static const click = path + 'click.mp3';
  static const dumbbell = path + 'dumbbell.mp3';
  static const sandwich = path + 'sandwich.mp3';
  static const skateboard = path + 'skateboard.mp3';
  static const success = path + 'success.mp3';
  static const tileMove = path + 'tile_move.mp3';

  static const explosion = path + 'explosion.mp3';
  static const sparkel = path + 'sparkel.mp3';

  static get all => [shuffle, click, dumbbell, sandwich, skateboard, success, tileMove, explosion, sparkel];
}

abstract class AssetIcons extends Assets {
  static const path = Assets.icons;

  static const shuffle = path + 'shuffle.png';
  static const timer = path + 'timer.png';

  static get all => [shuffle, timer];
}

abstract class AssetImages extends Assets {
  static const path = Assets.images;

  /// Add .png after specifying 1, 2, 3 or 4 at the end of the string
  static const dash = path + 'dash';

  static const audio_control_on = path + 'volume_on.png';
  static const audio_control_off = path + 'volume_off.png';

  static const dashatar = path + 'dashatar/';

  // Add .png after specifying a size [small, medium, large] at the end of the string
  static const simple_dash = path + 'simple_dash_';

  static get all => [dash, dashatar, simple_dash];
}

abstract class AssetRiveAnims extends Assets {
  static const path = Assets.rive;

  static const anchor = path + 'dash_bird.riv';
  static const bomb = path + 'bomb.riv';
  static const bomb_placeholder = path + 'placeholder/bomb.svg';

  static get all => [anchor, bomb];
}
