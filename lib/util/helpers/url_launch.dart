import 'package:url_launcher/url_launcher.dart';

import '../../models/result.dart';

class URLHelper {
  URLHelper._();

  static Future<Result> launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      return Result(code: Status.success);
    } else {
      return Result(
        code: Status.exception,
        message: 'Failed to open required app.',
      );
    }
  }
}
