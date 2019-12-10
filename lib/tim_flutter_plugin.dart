


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/message/message.dart';
import 'package:flutter_tim_plugin/tim_method_key.dart';

import 'message/message_content.dart';
import 'message/message_factory.dart';

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

  static Future<Message> sendMessage({@required int id,@required int conversationType,@required MessageContent content}) async {

    Map map={
      "id":id,
      "conversationType":conversationType,
      "content":content.encode(),
      "messageType":content.getMessageType()
    };

    Map resultMap = await _channel.invokeMethod(TimMethodKey.SendMessage,map);

    if (resultMap == null) {
      return null;
    }
    print('resultMap=================null');
    String messageString = resultMap["data"];
    Message msg = MessageFactory.instance.map2Message(resultMap,content.getMessageType());
    return   msg;
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