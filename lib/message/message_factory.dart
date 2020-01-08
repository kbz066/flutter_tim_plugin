import 'dart:core';
import 'dart:convert' show json;
import 'dart:math';

import 'package:flutter_tim_plugin/common_define.dart';
import 'package:flutter_tim_plugin/message/custom_message.dart';
import 'package:flutter_tim_plugin/message/emoji_message.dart';
import 'package:flutter_tim_plugin/message/file_message.dart';
import 'package:flutter_tim_plugin/message/sound_message.dart';
import 'package:flutter_tim_plugin/message/video_message.dart';
import 'package:flutter_tim_plugin/util/type_util.dart';


import 'conversation.dart';


import 'message_content.dart';
import 'message.dart';
import 'text_message.dart';
import 'image_message.dart';


class MessageFactory extends Object {
  factory MessageFactory() =>_getInstance();
  static MessageFactory get instance => _getInstance();
  static MessageFactory _instance;
  MessageFactory._internal() {
    // 初始化
  }
  static MessageFactory _getInstance() {
    if (_instance == null) {
      _instance = new MessageFactory._internal();
    }
    return _instance;
  }


  Message map2SendMessage(Map map,int messageType) {
    print('返回     $map');
    Message message=Message();
    message.code=map["code"];

    if(message.code==0){//成功
      Map dataMap=json.decode(map["data"]);
      message.messageType = messageType;
      message. rand = dataMap['rand'];
      message. sender = dataMap['sender'];
      message. msgId = dataMap['msgId'];
      message. msgSeq = dataMap['msgSeq'];
      message. time = dataMap['time'];
      message.isSelf = dataMap['isSelf'];
      message.isRead = dataMap['isRead'];
      message.isPeerReaded = dataMap['isPeerReaded'];
      message.status = dataMap['status'];
      message.elementList=dataMap['elementList'];
      message.content=map2MessageContent(dataMap, messageType);
    }else{
      message.desc=map["data"];
    }


    return message;
  }
  List<Message> string2ListMessage(List<dynamic> strings) {

    List<Message> list=[];
    print('string2ListMessage    ${strings.length}       ');
    for(int i=0;i<strings.length;i++){

      Map dataMap=json.decode(strings[i]);
      int  messageType= dataMap["messageType"];


      print('string2ListMessage   messageType    $messageType   ${dataMap}');
      Message message=Message();
      message.messageType = messageType;
      message. rand = dataMap['rand'];
      message. sender = dataMap['sender'];
      message. msgId = dataMap['msgId'];
      message. msgSeq = dataMap['msgSeq'];
      message. time = dataMap['time'];
      message.isRead = dataMap['isRead'];
      message.isPeerReaded = dataMap['isPeerReaded'];
      message.isSelf = dataMap['isSelf'];
      message.status = dataMap['status'];
      message.elementList=dataMap['elementList'];
      message.content=map2MessageContent(dataMap, messageType);
      list.add(message);
      print('返回  string2ListMessage  =================================== ${ message.elementList} ');
    }


    return list;
  }

  MessageContent map2MessageContent(Map map,int messageType) {
    MessageContent content;
    if(messageType == TextMessage.messageType) {
      content = new TextMessage();
      content.decode(map);
    }else if(messageType == ImageMessage.messageType) {
      content = new ImageMessage();
      content.decode(map);
    }else if(messageType == SoundMessage.messageType) {
      content = new SoundMessage();
      content.decode(map);
    }else if(messageType == EmojiMessage.messageType) {
      content = new EmojiMessage();
      content.decode(map);
    }else if(messageType == FileMessage.messageType) {
      content = new FileMessage();
      content.decode(map);
    }else if(messageType == VideoMessage.messageType) {
      content = new VideoMessage();
      content.decode(map);
    }else if(messageType == CustomMessage.messageType) {
      content = new CustomMessage();
      content.decode(map);
    }

    return content;
  }

  List<Conversation> map2ConversationList(List<dynamic> list){
    if(list==null)
      return [];

    var conversations=<Conversation>[];
    list.forEach((val){
      conversations.add(Conversation(val["peer"],val["conversationType"],val["unreadMessageNum"]));
    });


    return conversations;

  }

}