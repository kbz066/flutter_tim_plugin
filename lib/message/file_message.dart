import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class FileMessage extends MessageContent {
  static const int messageType = MessageType.File;

  String filePath;

  String fileName;
  List<MessageDataElement> elementList;

  static FileMessage obtain(String filePath, String fileName) {
    FileMessage msg = new FileMessage();
    msg.filePath = filePath;
    msg.fileName = fileName;
    return msg;
  }

  @override
  String conversationDigest() {
    // TODO: implement conversationDigest
    return null;
  }

  @override
  void decode(Map map) {
    if (map['elementList'] != null) {
      this.elementList = new List<MessageDataElement>();
      map['elementList'].forEach((v) {
        elementList.add(new MessageDataElement.fromJson(v));
      });
    }
  }

  @override
  Map encode() {
    Map map = {"filePath": this.filePath, "fileName": this.fileName};
    return map;
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}

class MessageDataElement {
  String fileName;
  int fileSize;
  int taskId;
  String uuid;

  String path;

  MessageDataElement.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    path = json['path'];
    fileSize = json['fileSize'];
    uuid = json['uuid'];
    taskId = json['taskId'];
  }
}
