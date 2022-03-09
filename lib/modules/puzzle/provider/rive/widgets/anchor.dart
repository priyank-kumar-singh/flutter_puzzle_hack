import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';

import '../../../provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widgets.dart';

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

class _RiveAnchorState extends State<RiveAnchor> with SingleTickerProviderStateMixin {
  late final AudioPlayer _audioPlayer;

  late final AnimationController controller;
  late final RiveAnchorAnimation animation;

  bool showTip = false;
  int tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset(Assets.audio.click);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    animation = RiveAnchorAnimation(controller);
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

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: BlocListener<RiveAnchorBloc, RiveAnchorState>(
        listener: (context, state) {
          if (state.status == RiveAnchorStatus.flyingIdle) {
            context.read<CountdownBloc>().add(const CountdownStarted());
          } else if (state.status == RiveAnchorStatus.exit) {
            controller
              ..forward()
              ..addListener(() {
                if (controller.isCompleted) {
                  context.read<RiveBackgroundBloc>().add(const RiveBackgroundReset());
                  context.read<RiveAnchorBloc>().add(const RiveAnchorReset());
                  controller.reset();
                }
              });
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
            final canShowTip = state.status == RiveAnchorStatus.flyingIdle
              && currentSize == ResponsiveLayoutSize.large;
            return AnimatedSwitcher(
              duration: PuzzleAnimation.puzzleTileScale,
              child: !background
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: Column(
                        children: [
                          _AnchorMessageBubble(
                            size: activeSize,
                            showAttachment: showTip && canShowTip && tipIndex == 0,
                            message: showTip && canShowTip ? theme.tips[tipIndex] : null,
                            onNext: showTip && canShowTip ? () {
                              if (++tipIndex == theme.tips.length) {
                                setState(() => showTip = false);
                              } else {
                                unawaited(_audioPlayer.replay());
                                setState(() {});
                              }
                            } : null,
                          ),
                          const Gap(48),
                          InkWell(
                            onTap: () {
                              if (canShowTip && !showTip) {
                                setState(() {
                                  showTip = true;
                                  tipIndex = 0;
                                });
                              } else if (showTip) {
                                setState(() {
                                  setState(() => showTip = false);
                                });
                              }
                            },
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4
                                    .rotationY(theme.mirrorAnchorAsset ? pi : 0)
                                    ..rotateX(animation.rotateX.value * pi)
                                    ..rotateZ(animation.rotateZ.value * pi)
                                    ..scale((state.status == RiveAnchorStatus.idle ||
                                            state.status ==
                                                RiveAnchorStatus.backToLaszlow)
                                        ? 3.0
                                        : 3.0)
                                    ..translate(
                                      animation.xAxis.value,
                                      animation.yAxis.value,
                                    ),
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                width: activeSize,
                                height: activeSize,
                                child: RiveAnimation.asset(
                                  theme.anchorAsset,
                                  stateMachines: const ['state_machine'],
                                  fit: BoxFit.fill,
                                  onInit: context
                                      .read<RiveAnchorBloc>()
                                      .registerTriggers,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _AnchorMessageBubble extends StatelessWidget {
  const _AnchorMessageBubble({
    Key? key,
    this.message,
    this.onNext,
    this.showAttachment = false,
    required this.size,
  }) : super(key: key);

  final double size;
  final bool showAttachment;
  final String? message;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((RiveAnchorBloc bloc) => bloc.state);
    final isStart = state.status == RiveAnchorStatus.flying;
    final isEnd = state.status == RiveAnchorStatus.backToLaszlow;
    final diagIndex = state.diagIndex;

    final text = message ?? (isStart
        ? theme.storyline[diagIndex]
        : isEnd
            ? theme.endStory[diagIndex]
            : null);

    return text == null
        ? const SizedBox()
        : ResponsiveLayoutBuilder(
          small: (_, child) => child!,
          medium: (_, child) => child!,
          large: (_, child) => child!,
          child: (layout) {
            final sf = layout == ResponsiveLayoutSize.large ? 1.8
                    : layout == ResponsiveLayoutSize.medium ? 3.2
                    : 2.8;
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size * sf,
                ),
                child: MessageBubble(
                  key: const Key('anchor_message'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildMessage(text),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buildButton(text: context.l10n.next, onPressed: () {
                              if (message == null) {
                                context
                                .read<RiveAnchorBloc>()
                                .add(const RiveAnchorStoryForward());
                              } else {
                                onNext!();
                              }
                            }),
                            if (showAttachment) ...[
                              const Gap(8.0),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                margin: const EdgeInsets.only(left: 4.0),
                                child: buildButton(text: context.l10n.view, onPressed: () {
                                  showThemeAsset(context);
                                }),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        );
  }

  MouseRegion buildButton({required String text, required VoidCallback onPressed}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: ThemeConstants.label.copyWith(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget buildMessage(String text) {
    return AnimatedSwitcher(
      duration: PuzzleAnimation.textStyle,
      child: Text(text, style: ThemeConstants.bodySmall),
    );
  }
}

class RiveAnchorAnimation {
  RiveAnchorAnimation(this.controller) :
    xAxis = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 500), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 500, end: 300), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 300, end: -200.0), weight: 4),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
    yAxis = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -100), weight: 4),
      TweenSequenceItem(tween: Tween(begin: -100, end: -200), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -200, end: -300), weight: 4),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.linear)),
    rotateX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 0, end: 1.0), weight: 6),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
    rotateZ = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.3), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 6),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.ease));

  late final AnimationController controller;

  late final Animation<double> xAxis, yAxis, rotateX, rotateZ;
}
