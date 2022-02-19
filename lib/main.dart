import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/themes/themes.dart';
import 'package:http/http.dart' as http;

import 'config/config.dart';
import 'constants/asset.dart';
import 'puzzle/puzzle.dart';
import 'util/utils.dart';

void main() {
  bootstrap(() => const MyApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await BlocOverrides.runZoned(
    () async => await runZonedGuarded(
      () async => runApp(await builder()),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    ),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    ValueGetter<PlatformHelper>? platformHelperFactory,
  })  : _platformHelperFactory = platformHelperFactory ?? getPlatformHelper,
        super(key: key);

  final ValueGetter<PlatformHelper> _platformHelperFactory;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The path to local assets folder.
  static const localAssetsPrefix = 'assets/';

  static final audioControlAssets = [
    'assets/images/volume_on.png',
    'assets/images/volume_off_blue.png',
    'assets/images/volume_off_green.png',
    'assets/images/volume_off_yellow.png',
  ];

  late final PlatformHelper _platformHelper;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    _platformHelper = widget._platformHelperFactory();

    if (_platformHelper.isWeb) {
      _timer = Timer(const Duration(milliseconds: 20), () {
        for (var num = 1; num <= 15; num++) {
          for (var color in ['green', 'blue', 'yellow']) {
            precacheImage(
              Image.asset(AssetImages.dashatar + '$color/$num.png').image,
              context,
            );
            precacheImage(
              Image.asset(AssetImages.dashatar + '$color.png').image,
              context,
            );
            precacheImage(
              Image.asset(AssetImages.dashatar + '${color}_success.png').image,
              context,
            );
          }
        }

        for (var size in ['small', 'medium', 'large']) {
          precacheImage(
            Image.asset(AssetImages.simple_dash + '$size.png').image,
            context,
          );
        }

        for (final asset in audioControlAssets) {
          precacheImage(
            Image.asset(asset).image,
            context,
          );
        }

        for (final asset in AssetAudios.all) {
          prefetchToMemory(asset);
        }

        for (final asset in AssetIcons.all) {
          precacheImage(Image.asset(asset).image, context);
        }
      });
    }
  }

  /// Prefetches the given [filePath] to memory.
  Future<void> prefetchToMemory(String filePath) async {
    if (_platformHelper.isWeb) {
      // We rely on browser caching here. Once the browser downloads the file,
      // the native implementation should be able to access it from cache.
      await http.get(Uri.parse('$localAssetsPrefix$filePath'));
      return;
    }
    throw UnimplementedError(
      'The function `prefetchToMemory` is not implemented '
      'for platforms other than Web.',
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.l10n.puzzleChallengeTitle,
      home: const Dashboard(),
    );
  }
}
