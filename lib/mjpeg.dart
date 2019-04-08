import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum ImageSource2 {
  camera,
  gallery,
}

class Mjpeg {
  static const MethodChannel _channel = const MethodChannel('mjpeg');

  static Future<Null> startLiveView({String url}) async {
    await _channel.invokeMethod('liveView', {'url': url});
  }

  static Future<File> pickVideo2({
    @required ImageSource2 source,
  }) async {
    assert(source != null);

    final String path = await _channel.invokeMethod(
      'pickVideo',
      <String, dynamic>{
        'source': source.index,
      },
    );
    return path == null ? null : File(path);
  }

  static Future<Null> forcePortrait() async {
    await _channel.invokeMethod('forcePortrait', {});
  }

  static Future<Null> forceLandscape() async {
    await _channel.invokeMethod('forceLandscape', {});
  }
}
