import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/models.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../bloc/puzzle_bloc.dart';
import '../provider/provider.dart';
import '../widgets/widgets.dart';
import 'template.dart';

/// {@template puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [Theme].
/// {@endtemplate}
class MyPuzzleLayout extends PuzzleLayoutDelegate {
  /// {@macro puzzle_layout_delegate}
  const MyPuzzleLayout();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => StartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const PuzzleActionButton(),
          medium: (_, child) => const PuzzleActionButton(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
          large: 130,
        ),
        const PuzzleCountdown(),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const RiveBackground();
  }

  @override
  Widget anchorBuilder(PuzzleState state) {
    return Positioned(
      bottom: 120,
      right: 120,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const RiveAnchor(),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const TimerView(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
            MyPuzzleBoard(tiles: tiles),
            const ResponsiveGap(
              large: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return PuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
