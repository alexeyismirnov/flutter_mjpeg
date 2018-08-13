import 'dart:async';

import 'package:flutter/services.dart';

class Mjpeg {
  static const MethodChannel _channel =
      const MethodChannel('mjpeg');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
