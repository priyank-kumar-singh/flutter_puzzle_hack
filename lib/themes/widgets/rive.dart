import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/puzzle/puzzle.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';

class RiveBackground extends StatelessWidget {
  const RiveBackground({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    if (theme.backgroundImage == null) {
      return const SizedBox();
    } else {
      return Stack(
        children: [
          Opacity(
            opacity: 0.9,
            child: RiveAnimation.asset(
              theme.backgroundImage!,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 74,
            right: 50,
            child: ResponsiveLayoutBuilder(
              small: (_, child) => const SizedBox(),
              medium: (_, child) => const SizedBox(),
              large: (_, child) => const RiveAnchor(),
            ),
          ),
        ],
      );
    }
  }
}

class RiveAnchor extends StatefulWidget {
  const RiveAnchor({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  static const _activeThemeNormalSize = 120.0;
  static const _activeThemeSmallSize = 65.0;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<RiveAnchor> createState() => _RiveAnchorState();
}

class _RiveAnchorState extends State<RiveAnchor> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeBloc>().state.theme;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, child) => child!,
        child: (currentSize) {
          final isSmallSize = currentSize == ResponsiveLayoutSize.small;
          final activeSize = isSmallSize
              ? RiveAnchor._activeThemeSmallSize
              : RiveAnchor._activeThemeNormalSize;

          final padding = isSmallSize ? 4.0 : 8.0;
          return Padding(
            padding: EdgeInsets.only(left: padding),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                key: const Key('puzzle_anchor'),
                onTap: () async {
                  // await _audioPlayer.setAsset(theme.audioAsset);
                  unawaited(_audioPlayer.play());
                },
                child: SizedBox(
                  width: activeSize,
                  height: activeSize,
                  child: Transform(
                    transform: Matrix4.rotationX(pi),
                    child: RiveAnimation.asset(
                      theme.anchorAsset,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
