package com.flutter_tim_plugin_example;

import android.os.Bundle;

;

import com.flutter_tim_plugin.TimNativePlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);


    System.out.println("onCreate---------------> ");

  }

  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    System.out.println("configureFlutterEngine---------------> ");
    flutterEngine.getPlugins().add(new TimNativePlugin());
   // GeneratedPluginRegistrant.registerWith(flutterEngine);
  }
}
