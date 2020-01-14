//
//  TimMethodList.swift
//  flutter_tim_plugin
//
//  Created by kbz on 2019/12/24.
//

class TimMethodList{
    static var MethodKeyInit:String = "init"
    static var MethodKeyConfig: String = "config"
    static var MethodKeyLogin  :String = "login"
    static var MethodKeyLogout :String = "logout"
    
    static var  MethodKeySendMessage : String = "sendMessage";
    static var  MethodKeyCreateGroup : String = "createGroup";
    static var  MethodKeyInviteGroupMember : String = "inviteGroupMember";
    static var  MethodKeyApplyJoinGroup : String = "applyJoinGroup";
    static var  MethodKeyGetSelfProfile : String = "getSelfProfile";
    static var  MethodKeyGetMessage : String = "getMessage";
    
    static var  MethodKeyGetLocalMessage: String = "getLocalMessage";
    static var  MethodKeyModifySelfProfile: String = "modifySelfProfile";
    static var  MethodKeyGetConversationList: String = "getConversationList";
    
    static var  MethodKeyDeleteConversation: String = "deleteConversation";
    
    static var  MethodKeySetReadMessage: String = "setReadMessage";

    static var MethodCallBackKeyNewMessages : String = "newMessagesCallBack";
    static var MethodCallBackKeyDownloadFile: String = "DownloadFile";
    static var MethodCallBackKeyDownloadVideo: String = "DownloadVideo";
    static var MethodCallBackKeyRevokeMessage: String = "revokeMessage";
    static var MethodCallBackKeyGetUserSig: String = "getUserSig";
    static var MethodCallBackKeyUserStatus: String = "userStatusCallBack";
    

}
