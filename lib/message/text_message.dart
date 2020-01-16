import 'package:flutter_tim_plugin/common_define.dart';

import 'message_content.dart';

class TextMessage extends MessageContent {
  static const int messageType = MessageType.Text;

  String text;
  List<TextDataElement> elementList;

  /// [content] 文本内容
  static TextMessage obtain(String content) {
    TextMessage msg = new TextMessage();
    msg.text = content;
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
      this.elementList = new List<TextDataElement>();
      map['elementList'].forEach((v) {
        elementList.add(new TextDataElement.fromJson(v));
      });
    }
  }

  @override
  Map encode() {
    Map map = {"text": this.text, "messageType": messageType};
    return map;
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}

class TextDataElement {
  String text;

  TextDataElement({this.text});

  TextDataElement.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
}
