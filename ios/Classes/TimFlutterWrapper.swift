//
//  TimFlutterWrapper.swift
//  flutter_tim_plugin
//
//  Created by kbz on 2019/12/24.
//

class  TimFlutterWrapper :NSObject, TIMMessageListener{
    
    static let sharedInstance = TimFlutterWrapper()
    
    func onFlutterMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult){

        
        print("f方法名字。 \(call.method)")
        if(TimMethodList.MethodKeyInit == call.method){
            initTim(call: call,result: result);
        }else if(TimMethodList.MethodKeyLogin == call.method){
            login(call: call,result: result);
        }else if(TimMethodList.MethodKeySendMessage == call.method){
            sendMessage(call: call,result: result);
        }else if(TimMethodList.MethodKeyCreateGroup == call.method){
            createGroup(call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyInviteGroupMember == call.method){
            inviteGroupMember (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyApplyJoinGroup == call.method){
            applyJoinGroup (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyGetSelfProfile == call.method){
            getSelfProfile (result)
        }else if(TimMethodList.MethodKeyGetMessage == call.method){
            getMessage (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyModifySelfProfile == call.method){
            modifySelfProfile (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyLogout == call.method){
            logout (result)
        }else if(TimMethodList.MethodKeyGetLocalMessage == call.method){
           
        }else if(TimMethodList.MethodKeyDeleteConversation == call.method){
           deleteConversation (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeySetReadMessage == call.method){
           setReadMessage (call.arguments as! [String : Any],result)
        }

    
    }
    
    
    func setReadMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var conversation = getTIMConversationByID(map: map);
        
        conversation.setRead(nil, succ: {
            result(self.buildResponseMap(codeVal : 0,descVal : "setReadMessage ok"))
        }) {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        }
    }
    
    func getConversationList(_ map : [String: Any],_ result: @escaping FlutterResult){
        
    }
    func deleteConversation(_ map : [String: Any],_ result: @escaping FlutterResult){
   
        var delMsg = map["delLocalMsg"] as! Bool;
        var id = map["id"] as! Int;
        
        var type = map["conversationType"] as! Int ;
        
        TIMConversationType.init(rawValue: type);
        
           
            
        
        var res : Bool;
        
        if(delMsg){
            delMsg = (TIMManager.sharedInstance()?.deleteConversationAndMessages(TIMConversationType.init(rawValue: type)!, receiver: String(id)))!
        }else{
            delMsg = (TIMManager.sharedInstance()?.delete(TIMConversationType.init(rawValue: type)!, receiver: String(id)))!
        }
        
        result(self.buildResponseMap(codeVal : 0,descVal : delMsg))

    }

    
    func logout(_ result: @escaping FlutterResult){
        TIMManager.sharedInstance()?.logout( {
            result(self.buildResponseMap(codeVal : 0,descVal : "logout  ok"))
        }, fail: {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    func modifySelfProfile(_ map : [String: Any],_ result: @escaping FlutterResult){

        
        TIMFriendshipManager.sharedInstance()?.modifySelfProfile(map, succ: {
            result(self.buildResponseMap(codeVal : 0, descVal : "modifySelfProfile ok"))
        }, fail: {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    func getMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
         var conversation = getTIMConversationByID(map: map);
        
        var count = map["count"] as! Int;
        
        conversation.getMessage(Int32(count), last: nil, succ: {
            
            print("getMessage      =======        \($0)")
            
        },fail:{
            
            
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    
    func getSelfProfile(_ result: @escaping FlutterResult){

        TIMFriendshipManager.sharedInstance()?.getSelfProfile({
            var profile = $0;
            
            var map = [String:Any]();
            map["allowType"] = profile?.allowType.rawValue;
            map["birthday"] = profile?.birthday;
            map["faceUrl"] = profile?.faceURL;
            map["gender"] = profile?.gender.rawValue;
            map["identifier"] = profile?.identifier;
            map["nickName"] = profile?.nickname;
            map["location"] = profile?.location;
            print("getSelfProfile              \(map)")
            result(self.buildResponseMap(codeVal : 0,descVal : map))
            
        }, fail: {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }

    func applyJoinGroup(_ map : [String: Any],_ result: @escaping FlutterResult){
        var groupId = map["groupId"] as! String;
        var msg = map["reason"] as! String;
        
        
        
        TIMGroupManager.sharedInstance()?.joinGroup(groupId, msg: msg, succ: {
            result(self.buildResponseMap(codeVal : 0,descVal : "applyJoinGroup ok"))
        }, fail: {
            
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    
    func inviteGroupMember(_ map : [String: Any],_ result: @escaping FlutterResult){
        var groupId = map["groupId"] as! String;
        var memList = map["memList"] as! Array<String>;
        
        
        print("groupId       \(groupId)")
        print("memList       \(memList)")
        
        TIMGroupManager.sharedInstance()?.inviteGroupMember(groupId, members: memList, succ: {
           
            var list = Array<[String:Any]>();
            
            var results  = $0 as! Array<TIMGroupMemberResult>;
            for res  in results {
                var map = [String:Any]();
                map["result"] = res.status.rawValue;
                map["user"] = res.member;
                list.append(map);
            }
            print("inviteGroupMember        \(list)")
            
            result(self.buildResponseMap(codeVal : 0, descVal : list))
        }, fail: {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    
    func  sendMessage(call: FlutterMethodCall, result: @escaping FlutterResult){
  
        var map : [String: Any]=call.arguments as! [String : Any];
        

        var type =  map["messageType"] as! Int;
        
        switch type {
        case MessageType.Text:
            sendTextMessage(map,result)
            break;
        case MessageType.Face:
            sendEmojiMessage(map,result)
            break;
        case MessageType.Location:
            sendLocationMessage(map,result)
            break;
        case MessageType.Custom:
            sendCustomMessage(map,result)
            break;
        case MessageType.Image:
            sendImageMessage(map,result)
            break;

            
        default:
            break
        }

        
    }
    func createGroup(_ map : [String: Any],_ result: @escaping FlutterResult){
        let type = map["type"] as! String;
        let name = map["name"] as! String;
        let info = TIMCreateGroupInfo();
        info.groupName = name ;
        info.groupType = type;
        TIMGroupManager.sharedInstance()?.createGroup(info, succ: {
            result(self.buildResponseMap(codeVal : 0, descVal : $0))
        }, fail: {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })


    }
    
    func sendImageMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
              
        var timMessage = TIMMessage()
              
        var elm = TIMImageElem();
        elm.path = content["localPath"] as! String ;
        
        print("发送。localPath  \( elm.path )")
              
        timMessage.add(elm);
              
        sendMessageCallBack(MessageType.Image,map ,timMessage ,result)
    }
    
    func sendCustomMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
        
        var timMessage = TIMMessage()
        
        
        var elm = TIMCustomElem();
        elm.data = (content["data"] as! FlutterStandardTypedData).data ;
  
        
        timMessage.add(elm);
        
        sendMessageCallBack(MessageType.Custom,map ,timMessage ,result)
    }
    
    func sendLocationMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
        
        var timMessage = TIMMessage()
        
        
        var elm = TIMLocationElem();
    
       
        elm.latitude = content["latitude"] as! Double ;
        elm.longitude = content["longitude"] as! Double ;
        elm.desc = content["desc"] as! String ;
        
        timMessage.add(elm);
        
        sendMessageCallBack(MessageType.Face,map ,timMessage ,result)
    }
    
    func sendEmojiMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
        
        var timMessage = TIMMessage()
        
        
        var elm = TIMFaceElem();
        elm.data = (content["emoji"] as! FlutterStandardTypedData).data ;
        elm.index = Int32(content["index"] as! Int);
        
        timMessage.add(elm);
        
        sendMessageCallBack(MessageType.Face,map ,timMessage ,result)
    }
    
    func sendTextMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
        
        var timMessage = TIMMessage()
        
        
        var elm = TIMTextElem();
        elm.text = content["text"] as! String ;
        
        
        timMessage.add(elm);
        
        sendMessageCallBack(MessageType.Text,map ,timMessage ,result)
    }
    
    func sendMessageCallBack(_ type : Int,_ map : [String:Any],_ timMessage : TIMMessage,  _ result: @escaping FlutterResult){
        
        var conversation = getTIMConversationByID(map: map);
  
        print("sendMessageCallBack        \(timMessage)")
        
        conversation.send(timMessage, succ: {
            
            switch(type){
            case MessageType.Text,
                 MessageType.Face,
                 MessageType.Location:
        
                result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.basicMessage2String(timMessage)))
                
                break
            case MessageType.Custom:
                result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.customMessage2String(timMessage)))
                break
                
                
            default:
                break
            }
                   print("sendMessageCallBack。  ========================           succ")

        }, fail: {
            print("sendMessageCallBack。  =====================  fail   ")
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })

        
    }
    
    
    func  login(call: FlutterMethodCall, result: @escaping FlutterResult){
        var map : [String: Any]=call.arguments as! [String : Any];
        
        var param = TIMLoginParam();
        param.identifier = map["userID"] as! String;
      
        param.userSig = GenerateTestUserSig.genTestUserSig(param.identifier)
        
  
        
       
        TIMManager.sharedInstance()?.login(param, succ: {
            result(self.buildResponseMap(codeVal : 0, descVal : "login  ok"))
      
            
        }, fail: {
            result(self.buildResponseMap(codeVal : $0 ,descVal : $1))
            
        } )
        
        

    }
    ///初始化
    func  initTim(call: FlutterMethodCall, result: @escaping FlutterResult){
        print( type(of: call.arguments))
        
        var config = TIMSdkConfig();
        config.sdkAppId = 1400294549
        config.logLevel = TIMLogLevel.LOG_DEBUG;
        
        var userConfig = TIMUserConfig();
     
        
        
        
        TIMManager.sharedInstance()?.add(self)
        

        var initState = TIMManager.sharedInstance()?.initSdk(config)
        
        
        print("f初始化---------------------  \(initState)")
        result(buildResponseMap(codeVal : initState! ,descVal : initState!))
    }
    
    func onNewMessage(_ msgs: [Any]!) {
        
        
    }
    
    func buildResponseMap(codeVal : Int32,descVal : Any)-> [String:Any]{
        
        var resMap = [String:Any]();
        resMap["code"] = Int(codeVal);
        resMap["data"] = descVal;
        return resMap;
    }
    
    func getTIMConversationByID(map : [String:Any])-> TIMConversation{
        
        

        var type = map["conversationType"] as! Int ;
        var id = map["id"] as! Int;
    
       
        return TIMManager.sharedInstance().getConversation( TIMConversationType.init(rawValue: type)!, receiver:  String(id))
  
    }

}

