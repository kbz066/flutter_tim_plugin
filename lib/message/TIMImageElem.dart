import 'package:flutter/material.dart';
import 'package:flutter_tim_plugin/common_define.dart';
class TIMImageElem{
  String path;
  String id;
  int messageType;
  int conversationType;
  TIMImageElem({@required this.path,@required this.id,this.messageType=MessageType.Image,this.conversationType});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['messageType'] = this.messageType;
    data['id'] = this.id;
    data['conversationType'] = this.conversationType;
    return data;
  }
}