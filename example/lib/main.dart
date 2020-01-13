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
  String _platformVersion = 'Unknown';

  TextEditingController loginController;
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    loginController=TextEditingController();
    messageController=TextEditingController();
    initPlatformState();
  }

  initPlatformState() async {
    String path =
        "/storage/emulated/0/Android/data/com.flutter_tim_plugin_example/files/Pictures/Img89495.jpg";

    String soundPath = "/storage/emulated/0/Sound/sound.wma";

    print('准备发送消息');

    // var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: TextMessage.obtain("测试发送文本消息"));

    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: SoundMessage.obtain(path,20));

    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: SoundMessage.obtain(soundPath,8));
//    var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: EmojiMessage.obtain(Uint8List.fromList("表情测试".codeUnits),100));
    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: LocationMessage.obtain(20.22,33.66,"发送位置"));
    //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: FileMessage.obtain(path,"测试文件发送"));
//    var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: CustomMessage.obtain(Uint8List.fromList(utf8.encode("自定义消息"))));
//
//    print('发送消息结果 ${(res.msgSeq)}   ${res.desc}');
  }

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
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
              onPressed: () => this.onPressed("发送消息"),
              child: Text("登录"),
            ),

            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () => this.onPressed("下载文件"),
              child: Text("下载文件"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed(type) async {

    if (type == "登录") {
      //1.初始化 im SDK
      var  init= await TimFlutterPlugin.init(1400294549);

      print('init               $init');
      //2.连接 im SDK
      print('开始登录  ${await TimFlutterPlugin.login(loginController.text, "fafafa")}');
    }else if(type == "发送消息"){

      String path = "/storage/emulated/0/Divoomtest.jpg";
      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: TextMessage.obtain(messageController.text));
      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: ImageMessage.obtain(path));
      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: CustomMessage.obtain(Uint8List.fromList(utf8.encode("自定义消息"))));

      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: FileMessage.obtain(path,"测试文件发送"));
      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: EmojiMessage.obtain(Uint8List.fromList(utf8.encode("表情消息")),999));


      var map= Map();
      map[TIMUserProfile.TIM_PROFILE_TYPE_KEY_NICK]="我的昵称ios";
      map[TIMUserProfile.TIM_PROFILE_TYPE_KEY_GENDER]=TIMFriendGenderType.GENDER_MALE;
      map[TIMUserProfile.TIM_PROFILE_TYPE_KEY_BIRTHDAY]=20190419;

      //var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: LocationMessage.obtain(66.6,99.9,"发生位置信息"));

      //var res =await TimFlutterPlugin.createGroup(type: TIMGroupType.Public, name: "创建个Public 群2 ");

      //var res =await TimFlutterPlugin.inviteGroupMember(groupId: "@TGS#27CSNSDGY", memList: ["2255"]);
      //var res=await TimFlutterPlugin.modifySelfProfile(map);
     // var res=await TimFlutterPlugin.getMessage(conversationType: TIMConversationType.C2C, id: 2255,count: 5);

//      getTemporaryDirectory().then((val) async {
//        print('文件是否存在    ${File("${val.path}/aaa.mp3").existsSync()}');
//
//        var res=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: FileMessage.obtain("${val.path}/aaa.mp3","我是文件名字"));
//
//      });
      Message ts=Message();

      ts.rand=4040861075;
      ts.sender="2255";
      ts.isSelf =true;
      ts.msgSeq = 61659;
      ts.time=1578639575;
      //var res=await TimFlutterPlugin.getLocalMessage(conversationType: TIMConversationType.C2C, id: 2255, count: 5);
      //var res=await TimFlutterPlugin.revokeMessage(conversationType: TIMConversationType.C2C,msg: ts);

      var res=await TimFlutterPlugin.getConversationList();
      print('发送消息res   $res');

    }else if(type=="下载文件"){

      Message ts=Message();

      ts.rand=2830530733;
      ts.sender="2255";
      ts.isSelf =true;
      ts.msgSeq = 43191;
      ts.time=1578644115;

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path+"/aaass3";

      print('tempPath   $tempPath');


     var res = await TimFlutterPlugin.downloadFile(conversationType: TIMConversationType.C2C,msg:ts,path: tempPath );
      print('下载结果   $res');

    }
  }
  www() async {
    // 获取应用文档目录并创建文件
    Directory documentsDir = await getTemporaryDirectory();
    String documentsPath = documentsDir.path;


    File file = new File('$documentsPath/aaa.jpg');
    if(!file.existsSync()) {
      file.createSync();
    }

    writeToFile(context, file, "模拟缩略图+++++++++");


  }
  //将数据内容写入指定文件中
  void writeToFile(BuildContext context, File file, String notes) async {
    File file1 = await file.writeAsString(notes);
    if(file1.existsSync()) {

      print('write  ===============ok=======    ${file.path}'  );
    }
  }
}
