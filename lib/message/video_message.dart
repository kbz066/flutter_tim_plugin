import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class VideoMessage extends MessageContent {
  static const int messageType = MessageType.Video;

  String imgPath;
  String videoPath;
  int width;
  int height;
  int duration;
  List<MessageDataElement> elementList;

  static VideoMessage obtain(
      String imgPath, String videoPath, int width, int height, int duration) {
    VideoMessage msg = new VideoMessage();
    msg.imgPath = imgPath;
    msg.videoPath = videoPath;
    msg.width = width;
    msg.height = height;
    msg.duration = duration;
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
    Map map = {
      "imgPath": this.imgPath,
      "videoPath": this.videoPath,
      "width": this.width,
      "height": this.height,
      "duration": this.duration
    };
    return map;
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}

class MessageDataElement {
  String videoPath;
  String snapshotPath;
  int snapshotWidth;
  int snapshotHeight;
  int duaration;
  String snapshotType;
  String videoUUID;
  String snapshotUUID;
  String videoType;
  int videoSize;

  MessageDataElement.fromJson(Map<String, dynamic> json) {
    videoPath = json['videoPath'];
    snapshotPath = json['snapshotPath'];
    snapshotWidth = json['snapshotWidth'];
    snapshotHeight = json['snapshotHeight'];
    duaration = json['duaration'];
    snapshotType = json['snapshotType'];
    videoUUID = json['videoUUID'];
    snapshotUUID = json['snapshotUUID'];
    videoType = json['videoType'];
    videoSize = json['videoSize'];
  }
}
