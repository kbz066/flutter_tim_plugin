
package com.flutter_tim_plugin;
import com.tencent.imsdk.TIMMessage;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugins.pathprovider.PathProviderPlugin;


/** TimNativePlugin */
public class TimNativePlugin implements FlutterPlugin,MethodCallHandler {

  private MethodChannel channel;
  /** Plugin registration. */
  private static void registerWith(Registrar registrar) {
    TimNativePlugin instance = new TimNativePlugin();
    instance.channel = new MethodChannel(registrar.messenger(), "tim_plugin");
    instance.channel.setMethodCallHandler(new TimNativePlugin());
    TimFlutterWrapper.getInstance().saveChannel(instance.channel);
    TimFlutterWrapper.getInstance().saveContext(registrar.context());


  }



  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    channel = new MethodChannel(binding.getBinaryMessenger(), "tim_plugin");

    channel.setMethodCallHandler(this);
    TimFlutterWrapper.getInstance().saveChannel(channel);
    TimFlutterWrapper.getInstance().saveContext(binding.getApplicationContext());


  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {



    TimFlutterWrapper.getInstance().onFlutterMethodCall(call,result);
  }
  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
  }
}
