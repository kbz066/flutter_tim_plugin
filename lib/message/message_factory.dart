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
    }

    return content;
  }

}