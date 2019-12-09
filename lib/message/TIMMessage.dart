class TIMMessage{
  int rand;
  String sender;
  String msgId;
  int msgSeq;
  int time;
  bool isSelf;
  int status;
  List<TestElemant> element;
  TIMMessage.fromJson(Map<dynamic, dynamic> json) {
    rand = json['rand'];
    sender = json['sender'];
    msgId = json['msgId'];
    msgSeq = json['msgSeq'];
    time = json['time'];
    isSelf = json['isSelf'];
    status = json['status'];


    if (json['element'] != null) {
      element = new List<TestElemant>();(json['element'] as List).forEach((v) { element.add(new TestElemant.fromJson(v)); });
    }
  }
}