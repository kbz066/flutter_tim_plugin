import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_tim_plugin/tim_flutter_plugin.dart';
import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/message/test_entity.dart';
import 'package:flutter_tim_plugin/message/TIMImageElem.dart';

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
    //1.初始化 im SDK
    TimFlutterPlugin.init("2255");

    //2.连接 im SDK
    print('开始登录');
    await TimFlutterPlugin.login("1234","fafafa");
    print('准备发送消息');
//    var text=TIMTextElem(text:"测试发送文本消息",conversationType: TIMConversationType.C2C);
//
//    var res=await TimFlutterPlugin.sendMessage( text);

    var text=TIMImageElem(path:path,conversationType: TIMConversationType.C2C,id: 2255.toString());

    var res=await TimFlutterPlugin.sendMessage( text);
    print('发送消息结果 00 ${res["data"]}');
    print('aaaa        ${json.decode(res["data"]).runtimeType}');
    print('发送消息结果  ${TestEntity.fromJson( json.decode(res["data"])).element[0].imageList.length}');


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

