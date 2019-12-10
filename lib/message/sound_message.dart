import 'dart:convert';

import '../common_define.dart';

import 'message_content.dart';

class SoundMessage extends MessageContent{
  static const int messageType = MessageType.Sound;
  String localPath;

  int duration;

  List<MessageDataElement> elementList;

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

    if (map['elementList'] != null) {
      this.elementList = new List<MessageDataElement>();
      map['elementList'].forEach((v) {
        elementList.add(new MessageDataElement.fromJson(v));
      });
    }
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

class MessageDataElement {
  int duration;
  String path;
  int dataSize;
  String uuid;
  int taskId;

  MessageDataElement(
      {this.duration, this.path, this.dataSize, this.uuid, this.taskId});

  MessageDataElement.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    path = json['path'];
    dataSize = json['dataSize'];
    uuid = json['uuid'];
    taskId = json['taskId'];
  }


}