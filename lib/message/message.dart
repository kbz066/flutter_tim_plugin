import 'package:flutter_tim_plugin/message/message_content.dart';

class Message {
  int code;
  int messageType;
  String desc;

  int rand;
  String sender;
  String msgId;
  int msgSeq;
  int time;
  bool isSelf;
  bool isPeerReaded;
  bool isRead;
  int status;

  List<dynamic> elementList;
  MessageContent content;
}
