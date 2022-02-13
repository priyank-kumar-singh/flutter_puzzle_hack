import 'package:flutter/widgets.dart';

import '../../util/ui/tnc/activity.dart';
import '../../views/core/getstarted.dart';
import '../../views/core/wrapper.dart';
import '../../views/dashboard/home.dart';

class Routes {
  Routes._();

  static const wrapper = '/';
  static const tnc = '/terms';
  static const getstarted = '/getstarted';
  static const dashboard = '/home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    wrapper: (_) => const Wrapper(),
    tnc: (_) => const TnCScreen(),
    getstarted: (_) => const GetStartedScreen(),
    dashboard: (_) => const DashboardScreen(),
  };
}
