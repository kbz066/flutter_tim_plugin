import 'dart:convert';

import '../common_define.dart';
import 'data/sound_message_data.dart';
import 'message_content.dart';

class SoundMessage extends MessageContent{
  static const int messageType = MessageType.Sound;
  String localPath;

  int duration;
  SoundMessageData data;

  /// [localPath] 本地路径，
  ///
  /// [duration] 语音时长，单位 秒
  static SoundMessage obtain(String localPath,int duration) {
    SoundMessage msg = new SoundMessage();
    msg.localPath = localPath;
    msg.duration = duration;
    return msg;
  }

  @override
  void decode(Map map) {


   // this.data = SoundMessageData.fromJson(map);
  }

  @override
  Map encode() {
    Map map = {"localPath":this.localPath,"duration":this.duration,};
    return map;
  }

  @override
  String conversationDigest() {
    return "语音";
  }



  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}