class TimMethodKey{
  //method list

  static const String Init = 'init';
  static const String Config = 'config';
  static const String Login = 'login';
  static const String Disconnect = 'disconnect';
  static const String SendMessage = 'sendMessage';
  static const String RefreshUserInfo = 'refreshUserInfo';
  static const String JoinChatRoom = 'joinChatRoom';
  static const String QuitChatRoom = 'quitChatRoom';
  static const String GetHistoryMessage = 'getHistoryMessage';
  static const String GetHistoryMessages = 'getHistoryMessages';
  static const String GetMessage = 'GetMessage';
  static const String GetConversationList = 'getConversationList';
  static const String GetConversationListByPage = 'getConversationListByPage';
  static const String GetConversation = 'GetConversation';
  static const String GetChatRoomInfo = 'getChatRoomInfo';
  static const String ClearMessagesUnreadStatus = 'clearMessagesUnreadStatus';
  static const String SetServerInfo = 'setServerInfo';
  static const String SetCurrentUserInfo = 'setCurrentUserInfo';
  static const String InsertIncomingMessage = 'insertIncomingMessage';
  static const String InsertOutgoingMessage = 'insertOutgoingMessage';
  static const String GetTotalUnreadCount = 'getTotalUnreadCount';
  static const String GetUnreadCountTargetId = 'getUnreadCountTargetId';
  static const String GetUnreadCountConversationTypeList = 'getUnreadCountConversationTypeList';
  static const String SetConversationNotificationStatus = 'setConversationNotificationStatus';
  static const String GetConversationNotificationStatus = 'getConversationNotificationStatus';
  static const String RemoveConversation = 'RemoveConversation';
  static const String GetBlockedConversationList = 'getBlockedConversationList';
  static const String SetConversationToTop = 'setConversationToTop';
  static const String GetTopConversationList = 'getTopConversationList';
  static const String DeleteMessages = 'DeleteMessages';
  static const String DeleteMessageByIds = 'DeleteMessageByIds';
  static const String AddToBlackList = 'AddToBlackList';
  static const String RemoveFromBlackList = 'RemoveFromBlackList';
  static const String GetBlackListStatus = 'GetBlackListStatus';
  static const String GetBlackList = 'GetBlackList';
  static const String DownloadFile = 'DownloadFile';
  static const String DownloadVideo = 'DownloadVideo';


  static const String MethodCallBackKeyInit = 'initCallBack';
  static const String MethodCallBackKeyNewMessages = 'newMessagesCallBack';
  static const String MethodCallBackKeyRefreshUserInfo = 'refreshUserInfoCallBack';
  static const String MethodCallBackKeyReceiveMessage = 'receiveMessageCallBack';
  static const String MethodCallBackKeyJoinChatRoom = 'joinChatRoomCallBack';
  static const String MethodCallBackKeyQuitChatRoom = 'quitChatRoomCallBack';
  static const String MethodCallBackKeyUploadMediaProgress = 'uploadMediaProgressCallBack';
  static const String MethodCallBackKeyGetRemoteHistoryMessages = 'getRemoteHistoryMessagesCallBack';
  static const String MethodCallBackKeyConnectionStatusChange = 'ConnectionStatusChangeCallBack';
  static const String MethodCallBackKeySendDataToFlutter = 'SendDataToFlutterCallBack';
}