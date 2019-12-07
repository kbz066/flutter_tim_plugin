package com.flutter_tim_plugin;

import com.tencent.imsdk.TIMMessage;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** TimNativePlugin */
public class TimNativePlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "tim_plugin");
    channel.setMethodCallHandler(new TimNativePlugin());
    TimFlutterWrapper.getInstance().saveChannel(channel);
    TimFlutterWrapper.getInstance().saveContext(registrar.context());
    
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {


    System.out.println("onMethodCall           "+Thread.currentThread().getName());
    TimFlutterWrapper.getInstance().onFlutterMethodCall(call,result);
  }
}
