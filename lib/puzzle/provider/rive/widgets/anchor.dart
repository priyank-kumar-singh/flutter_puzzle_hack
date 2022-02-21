import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';

import '../../../theme/theme.dart';
import '../bloc/anchor.dart';
import '../bloc/background.dart';

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
    final background = context.select((RiveBackgroundBloc bloc) => bloc.state is RivebackgroundFinal);
    final state = context.select((RiveAnchorBloc bloc) => bloc.state);

    final isStart = state is RiveAnchorStoryStart;
    final isEnd = state is RiveAnchorStoryEnd;
    final diagIndex = state.currentDialogue;

    return BlocListener<RiveAnchorBloc, RiveAnchorState>(
      listener: (context, state) async {
        if (state is RiveanchorFlying) {
          await Future.delayed(const Duration(milliseconds: 3000));
          context.read<RiveAnchorBloc>().add(const RiveAnchorStoryForward());
        }
      },
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
            return AnimatedSwitcher(
              duration: PuzzleAnimation.puzzleTileScale,
              child: !background ? const SizedBox() : Padding(
                padding: EdgeInsets.only(left: padding),
                child: Column(
                  children: [
                    if (isStart) ...[
                      buildMessageBubble(theme.storyline[diagIndex], activeSize),
                    ] else if (isEnd) ...[
                      buildMessageBubble(theme.endStory[diagIndex], activeSize),
                    ],
                    const Gap(48),
                    SizedBox(
                      width: activeSize,
                      height: activeSize,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4
                          .rotationY(theme.mirrorAnchorAsset ? pi : 0)
                          ..scale(state is RiveAnchorIdle ? 3.0 : 2.0),
                        child: RiveAnimation.asset(
                          theme.anchorAsset,
                          stateMachines: const ['state_machine'],
                          fit: BoxFit.fill,
                          onInit: context.read<RiveAnchorBloc>().registerTriggers,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }

  Widget buildMessageBubble(String text, double size) {
    return SizedBox(
      width: size * 1.8,
      child: MessageBubble(
        key: Key(text),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedSwitcher(
              duration: PuzzleAnimation.textStyle,
              child: Text(
                text,
                style: ThemeConstants.bodySmall,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.read<RiveAnchorBloc>().add(const RiveAnchorStoryForward());
                },
                child: Text(
                  'Next',
                  style: ThemeConstants.bodyXSmall.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
