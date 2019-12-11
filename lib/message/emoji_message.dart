import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class EmojiMessage extends MessageContent{
  static const int messageType = MessageType.Face;

  Uint8List emoji;
  int index;





  static EmojiMessage obtain(Uint8List emoji,int index) {
    EmojiMessage msg = new EmojiMessage();
    msg.emoji = emoji;
    msg.index=index;
    return msg;
  }

  @override
  void decode(Map map) {

  }

  @override
  Map encode() {
    Map map = {"emoji":this.emoji,"index":messageType};
    return map;
  }

  @override
  String conversationDigest() {
    return "";
  }



  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}