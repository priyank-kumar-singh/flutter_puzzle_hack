import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/models/models.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:gap/gap.dart';

import '../../themes/theme.dart';
import '../bloc/puzzle_bloc.dart';
import '../provider/provider.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

part 'header.dart';
part 'menu.dart';
part 'sections.dart';
part 'board.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(
            initialTheme: Halloween(),
            themes: [
              Halloween(),
            ],
          ),
        ),
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => AudioControlBloc(),
        ),
        BlocProvider(
          create: (_) => CountdownBloc(
            secondsToBegin: 3,
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => BombBloc(),
        ),
        BlocProvider(
          create: (_) => RiveBackgroundBloc(),
        ),
        BlocProvider(
          create: (_) => RiveAnchorBloc(),
        ),
      ],
      child: const _PuzzleView(),
    );
  }
}

/// {@template puzzle_view}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
class _PuzzleView extends StatelessWidget {
  /// {@macro puzzle_view}
  const _PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    context.read<RiveAnchorBloc>().registerStoryCount(theme.storyline.length, theme.endStory.length);

    return Scaffold(
      body: AnimatedContainer(
        duration: PuzzleAnimation.backgroundColorChange,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TimerBloc(
                ticker: const Ticker(),
              ),
            ),
            BlocProvider(
              create: (context) => PuzzleBloc(theme.gridSize)
                ..add(const PuzzleInitialized(shufflePuzzle: false)),
            ),
          ],
          child: const _Puzzle(
            key: Key('puzzle_view'),
          ),
        ),
      ),
      endDrawer: const Drawer(),
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    final background = context.select((RiveBackgroundBloc bloc) => bloc.state is RivebackgroundFinal);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            theme.layoutDelegate.backgroundBuilder(state),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 2000),
              reverseDuration: const Duration(milliseconds: 400),
              child: !background ? null : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    children: const [
                      _PuzzleHeader(),
                      _PuzzleSections(),
                    ],
                  ),
                ),
              ),
            ),
            theme.layoutDelegate.anchorBuilder(state),
          ],
        );
      },
    );
  }
}
