import 'dart:typed_data';

import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class CustomMessage extends MessageContent{


  static const int messageType = MessageType.Custom;

  Uint8List data;

  List<MessageDataElement> elementList;

  static CustomMessage obtain(Uint8List data) {

    CustomMessage msg = new CustomMessage();
    msg.data = data;

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
    Map map = {"data":this.data};
    return map;
  }
  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }



}
class MessageDataElement {

  Uint8List data;



  MessageDataElement.fromJson(Map<String, dynamic> json) {

    this.data =Uint8List.fromList( List<int>.from(json['data']));

  }
}