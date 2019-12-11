import 'package:flutter_tim_plugin/message/message_content.dart';

import '../common_define.dart';

class VideoMessage extends MessageContent{



  static const int messageType = MessageType.Video;

  String imgPath;
  String videoPath;
  int width;
  int height;
  int duration;



  static VideoMessage obtain(String imgPath, String videoPath, int width, int height, int duration) {
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
    // TODO: implement decode
  }


  @override
  Map encode() {
    Map map = {"imgPath":this.imgPath,"videoPath":this.videoPath,
      "width":this.width,"height":this.height,"duration":this.duration};
    return map;
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }

}