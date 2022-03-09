import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../theme/theme.dart';
import '../bloc/background.dart';

class RiveBackground extends StatelessWidget {
  const RiveBackground({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    if (theme.backgroundImage == null) {
      return const SizedBox();
    } else {
      return Opacity(
        opacity: 0.9,
        child: RiveAnimation.asset(
          theme.backgroundImage!,
          fit: BoxFit.fill,
          stateMachines: const ['state_machine'],
          onInit: context.read<RiveBackgroundBloc>().registerTriggers,
        ),
      );
    }
  }
}
