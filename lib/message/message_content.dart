

abstract class MessageContent
    implements MessageCoding, MessageContentView {



}

abstract class MessageCoding {
  String encode();

  void decode(String jsonStr);

  String getObjectName();
}

abstract class MessageContentView {
  String conversationDigest();
}
