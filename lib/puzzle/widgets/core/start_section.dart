import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/keys.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../bloc/puzzle_bloc.dart';
import '../../provider/provider.dart';
import '../button/action_button.dart';
import 'number_of_moves_and_tiles_left.dart';
import 'theme_name.dart';
import '../timer/timer.dart';
import '../button/share_button.dart';

/// {@template start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class StartSection extends StatelessWidget {
  /// {@macro start_section}
  const StartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((CountdownBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 30,
          large: 151,
        ),
        PuzzleName(
          key: Keys.puzzleNameKey,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: Keys.numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == MyPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const PuzzleActionButton(),
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const PuzzleShareButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const TimerView(),
          medium: (_, __) => const TimerView(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
