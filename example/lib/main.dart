import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_tim_plugin/tim_flutter_plugin.dart';
import 'package:flutter_tim_plugin/common_define.dart';

import 'package:flutter_tim_plugin/message/text_message.dart';
import 'package:flutter_tim_plugin/message/image_message.dart';
import 'package:flutter_tim_plugin/message/sound_message.dart';
import 'package:flutter_tim_plugin/message/location_message.dart';
import 'package:flutter_tim_plugin/message/emoji_message.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {

    String path="/storage/emulated/0/Android/data/com.flutter_tim_plugin_example/files/Pictures/Img89495.jpg";

    String soundPath="/storage/emulated/0/Sound/sound.wma";
    //1.初始化 im SDK
    TimFlutterPlugin.init("2255");

    //2.连接 im SDK
    print('开始登录');
    await TimFlutterPlugin.login("1234","fafafa");
    print('准备发送消息');


   // var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: TextMessage.obtain("测试发送文本消息"));

    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: SoundMessage.obtain(path,20));


    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: SoundMessage.obtain(soundPath,8));
//    var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: EmojiMessage.obtain(Uint8List.fromList("表情测试".codeUnits),100));
    var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: LocationMessage.obtain(20.22,33.66,"发送位置"));


    print('发送消息结果 00 ${(res.msgSeq)}   ${res.desc}');
//    print('aaaa        ${json.decode(res["data"]).runtimeType}');
//    print('发送消息结果  ${TestEntity.fromJson( json.decode(res["data"])).element[0].imageList.length}');


//
//
//    print('connect result --------------。${res}');
  }

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

