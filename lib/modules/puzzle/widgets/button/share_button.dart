
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

import '../../provider/provider.dart';
import '../../theme/theme.dart';
import '../dialog/dialog_share.dart';
import 'puzzle.dart';

/// {@template puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class PuzzleShareButton extends StatefulWidget {
  /// {@macro puzzle_action_button}
  const PuzzleShareButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<PuzzleShareButton> createState() =>
      _PuzzleShareButtonState();
}

class _PuzzleShareButtonState
    extends State<PuzzleShareButton> {
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

    final showButton = status == RiveAnchorStatus.idle || status == RiveAnchorStatus.backToLaszlow || status == RiveAnchorStatus.exit;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: !showButton ? const SizedBox() : PuzzleButton(
          onPressed: () {
            showShareDialog(context);
          },
          backgroundColor: theme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.share,
                size: 18.0,
              ),
              const Gap(8),
              Text(context.l10n.share),
            ],
          ),
          boxDecoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(56.0))
          ),
        ),
      ),
    );
  }
}
