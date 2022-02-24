import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/puzzle/provider/provider.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:gap/gap.dart';

import '../../bloc/puzzle_bloc.dart';
import '../../theme/theme.dart';

void showShareDialog(BuildContext context) {
  final theme = context.read<ThemeBloc>().state.theme;
  final puzzle = context.read<PuzzleBloc>().state;
  final timer = context.read<TimerBloc>().state;

  showAppDialog(
    context: context,
    barrierDismissible: true,
    useDefaultConstraints: false,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timer.secondsElapsed > 0 ? theme.winningToast : theme.incompleteToast,
                textAlign: TextAlign.center,
                style: ThemeConstants.headline5,
              ),
            ),
            Flexible(
              child: SizedBox.square(
                dimension: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    theme.themeAsset,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Gap(8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText(context.l10n.time, TimerHelper.formatDuration(Duration(seconds: timer.secondsElapsed))),
                    _buildRichText(context.l10n.moves, puzzle.numberOfMoves),
                    _buildRichText(context.l10n.gridSize, theme.gridSize),
                  ],
                ),
                SizedBox.square(
                  dimension: 120,
                  child: Assets.rive.zombie.rive(
                    stateMachines: ['state_machine'],
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 220,
                child: Text(
                  context.l10n.shareMessage,
                  style: ThemeConstants.label,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Container(
              width: 220,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeConstants.grey2,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.share + ' ' + context.l10n.puzzleGame,
                    style: ThemeConstants.label,
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: SocialMediaLinks.slidePuzzle)).then((_) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                          SnackBar(
                            content: Text(context.l10n.linkCopied),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      });
                    },
                    tooltip: context.l10n.copyLink,
                    splashRadius: 0.1,
                    icon: const Icon(
                      Icons.copy,
                      color: ThemeConstants.grey2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildRichText<T>(String header, T content) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 4.0),
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: header + ': ',
        style: ThemeConstants.headline5,
        children: [
          TextSpan(
            text: '$content',
            style: ThemeConstants.label,
          ),
        ]
      ),
    ),
  );
}
