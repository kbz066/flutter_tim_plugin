


import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/message/custom_message.dart';
import 'package:flutter_tim_plugin/message/message.dart';
import 'package:flutter_tim_plugin/tim_method_key.dart';
import 'package:path_provider/path_provider.dart';

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

    Message msg = MessageFactory.instance.map2SendMessage(resultMap,content.getMessageType());
    return   msg;
  }


  static Future<Map> downloadFile({@required int conversationType,@required String path,@required Message msg})async{


    Map map={
      "conversationType":conversationType,
      "rand":msg.rand,
      "self":msg.isSelf,
      "seq":msg.msgSeq,
      "timestamp":msg.time,
      "sender":msg.sender,
      "path":path
    };
    return await _channel.invokeMethod(TimMethodKey.DownloadFile,map);
  }

  static Future<Map> downloadVideo({@required int conversationType,@required String snapshotPath,@required String videoPath,@required Message msg})async{



    Map map={
      "conversationType":conversationType,
      "rand":msg.rand,
      "self":msg.isSelf,
      "seq":msg.msgSeq,
      "timestamp":msg.time,
      "sender":msg.sender,
      "videoPath":videoPath,
      "snapshotPath":snapshotPath
    };
    return await _channel.invokeMethod(TimMethodKey.DownloadVideo,map);
  }
  ///响应原生的事件
  ///
  static void _addNativeMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) async {
      print('_addNativeMethodCallHandler         ${call.arguments.runtimeType}            ${call.arguments}   ${call.method}');


      switch (call.method) {
        case TimMethodKey.MethodCallBackKeyInit:

          break;
        case TimMethodKey.MethodCallBackKeyNewMessages:
          var v=MessageFactory.instance.string2ListMessage(call.arguments);
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;


          //var a= await TimFlutterPlugin.downloadVideo(conversationType: TIMConversationType.C2C,msg:v[0],videoPath: tempPath+"/qqq",snapshotPath: tempPath+"/www" );

          print('解码完成   ${v.runtimeType}');
          v.forEach((val){
            print('${val  }');
            print('解码   ${(val as Message).content }');
          });

          break;

      }
      return;
    });
  }
}