import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'config/config.dart';
import 'constants/const.dart';
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
  late final PlatformHelper _platformHelper;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    _platformHelper = widget._platformHelperFactory();

    if (_platformHelper.isWeb) {
      final pictures = [
        Assets.images.halloween.ghost,
        Assets.icons.volumeOn,
        Assets.icons.volumeOff,
      ];

      final assetsMemory = [
        Assets.audio.click,
        Assets.audio.dumbbell,
        Assets.audio.sandwich,
        Assets.audio.shuffle,
        Assets.audio.skateboard,
        Assets.audio.success,
        Assets.audio.tileMove,

        Assets.rive.bat.path,
        Assets.rive.halloweenMoon.path,
      ];

      _timer = Timer(const Duration(milliseconds: 20), () {
        for (var asset in pictures) {
          precacheImage(Image.asset(asset.path).image, context);
        }
        for (var asset in assetsMemory) {
          prefetchToMemory(asset);
        }
      });
    }
  }

  /// Prefetches the given [filePath] to memory.
  Future<void> prefetchToMemory(String filePath) async {
    if (_platformHelper.isWeb) {
      // We rely on browser caching here. Once the browser downloads the file,
      // the native implementation should be able to access it from cache.
      await http.get(Uri.parse('${AssetPath.assets}$filePath'));
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
      onGenerateTitle: (context) => context.l10n.title,
      home: const PuzzlePage(),
    );
  }
}
