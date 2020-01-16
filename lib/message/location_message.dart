import '../common_define.dart';

import 'message_content.dart';

class LocationMessage extends MessageContent {
  static const int messageType = MessageType.Location;
  double latitude; //设置纬度
  double longitude; //设置经度
  String desc;

  static LocationMessage obtain(
    double Latitude,
    double longitude,
    String desc,
  ) {
    LocationMessage msg = new LocationMessage();
    msg.latitude = Latitude;
    msg.longitude = longitude;
    msg.desc = desc;
    return msg;
  }

  @override
  void decode(Map map) {}

  @override
  Map encode() {
    Map map = {
      "latitude": this.latitude,
      "longitude": this.longitude,
      "desc": this.desc
    };
    return map;
  }

  @override
  String conversationDigest() {
    return "语音";
  }

  @override
  int getMessageType() {
    // TODO: implement getMessageType
    return messageType;
  }
}
