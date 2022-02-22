import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:just_audio/just_audio.dart';

import '../../bloc/puzzle_bloc.dart';
import '../../provider/provider.dart';
import '../../theme/theme.dart';
import '../button/puzzle.dart';

/// {@template puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class PuzzleActionButton extends StatefulWidget {
  /// {@macro puzzle_action_button}
  const PuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<PuzzleActionButton> createState() =>
      _PuzzleActionButtonState();
}

class _PuzzleActionButtonState
    extends State<PuzzleActionButton> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset(Assets.audio.click);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final status = context.select((RiveAnchorBloc bloc) => bloc.state.status);

    final isLoading = status == RiveAnchorStatus.flying;
    final isStarted = status == RiveAnchorStatus.flyingIdle;
    final isEnding = status == RiveAnchorStatus.backToLaszlow;
    final isExit = status == RiveAnchorStatus.exit;

    final text = isStarted
        ? context.l10n.restart
        : isEnding
          ? context.l10n.waiting
          : isExit
            ? context.l10n.bye
            : (isLoading
              ? context.l10n.getReady
              : context.l10n.startGame);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(status),
          message: isStarted ? context.l10n.restartTooltip : '',
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: isLoading || isEnding
                ? null
                : () async {
                    // Reset timer
                    context.read<TimerBloc>().add(const TimerReset());
                    context.read<CountdownBloc>().add(const CountdownStopped());
                    context.read<RiveAnchorBloc>().add(const RiveAnchorPlay());
                    if (isStarted) {
                      context.read<PuzzleBloc>().add(const PuzzleInitialized(shufflePuzzle: false));
                    }

                    unawaited(_audioPlayer.replay());
                  },
            textColor: isLoading ? theme.defaultColor : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
