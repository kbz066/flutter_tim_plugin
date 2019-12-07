

class TIMMessage  {
	String text;
	int type;

	TIMMessage({this.text}) ;



	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['text'] = this.text;
		data['type'] = this.type;
		return data;
	}
}
