import '../common_define.dart';
import 'message_content.dart';

class ImageMessage extends MessageContent {
  static const int messageType = MessageType.Image;

  String localPath;

  List<MessageDataElement> elementList;

  /// [localPath] 本地路径，
  static ImageMessage obtain(String localPath) {
    ImageMessage msg = new ImageMessage();
    msg.localPath = localPath;
    return msg;
  }

  @override
  void decode(Map map) {
    if (map['elementList'] != null) {
      this.elementList = new List<MessageDataElement>();
      (map['elementList'] as List).forEach((v) {
        elementList.add(MessageDataElement.fromJson(v));
      });
    }
  }

  @override
  Map encode() {
    Map map = {"localPath": this.localPath, "messageType": messageType};
    return map;
  }

  @override
  String conversationDigest() {
    return "";
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}

class MessageDataElement {
  String path;
  int imageFormat;
  int level;
  List<TIMImage> imageList;
  int taskId;

  MessageDataElement.fromJson(Map<dynamic, dynamic> json) {
    path = json['path'];
    imageFormat = json['imageFormat'];
    level = json['level'];
    if (json['imageList'] != null) {
      imageList = new List<TIMImage>();
      (json['imageList'] as List).forEach((v) {
        imageList.add(TIMImage.fromJson(v));
      });
    }
    taskId = json['taskId'];
  }
}

class TIMImage {
  int type;
  String url;
  String uuid;
  int size;
  int height;
  int width;

  TIMImage.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    width = json['width'];
    type = json['type'];
    uuid = json['uuid'];
    url = json['url'];
    height = json['height'];
  }
}
