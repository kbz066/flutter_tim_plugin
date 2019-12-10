import 'dart:convert' show json;
import 'package:flutter_tim_plugin/common_define.dart';

import 'message_content.dart';

class VoiceMessage extends MessageContent {

  static const int messageType = MessageType.Video;
  String localPath;
  String remoteUrl;
  int duration;


  /// [localPath] 本地路径，
  ///
  /// [duration] 语音时长，单位 秒
  static VoiceMessage obtain(String localPath,int duration) {
    VoiceMessage msg = new VoiceMessage();
    msg.localPath = localPath;
    msg.duration = duration;
    return msg;
  }

  @override
  void decode(Map map) {


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



