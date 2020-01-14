import 'dart:io';
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
import 'package:flutter_tim_plugin/message/file_message.dart';
import 'package:flutter_tim_plugin/message/custom_message.dart';
import 'package:flutter_tim_plugin/message/message.dart';
import 'package:flutter_tim_plugin/message/video_message.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result ="result";

  TextEditingController loginController;
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    loginController=TextEditingController();
    messageController=TextEditingController();

  }


  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:SingleChildScrollView(
          child: Column(

            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => this.onPressed("初始化"),
                child: Text("初始化"),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(hintText: "请输入userid"),
                  controller: this.loginController,
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => this.onPressed("登录"),
                child: Text("登录"),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(hintText: "请输入发送内容"),
                  controller: this.messageController,
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => this.onPressed("发送文字消息"),
                child: Text("发送文字消息"),
              ),

              Container(
                padding: EdgeInsets.all(5),
                color: Colors.white30,
                height: 100,
                width: double.infinity,
                child: Text(this.result),
              )
            ],
          )
        )

      ),
    );
  }

  Future<void> onPressed(type) async {

    if(type=="初始化"){

      //1.初始化 im SDK
      var  initSdk= await TimFlutterPlugin.init(1400294549);
      setState(() {
        this.result=initSdk.toString();
      });

    } else if (type == "登录") {



      //2.获取sig  这里是本地计算sig也可通过自己服务器获取
      String sig =await TimFlutterPlugin.getUserSig(1400294549, loginController.text, (7 * 24 * 60 * 60), "32fcda1bb51e94ca08eddeb80da0f030be66101b1525f3e7b910ff4dc6e631fb");


      //3.连接 im SDK

      var login =await TimFlutterPlugin.login(loginController.text, sig);
      setState(() {
        this.result=login.toString();
      });

    }else if(type == "发送文字消息"){


      var msg=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: TextMessage.obtain(messageController.text));

      setState(() {
        this.result=msg.toString();
      });

      //TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: ImageMessage.obtain(path));//图片消息
      // TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: CustomMessage.obtain(Uint8List.fromList(utf8.encode("自定义消息"))));

      // TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: FileMessage.obtain(path,"测试文件发送"));
      // TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: LocationMessage.obtain(66.6,99.9,"位置信息"));
      // TimFlutterPlugin.getLocalMessage(conversationType: TIMConversationType.C2C, id: 2255, count: 5);//获取消息


    }

  }

}
