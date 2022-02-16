import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class URLHelper {
  URLHelper._();

  static Future<void> launch(String url, {VoidCallback? onError}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      onError!();
    }
  }
}
