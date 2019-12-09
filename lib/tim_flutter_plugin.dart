


import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/tim_method_key.dart';

class TimFlutterPlugin{
  static final MethodChannel _channel = const MethodChannel('tim_plugin');

  ///初始化 SDK
  ///
  ///[appkey] appkey
  static void init(String appkey) {
    _channel.invokeMethod(TimMethodKey.Init, appkey);
   _addNativeMethodCallHandler();
  }

  ///
  static Future<dynamic> login(String userID,String userSig){

    Map arguments={
      "userID":userID,
      "userSig":userSig
    };
    return _channel.invokeMethod(TimMethodKey.Login, arguments);
  }


  ///发送消息
  ///
  ///[conversationType] 会话类型，参见枚举 [TIMConversationType]
  ///

  static Future<dynamic> sendMessage(dynamic content) async {
    return   _channel.invokeMethod(TimMethodKey.SendMessage,content.toJson());
  }




  ///响应原生的事件
  ///
  static void _addNativeMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      print('_addNativeMethodCallHandler                   ${call.arguments}   ${TimMethodKey.MethodCallBackKeyInit}');
      switch (call.method) {
        case TimMethodKey.MethodCallBackKeyInit:




          break;

      }
      return;
    });
  }
}