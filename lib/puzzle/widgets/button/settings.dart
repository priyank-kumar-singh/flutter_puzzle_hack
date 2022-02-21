import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../theme/theme.dart';

class SettingsMenuButton extends StatelessWidget {
  const SettingsMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.select((ThemeBloc bloc) => bloc.state.theme).settingIconColor;
    const icon = Icons.settings;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        child: AnimatedSwitcher(
          duration: PuzzleAnimation.backgroundColorChange,
          child: ResponsiveLayoutBuilder(
            small: (_, __) => Icon(
              icon,
              key: const Key('settings_icon_small'),
              color: color,
              size: kHeaderButtonSize_small,
            ),
            medium: (_, __) => Icon(
              icon,
              key: const Key('settings_icon_medium'),
              color: color,
              size: kHeaderButtonSize,
            ),
            large: (_, child) => Icon(
              icon,
              key: const Key('settings_icon_large'),
              color: color,
              size: kHeaderButtonSize,
            ),
          ),
        ),
      ),
    );
  }
}
