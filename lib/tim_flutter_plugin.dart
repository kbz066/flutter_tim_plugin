


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/message/message.dart';
import 'package:flutter_tim_plugin/tim_method_key.dart';

import 'message/message_content.dart';
import 'message/message_factory.dart';



class TimFlutterPlugin{
  static Function(Message msg, int left) onMessageReceived;


  static final MethodChannel _channel = const MethodChannel('tim_plugin');

  ///初始化 SDK
  ///
  ///[appkey] appkey
  static void init(String appkey) {

    _channel.invokeMethod(TimMethodKey.Init, appkey);
   _addNativeMethodCallHandler();
  }

  ///
  static Future<dynamic> login(String userID,String userSig) async {

    Map arguments={
      "userID":userID,
      "userSig":userSig
    };

    return  await _channel.invokeMethod(TimMethodKey.Login, arguments);


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

    String messageString = resultMap["data"];
    Message msg = MessageFactory.instance.map2SendMessage(resultMap,content.getMessageType());
    return   msg;
  }


  static void downloadFile(){
    _channel.invokeMethod(TimMethodKey.DownloadFile,{"uuid":"1400294549_1234_eeac126a6b1b79e19640be607405f585.jpg"});
  }


  ///响应原生的事件
  ///
  static void _addNativeMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      print('_addNativeMethodCallHandler         ${call.arguments.runtimeType}            ${call.arguments}   ${call.method}');


      switch (call.method) {
        case TimMethodKey.MethodCallBackKeyInit:

          break;
        case TimMethodKey.MethodCallBackKeyNewMessages:
          var v=MessageFactory.instance.string2ListMessage(call.arguments);
          print('解码   ${v}');
          break;

      }
      return;
    });
  }
}