import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../theme/theme.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class AppTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const AppTitle({
    Key? key,
    this.title,
    this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String? title;

  /// The color of [title], defaults to [PuzzleTheme.titleColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final titleColor = color ?? theme.titleColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: child,
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: (currentSize) {
        final textStyle = (currentSize == ResponsiveLayoutSize.large
                ? ThemeConstants.headline4
                : ThemeConstants.headline5)
            .copyWith(color: titleColor);

        return AnimatedDefaultTextStyle(
          style: textStyle,
          duration: PuzzleAnimation.textStyle,
          child: Text(
            title ?? context.l10n.headerTitle,
          ),
        );
      },
    );
  }
}
