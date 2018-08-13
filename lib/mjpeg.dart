import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter/services.dart';

class Mjpeg {
  static const MethodChannel _channel =
      const MethodChannel('mjpeg');

  static Future<Null> startLiveView({@required String url}) async {
    await _channel.invokeMethod('liveView', {'url': url});
  }

}
