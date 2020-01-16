// 会话类型
class TIMConversationType {
  static const int Invalid = 0;
  static const int C2C = 1;
  static const int Group = 2;
  static const int System = 3;
}

//消息类型
class MessageType {
  static const int Invalid = 0;
  static const int Text = 1;

  static const int Image = 2;
  static const int Sound = 3;
  static const int Custom = 4;
  static const int File = 5;
  static const int GroupTips = 6;
  static const int Face = 7;
  static const int Location = 8;
  static const int GroupSystem = 9;
  static const int SNSTips = 10;
  static const int ProfileTips = 11;
  static const int Video = 12;
}

//图片类型
class TIMImageType {
  static const int Original = 0;
  static const int Thumb = 1;
  static const int Large = 1;
}

//消息发送状态
class TIMSentStatus {
  static const int Sending = 10; //发送中
  static const int Failed = 20; //发送失败
  static const int Sent = 30; //发送成功
}

//消息方向
class TIMMessageDirection {
  static const int Send = 1;
  static const int Receive = 2;
}

//消息接收状态
class TIMReceivedStatus {
  static const int Unread = 0; //未读
  static const int Read = 1; //已读
  static const int Listened = 2; //已听，语音消息
  static const int Downloaded = 4; //已下载
  static const int Retrieved = 8; //已经被其他登录的多端收取过
  static const int MultipleReceive = 16; //被多端同时收取
}

//回调状态
class TIMOperationStatus {
  static const int Success = 0;
  static const int Failed = 1;
}

//消息免打扰状态
class TIMConversationNotificationStatus {
  static const int DoNotDisturb = 0; //免打扰
  static const int Notify = 1; //新消息通知
}

//群组类型
class TIMGroupType {
  static const String Private = "Private";
  static const String Public = "Public";
  static const String ChatRoom = "ChatRoom";
  static const String AVChatRoom = "AVChatRoom";
  static const String BChatRoom = "BChatRoom";
}

//聊天室成员顺序
class TIMChatRoomMemberOrder {
  static const int Asc = 1; //升序，最早加入
  static const int Desc = 2; //降序，最晚加入
}

//用户黑名单状态
class TIMBlackListStatus {
  static const int In = 0; //在黑名单中
  static const int NotIn = 1; //不在黑名单中
}

class TIMConnectionStatus {
  static const int Connected = 0; //连接成功
  static const int Connecting = 1; //连接中
  static const int KickedByOtheTIMlient = 2; //该账号在其他设备登录，导致当前设备掉线
  static const int NetworkUnavailable = 3; //网络不可用
  static const int TokenIncorrect = 4; //token 非法，此时无法连接 im，需重新获取 token
  static const int UserBlocked = 5; //用户被封禁
}



