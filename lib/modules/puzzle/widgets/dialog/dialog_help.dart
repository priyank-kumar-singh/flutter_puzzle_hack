import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';

import '../../theme/theme.dart';

void showThemeAsset(BuildContext context) {
    showAppDialog(
      context: context,
      useDefaultConstraints: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(kTileBorderRadius)),
                child: Image.asset(
                  context.read<ThemeBloc>().state.theme.themeAsset,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
