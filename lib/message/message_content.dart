

abstract class MessageContent implements MessageCoding, MessageContentView {


}

abstract class MessageCoding {
  Map encode();


  void decode(Map map);
  int getMessageType();
}

abstract class MessageContentView {
  String conversationDigest();
}
