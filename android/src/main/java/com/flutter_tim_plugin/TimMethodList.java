package com.flutter_tim_plugin;

public class TimMethodList {
    //method list
    static String MethodKeyInit = "init";
    static String MethodKeyConfig = "config";
    static String MethodKeyLogin = "login";
    static String MethodKeyLogout = "logout";

    static String MethodKeyDisconnect = "disconnect";
    static String MethodKeySendMessage = "sendMessage";
    static String MethodKeyRefrechUserInfo = "refreshUserInfo";
    static String MethodKeyJoinChatRoom = "joinChatRoom";
    static String MethodKeyQuitChatRoom = "quitChatRoom";
    static String MethodKeyCreateGroup ="createGroup";
    static String MethodKeyInviteGroupMember ="inviteGroupMember";
    static String MethodKeyDeleteConversation = "deleteConversation";
    static String MethodKeyGetMessage = "getMessage";
    static String MethodKeySetReadMessage = "setReadMessage";

    static String MethodKeyGetLocalMessage ="getLocalMessage";
    static String MethodKeyGetConversationList ="getConversationList";
    static String MethodKeyGetConversationListByPage ="getConversationListByPage";
    static String MethodKeyGetConversation ="getConversation";
    static String MethodKeyGetChatRoomInfo ="getChatRoomInfo";
    static String MethodKeyClearMessagesUnreadStatus ="clearMessagesUnreadStatus";
    static String MethodKeySetServerInfo ="setServerInfo";
    static String MethodKeySetCurrentUserInfo = "setCurrentUserInfo";
    static String MethodKeyInsertIncomingMessage = "insertIncomingMessage";
    static String MethodKeyInsertOutgoingMessage = "insertOutgoingMessage";
    static String MethodKeyGetTotalUnreadCount = "getTotalUnreadCount";
    static String MethodKeyGetUnreadCountTargetId = "getUnreadCountTargetId";
    static String MethodKeyGetUnreadCountConversationTypeList = "getUnreadCountConversationTypeList";
    static String MethodKeySetConversationNotificationStatus = "setConversationNotificationStatus";
    static String MethodKeyGetConversationNotificationStatus = "getConversationNotificationStatus";
    static String MethodKeyRemoveConversation = "RemoveConversation";
    static String MethodKeyGetBlockedConversationList = "getBlockedConversationList";
    static String MethodKeySetConversationToTop = "setConversationToTop";
    static String MethodKeyGetTopConversationList = "getTopConversationList";
    static String MethodKeyDeleteMessages = "DeleteMessages";
    static String MethodKeyDeleteMessageByIds = "DeleteMessageByIds";
    static String MethodKeyAddToBlackList = "AddToBlackList";
    static String MethodKeyRemoveFromBlackList = "RemoveFromBlackList";
    static String MethodKeyGetBlackListStatus = "GetBlackListStatus";
    static String MethodKeyGetBlackList = "GetBlackList";
    static String MethodKeyDownloadFile = "DownloadFile";
    static String MethodKeyDownloadVideo= "DownloadVideo";


    //callback method list，以下方法是有 native 代码触发，有 flutter 处理
    static String MethodCallBackKeyInit = "initCallBack";
    static String MethodCallBackKeyNewMessages = "newMessagesCallBack";
    static String MethodCallBackKeyUserStatus= "userStatusCallBack";
    static String MethodCallBackKeyRefrechUserInfo = "refreshUserInfoCallBack";
    static String MethodCallBackKeyReceiveMessage = "receiveMessageCallBack";
    static String MethodCallBackKeyJoinChatRoom = "joinChatRoomCallBack";
    static String MethodCallBackKeyQuitChatRoom = "quitChatRoomCallBack";
    static String MethodCallBackKeyUploadMediaProgress = "uploadMediaProgressCallBack";
    static String MethodCallBackKeygetRemoteHistoryMessages = "getRemoteHistoryMessagesCallBack";
    static String MethodCallBackKeyConnectionStatusChange = "ConnectionStatusChangeCallBack";
    static String MethodCallBackKeySendDataToFlutter = "SendDataToFlutterCallBack";
}
