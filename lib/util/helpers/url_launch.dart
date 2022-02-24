import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart' as url_launch;

class URLHelper {
  URLHelper._();

  static Future<void> launch(String url, {VoidCallback? onError}) async {
    if (await url_launch.canLaunch(url)) {
      await url_launch.launch(url);
    } else {
      onError!();
    }
  }
}
