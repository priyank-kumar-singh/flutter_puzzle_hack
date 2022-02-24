import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../provider/provider.dart';
import '../../theme/theme.dart';
import '../widgets.dart';

class FABHelp extends StatelessWidget {
  const FABHelp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final background = context.select((RiveBackgroundBloc bloc) => bloc.state is RivebackgroundFinal);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 400),
      child: !background ? null : ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, __) => const SizedBox(),
        child: (size) => FloatingActionButton.small(
          tooltip: context.l10n.help,
          backgroundColor: theme.backgroundColor,
          child: const Icon(Icons.help_outline_sharp),
          onPressed: () {
            showThemeAsset(context);
          },
        ),
      ),
    );
  }
}
