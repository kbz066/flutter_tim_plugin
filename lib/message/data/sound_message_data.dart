class SoundMessageData {
  int rand;
  String sender;
  String msgId;
  int msgSeq;
  int time;
  bool isSelf;
  int status;
  List<MessageDataElement> elementList;


  SoundMessageData(
      {this.rand,
        this.sender,
        this.msgId,
        this.msgSeq,
        this.time,
        this.elementList,
        this.isSelf,
        this.status});

  SoundMessageData.fromJson(Map<String, dynamic> json) {
    rand = json['rand'];
    sender = json['sender'];
    msgId = json['msgId'];
    msgSeq = json['msgSeq'];
    time = json['time'];
    if (json['elementList'] != null) {
      elementList = new List<MessageDataElement>();
      json['elementList'].forEach((v) {
        elementList.add(new MessageDataElement.fromJson(v));
      });
    }
    isSelf = json['isSelf'];
    status = json['status'];
  }

}

class MessageDataElement {
  int duration;
  String path;
  int dataSize;
  String uuid;
  int taskId;

  MessageDataElement(
      {this.duration, this.path, this.dataSize, this.uuid, this.taskId});

  MessageDataElement.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    path = json['path'];
    dataSize = json['dataSize'];
    uuid = json['uuid'];
    taskId = json['taskId'];
  }


}