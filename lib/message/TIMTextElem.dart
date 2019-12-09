

import 'package:flutter/material.dart';
import 'package:flutter_tim_plugin/common_define.dart';

class TIMTextElem  {
	String text;
	int messageType;
	int conversationType;
	String id;
	TIMTextElem({@required this.text,this.id,this.messageType=MessageType.Text,this.conversationType}) ;



	Map<String, dynamic> toJson() {

		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['text'] = this.text;
		data['userID'] = this.id;
		data['messageType'] = this.messageType;
		data['conversationType'] = this.conversationType;
		return data;
	}
}
