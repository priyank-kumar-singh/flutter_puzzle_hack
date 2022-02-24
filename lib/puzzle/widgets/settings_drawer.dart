import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/config/config.dart';
import 'package:flutter_puzzle_hack/constants/const.dart';
import 'package:flutter_puzzle_hack/puzzle/puzzle.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:gap/gap.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((ThemeBloc bloc) => bloc.state);
    final l10n = context.l10n;

    return SafeArea(
      child: Container(
        key: const Key('drawer_container'),
        color: const Color(0xFFF2F2F2),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.puzzleSettings, style: ThemeConstants.headline4),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildDropdown<PuzzleTheme>(
                      context,
                      title: l10n.puzzleTheme,
                      items: state.themes.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        );
                      }).toList(),
                      value: state.theme,
                      onChange: (value) {
                        context.read<ThemeBloc>().add(ThemeUpdated(theme: value));
                      },
                    ),
                    buildDropdown<String>(
                      context,
                      title: l10n.soundEffects,
                      items: [l10n.soundEffectsOn, l10n.soundEffectsOff].map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      value: context.select((AudioControlBloc bloc) => bloc.state.muted ? l10n.soundEffectsOff : l10n.soundEffectsOn),
                      onChange: (value) {
                        context.read<AudioControlBloc>().add(AudioToggled());
                      },
                    ),
                    buildDropdown<int>(
                      context,
                      title: l10n.gridSize,
                      items: [2, 3, 4, 5].map((e) {
                        return DropdownMenuItem(
                          child: Text(e.toString()),
                          value: e,
                        );
                      }).toList(),
                      value: state.theme.gridSize,
                      onChange: (size) {
                        ImageHelper.splitWithRootBundle(state.theme.themeAsset, size).then((value) {
                          context.read<ThemeBloc>().add(ThemeUpdated(
                            theme: state.theme
                            ..gridSize = size
                            ..setTiles(value)
                          ));
                          context.read<RiveAnchorBloc>().add(const RiveAnchorReset());
                          context.read<TimerBloc>().add(const TimerReset());
                          context.read<CountdownBloc>().add(const CountdownCompleteReset());
                          context.read<PuzzleBloc>().add(PuzzleInitialized(gridSize: size, shufflePuzzle: false));
                        });
                      },
                    ),
                    const Gap(32.0),
                    buildNote(l10n.noteSettings, l10n.note),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDivider(),
                Text(
                  l10n.followme,
                  style: ThemeConstants.headline5,
                ),
                const Gap(8),
                Row(
                  children: [
                    SocialMediaButton(
                      SocialMediaIcons.github,
                      url: SocialMediaLinks.github,
                    ),
                    SocialMediaButton(
                      SocialMediaIcons.linkedIn,
                      url: SocialMediaLinks.linkedin,
                    ),
                    SocialMediaButton(
                      SocialMediaIcons.twitter,
                      url: SocialMediaLinks.twitter,
                    ),
                    SocialMediaButton(
                      SocialMediaIcons.youtube,
                      url: SocialMediaLinks.youtube,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNote(String text, String noteHeader) {
    return RichText(
      text: TextSpan(
        text: noteHeader + ': ',
        style: ThemeConstants.headline5,
        children: [
          TextSpan(
            text: text,
            style: ThemeConstants.label,
          ),
        ]
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 48.0,
    );
  }

  Widget buildDropdown<T>(BuildContext context, {
    required String title,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T) onChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDivider(),
        Text(
          title,
          style: ThemeConstants.headline5,
        ),
        const Gap(12.0),
        DropdownButtonFormField<T>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          value: value,
          items: items,
          onChanged: (value) {
            if (value != null) {
              onChange(value);
            }
          },
        ),
      ],
    );
  }
}
