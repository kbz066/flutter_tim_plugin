package com.flutter_tim_plugin;

import com.tencent.imsdk.TIMMessage;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** TimNativePlugin */
public class TimNativePlugin implements FlutterPlugin,MethodCallHandler {
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

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    final MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), "tim_plugin");
    channel.setMethodCallHandler(new TimNativePlugin());
    TimFlutterWrapper.getInstance().saveChannel(channel);
    TimFlutterWrapper.getInstance().saveContext(binding.getApplicationContext());

    System.out.println("执行了注册的方法   "+binding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {

  }
}
