import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../bloc/puzzle_bloc.dart';

/// {@template puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class MyPuzzleBoard extends StatefulWidget {
  /// {@macro puzzle_board}
  const MyPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  State<MyPuzzleBoard> createState() => _MyPuzzleBoardState();
}

class _MyPuzzleBoardState extends State<MyPuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    _completePuzzleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          _completePuzzleTimer =
              Timer(const Duration(milliseconds: 370), () async {
            // await showAppDialog<void>(
            //   context: context,
            //   child: MultiBlocProvider(
            //     providers: [
            //       BlocProvider.value(
            //         value: context.read<MyThemeBloc>(),
            //       ),
            //       BlocProvider.value(
            //         value: context.read<PuzzleBloc>(),
            //       ),
            //       BlocProvider.value(
            //         value: context.read<TimerBloc>(),
            //       ),
            //       BlocProvider.value(
            //         value: context.read<AudioControlBloc>(),
            //       ),
            //     ],
            //     child: const ShareDialog(),
            //   ),
            // );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('puzzle_board_small'),
          dimension: BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('puzzle_board_medium'),
          dimension: BoardSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: const Key('puzzle_board_large'),
          dimension: BoardSize.large,
          child: child,
        ),
        child: (_) => Stack(children: widget.tiles),
      ),
    );
  }
}
