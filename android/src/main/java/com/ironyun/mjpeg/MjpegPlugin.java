package com.ironyun.mjpeg;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** MjpegPlugin */
public class MjpegPlugin implements MethodCallHandler {
  private Activity activity;

  private MjpegPlugin(Activity activity) {
    this.activity = activity;
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "mjpeg");
    final MjpegPlugin instance = new MjpegPlugin(registrar.activity());
    channel.setMethodCallHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("liveView")) {
      Log.d("MJPG", "onMethodCall " + call.method);

        String url = call.argument("url");

        Intent intent = new Intent(activity, LiveViewActivity.class);
        intent.putExtra("url", url);

        activity.startActivity(intent);

      result.success(null);

    } else {
      result.notImplemented();
    }
  }
}
