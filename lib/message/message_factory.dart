import 'dart:core';
import 'dart:convert' show json;
import 'dart:math';

import 'package:flutter_tim_plugin/message/emoji_message.dart';
import 'package:flutter_tim_plugin/message/sound_message.dart';
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

  Message string2Message(String msgJsonStr) {
    if(TypeUtil.isEmptyString(msgJsonStr)) {
      return null;
    }
    print('decode 前  ${msgJsonStr}');
    Map map = json.decode(msgJsonStr);
    print('decode 后  ${map}');
    return null;
  }

//  Conversation string2Conversation(String conJsonStr) {
//    if(TypeUtil.isEmptyString(conJsonStr)) {
//      return null;
//    }
//    Map map = json.decode(conJsonStr);
//    return map2Conversation(map);
//  }
//
//  ChatRoomInfo map2ChatRoomInfo(Map map) {
//    ChatRoomInfo chatRoomInfo = new ChatRoomInfo();
//    chatRoomInfo.targetId = map["targetId"];
//    chatRoomInfo.memberOrder = map["memberOrder"];
//    chatRoomInfo.totalMemeberCount = map["totalMemeberCount"];
//    List memList = new List();
//    for(Map memMap in map["memberInfoList"]) {
//        memList.add(map2ChatRoomMemberInfo(memMap));
//    }
//    chatRoomInfo.memberInfoList = memList;
//    return chatRoomInfo;
//  }
//
//  ChatRoomMemberInfo map2ChatRoomMemberInfo(Map map) {
//    ChatRoomMemberInfo chatRoomMemberInfo = new ChatRoomMemberInfo();
//    chatRoomMemberInfo.userId = map["userId"];
//    chatRoomMemberInfo.joinTime = map["joinTime"];
//    return chatRoomMemberInfo;
//  }
//
  Message map2Message(Map map,int messageType) {
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
      message.status = dataMap['status'];
      message.content=map2MessageContent(dataMap, messageType);
    }else{
      message.desc=map["data"];
    }


    return message;
  }
//
//  Conversation map2Conversation(Map map) {
//    Conversation con = new Conversation();
//    con.conversationType = map["conversationType"];
//    con.targetId = map["targetId"];
//    con.unreadMessageCount = map["unreadMessageCount"];
//    con.receivedStatus = map["receivedStatus"];
//    con.sentStatus = map["sentStatus"];
//    con.sentTime = map["sentTime"];
//    con.isTop = map["isTop"];
//    con.objectName = map["objectName"];
//    con.senderUserId = map["senderUserId"];
//    con.latestMessageId = map["latestMessageId"];
//
//    String contenStr = map["content"];
//    MessageContent content = string2MessageContent(contenStr,con.objectName);
//    if(content != null) {
//      con.latestMessageContent = content;
//    }else {
//      if(contenStr == null || contenStr.length <=0) {
//        print("该会话没有消息 type:"+con.conversationType.toString() +" targetId:"+con.targetId);
//      }else {
//        print(con.objectName+":该消息不能被解析!消息内容被保存在 Conversation.originContentMap 中");
//        Map map = json.decode(contenStr.toString());
//        con.originContentMap = map;
//      }
//    }
//    return con;
//  }
//
//
  MessageContent map2MessageContent(Map map,int messageType) {
    MessageContent content;
    if(messageType == TextMessage.messageType) {
      content = new TextMessage();
    //  content.decode(contentS);
    }else if(messageType == ImageMessage.messageType) {
      content = new ImageMessage();
      content.decode(map);
    }else if(messageType == SoundMessage.messageType) {
      content = new SoundMessage();
      content.decode(map);
    }else if(messageType == EmojiMessage.messageType) {
      content = new EmojiMessage();
      content.decode(map);
    }
//    else if(messageType == VoiceMessage.objectName) {
//      content = new VoiceMessage();
//      content.decode(contentS);
//    }else if(objectName == SightMessage.objectName) {
//      content = new SightMessage();
//      content.decode(contentS);
//    }
    return content;
  }
//
//
//  Map messageContent2Map(MessageContent content) {
//    Map map = new Map();
//    return map;
//  }
}