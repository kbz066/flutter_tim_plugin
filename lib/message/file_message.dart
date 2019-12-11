import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class FileMessage extends MessageContent{


  static const int messageType = MessageType.File;


  String filePath;

  String fileName;



  static FileMessage obtain(String filePath,String fileName) {
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

  }

  @override
  Map encode() {
    Map map = {"filePath":this.filePath,"fileName":this.fileName};
    return map;
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }

}