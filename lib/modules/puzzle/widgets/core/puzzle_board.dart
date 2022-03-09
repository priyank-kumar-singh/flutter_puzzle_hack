import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../bloc/puzzle_bloc.dart';
import '../../provider/provider.dart';
import '../dialog/dialog_share.dart';

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
    final anchor = context.select((RiveAnchorBloc bloc) => bloc.state.status);

    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          context.read<RiveAnchorBloc>().add(const RiveAnchorStoryForward());
          Timer(const Duration(milliseconds: 370), () async {
              showShareDialog(context);
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('puzzle_board_small'),
          dimension: BoardSize.small,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 1000),
            child: Visibility(
              visible: (anchor != RiveAnchorStatus.idle && anchor != RiveAnchorStatus.flyingIdle),
              child: RiveAnchor(key: Keys.anchorKey),
              replacement: child!,
            ),
          ),
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('puzzle_board_medium'),
          dimension: BoardSize.medium,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 1000),
            child: Visibility(
              visible: (anchor != RiveAnchorStatus.idle && anchor != RiveAnchorStatus.flyingIdle),
              child: RiveAnchor(key: Keys.anchorKey),
              replacement: child!,
            ),
          ),
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
