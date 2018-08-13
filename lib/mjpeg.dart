import 'dart:async';

import 'package:flutter/services.dart';

class Mjpeg {
  static const MethodChannel _channel =
      const MethodChannel('mjpeg');

  static Future<Null> startLiveView({String url}) async {
    await _channel.invokeMethod('liveView', {'url': url});
  }

}
