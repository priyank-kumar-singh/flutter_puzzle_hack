import 'dart:async';

import 'package:flutter/material.dart';

import '../../config.dart';
import '../dashboard/home.dart';
import 'startup_anim.dart';

class Wrapper extends StatefulWidget {
  /// This parameter will be completely ignored if [isDev] is True
  ///
  /// In order to see a splash screen set both [isDev] and [isTestingInit] as False
  final bool showAnimatedSplashScreen;

  final bool isTestingInit;

  /// Prevents any SplashScreen or StartupAnimation and redirects directly to Dashboard
  final bool isDev;

  const Wrapper({
    Key? key,
    this.showAnimatedSplashScreen = false,
    this.isTestingInit = false,
    this.isDev = true,
  }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Completer<Widget?> completer = Completer();

  Future<Widget?> initTools() async {
    if (widget.isTestingInit) {
      await Future.delayed(const Duration(milliseconds: 1600));
      Navigator.of(context).pushReplacementNamed(Routes.dashboard);
      return null;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    completer.complete(initTools());
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDev
        ? const DashboardScreen()
        : widget.showAnimatedSplashScreen
            ? StartupAnimationScreen(completer.future)
            : const DashboardScreen();
  }
}
