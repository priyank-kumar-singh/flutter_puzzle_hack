import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../../theme/theme.dart';
import '../bloc/bloc.dart';

/// {@template audio_control}
/// Displays and allows to update the current audio status of the puzzle.
/// {@endtemplate}
class AudioControl extends StatelessWidget {
  /// {@macro audio_control}
  const AudioControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final audioMuted = context.select((AudioControlBloc bloc) => bloc.state.muted);
    final audioAsset = (audioMuted ? Assets.icons.volumeOff : Assets.icons.volumeOn).path;
    final color = audioMuted ? theme.buttonColor : null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<AudioControlBloc>().add(AudioToggled()),
        child: AnimatedSwitcher(
          duration: PuzzleAnimation.backgroundColorChange,
          child: ResponsiveLayoutBuilder(
            key: Key(audioAsset),
            small: (_, __) => Image.asset(
              audioAsset,
              color: color,
              key: const Key('audio_control_small'),
              width: kHeaderButtonSize_small,
              height: kHeaderButtonSize_small,
            ),
            medium: (_, __) => Image.asset(
              audioAsset,
              color: color,
              key: const Key('audio_control_medium'),
              width: kHeaderButtonSize,
              height: kHeaderButtonSize,
            ),
            large: (_, __) => Image.asset(
              audioAsset,
              color: color,
              key: const Key('audio_control_large'),
              width: kHeaderButtonSize,
              height: kHeaderButtonSize,
            ),
          ),
        ),
      ),
    );
  }
}
