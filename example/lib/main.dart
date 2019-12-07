import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tim_plugin/tim_flutter_plugin.dart';
import 'package:flutter/services.dart';


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

    //1.初始化 im SDK
    TimFlutterPlugin.init("123");

    //2.连接 im SDK


    print('开始登录');
    var res=await TimFlutterPlugin.login("1234","fafafa");
    print('connect result --------------。${res}');
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
