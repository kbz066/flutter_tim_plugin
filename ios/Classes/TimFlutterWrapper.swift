//
//  TimFlutterWrapper.swift
//  flutter_tim_plugin
//
//  Created by kbz on 2019/12/24.
//

class  TimFlutterWrapper :NSObject, TIMMessageListener{
    
    static let sharedInstance = TimFlutterWrapper()
    
    var mChannel : FlutterMethodChannel?;
    
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
           getLocalMessage (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyDeleteConversation == call.method){
           deleteConversation (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeySetReadMessage == call.method){
           setReadMessage (call.arguments as! [String : Any],result)
        }else if(TimMethodList.MethodKeyGetConversationList == call.method){
           getConversationList (result)
        }else if(TimMethodList.MethodCallBackKeyDownloadFile == call.method){
           downloadFile (call.arguments as! [String : Any],result,false)
        }else if(TimMethodList.MethodCallBackKeyDownloadVideo == call.method){
           downloadFile (call.arguments as! [String : Any],result,true)
        }



    
    }
    
    

    func downloadFile(_ map : [String: Any],_ result: @escaping FlutterResult,_ isVideo : Bool){
            
        var conversation = getTIMConversationByID(map: map);
       
        
        var locator = TIMMessageLocator();
                    
        locator.rand = UInt64(map["rand"] as! Int);
        locator.seq = UInt64(map["seq"] as! Int);
        locator.time = map["timestamp"] as! Int;
       // locator.sessType = TIMConversationType.init(rawValue: map["conversationType"] as! Int)!
    
        locator.isSelf = map["self"] as! Bool;
       // locator.sessId = String(map["id"] as! Int);
        
        
        print("locator     rand   ====== ==== == ==    \(locator.rand)")
        print("locator      seq  ====== ==== == ==    \(locator.seq)")
        print("locator        ====== ==== == ==    \(locator.time)")
        print("locator       sessType ====== ==== == ==    \(locator.sessType.rawValue)")
                print("locator      isSelf  ====== ==== == ==    \(locator.isSelf)")
                print("locator      sessId  ====== ==== == ==    \(locator.time)")
        
        conversation.findMessages([locator], succ: {
            var list = $0;
            
            if (list?.count ?? 0) > 0 {
                var element =  (list![0] as! TIMMessage).getElem(0) ;
                self.downloadFileByType(element!, map["path"] as! String,result);
                
            }
            
        }) {
             result(self.buildResponseMap(codeVal : $0,descVal : $1))
        }


    }
    
    func downloadVideo(_ elm : TIMVideoElem,_ map :[String:Any],_ result: @escaping FlutterResult){
        elm.video.getVideo(map["videoPath"] as! String,succ: {
            elm.snapshot.getImage(map["snapshotPath"] as! String, succ: {
                   result(self.buildResponseMap(codeVal : 0,descVal : "download ok"))
            }) {
                 result(self.buildResponseMap(codeVal : $0,descVal : $1))
            }
        }){
                result(self.buildResponseMap(codeVal : $0,descVal : $1))
        }
    }
    
    func downloadFileByType(_ elm : TIMElem,_ path :String,_ result: @escaping FlutterResult){
        
        
         func fail(code: Int32, desc: String?)-> Void{
            result(self.buildResponseMap(codeVal : code,descVal : desc))
            print("downloadFileByType ==== ====   fail    \(code)  \(desc)")
        };
        
         func succ(){
            result(self.buildResponseMap(codeVal : 0,descVal : "download ok"))
            print("downloadFileByType ==== ====   succ")
        };
        
        
        if(elm is TIMImageElem){
            var imageElm = elm as! TIMImageElem;
            (imageElm.imageList[0] as! TIMImage).getImage(path, succ: succ,fail: fail )
            
        }else if(elm is TIMSoundElem){
            var soundElm = elm as! TIMSoundElem;
            soundElm.getSound(path, succ: succ,fail: fail )
        }else if(elm is TIMFileElem){
            var fileElm = elm as! TIMFileElem;
            fileElm.getFile(path, succ: succ,fail: fail )
        }
        
    }
    
    
    func setReadMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        let conversation = getTIMConversationByID(map: map);
        
        conversation.setRead(nil, succ: {
            result(self.buildResponseMap(codeVal : 0,descVal : "setReadMessage ok"))
        }) {
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        }
    }
    
    func getConversationList(_ result: @escaping FlutterResult){
        
        var conversationList = TIMManager.sharedInstance()?.getConversationList() ;
        var list = [Any]();
        for timConversation in conversationList! {
            var map = [String:Any]();
            map["unreadMessageNum"] = timConversation.getUnReadMessageNum();
            map["conversationType"] = timConversation.getType().rawValue;
            map["peer"] = timConversation.getReceiver();
            list.append(map)
        }
        result(self.buildResponseMap(codeVal : 0,descVal : list))
    }
    func deleteConversation(_ map : [String: Any],_ result: @escaping FlutterResult){
   
        var delMsg = map["delLocalMsg"] as! Bool;
        var id = map["id"] as! Int;
        
        var type = map["conversationType"] as! Int ;
        
        TIMConversationType.init(rawValue: type);
        
           
            
        
        var res : Bool;
        
        if(delMsg){
            res = (TIMManager.sharedInstance()?.deleteConversationAndMessages(TIMConversationType.init(rawValue: type)!, receiver: String(id)))!
        }else{
            res = (TIMManager.sharedInstance()?.delete(TIMConversationType.init(rawValue: type)!, receiver: String(id)))!
        }
        
        result(self.buildResponseMap(codeVal : 0,descVal : res))

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
            let arguments = MessageFactory.message2List(timList: $0 as! Array<TIMMessage>);
                  
            result(self.buildResponseMap(codeVal : 0,descVal : arguments))

            print("getMessage      =======        \($0)")
            
        },fail:{
            
            
            result(self.buildResponseMap(codeVal : $0,descVal : $1))
        })
    }
    func getLocalMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
         var conversation = getTIMConversationByID(map: map);
        
        var count = map["count"] as! Int;
        
        conversation.getMessage(Int32(count), last: nil, succ: {
            let arguments = MessageFactory.message2List(timList: $0 as! Array<TIMMessage>);
                  
            result(self.buildResponseMap(codeVal : 0,descVal : arguments))
            print("getLocalMessage      =======        \($0)")
            
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
        case MessageType.Sound:
            sendSoundMessage(map,result)
            break;
        case MessageType.Video:
            sendVideoMessage(map,result)
            
            break;
        case MessageType.File:
            sendFileMessage(map,result)
                
            break;
        default:
            break
        }

        
    }
    
    func sendFileMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
                      
             var timMessage = TIMMessage()
                      
             var elm = TIMFileElem();
             elm.path = content["filePath"] as! String ;
             elm.filename = content["fileName"] as! String ;

             print("发送。   sendFileMessage  \( elm.path )")
                      
             timMessage.add(elm);
                      
             sendMessageCallBack(MessageType.File,map ,timMessage ,result)
    }
    
    func sendVideoMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        
        let content = map["content"] as! [String : Any];
                 
        let timMessage = TIMMessage()
                 
        let elm = TIMVideoElem();
        let video = TIMVideo();
        let snapshot = TIMSnapshot();
        
        video.duration = Int32(content["duration"] as! Int)
        
        snapshot.width = Int32(content["width"] as! Int);
        snapshot.height = Int32(content["height"] as! Int);
        
        elm.snapshot = snapshot;
        elm.video = video;
        
        elm.snapshotPath = content["imgPath"] as! String ;
        elm.videoPath = content["videoPath"] as! String ;
        
        print("发送。video snapshotPath   \( elm.snapshotPath )")
             print("发送。video videoPath   \( elm.videoPath )")
                 
        timMessage.add(elm);
                 
        sendMessageCallBack(MessageType.Video,map ,timMessage ,result)
        
        
        
  
    }
    
    func sendSoundMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
                 
        var timMessage = TIMMessage()
                 
        var elm = TIMSoundElem();
        elm.path = content["localPath"] as! String ;
        elm.second = Int32(content["duration"] as! Int)
        print("发送。lsound   ocalPath  \( elm.path )")
                 
        timMessage.add(elm);
                 
        sendMessageCallBack(MessageType.Image,map ,timMessage ,result)
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
        
        sendMessageCallBack(MessageType.Sound,map ,timMessage ,result)
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
            case MessageType.Image:
                   result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.soundMessage2String(timMessage)))
   
                break
                
            case MessageType.Sound:
                result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.soundMessage2String(timMessage)))
                
                break
            case MessageType.Video:
                result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.videoMessage2String(timMessage)))
            case MessageType.File:
                result(self.buildResponseMap(codeVal : 0, descVal :MessageFactory.fileMessage2String(timMessage)))
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
        TIMManager.sharedInstance()?.setUserConfig(userConfig);
        

        var initState = TIMManager.sharedInstance()?.initSdk(config)
        
        
        print("f初始化---------------------  \(initState)")
        result(buildResponseMap(codeVal : initState! ,descVal : initState!))
    }
    
    func onNewMessage(_ msgs: [Any]!) {
        let arguments = MessageFactory.message2List(timList: msgs as! Array<TIMMessage>);
        
        mChannel?.invokeMethod(TimMethodList.MethodCallBackKeyNewMessages,arguments: arguments )
        print("onNewMessage                 \(msgs)")
        
    }
    
    func buildResponseMap(codeVal : Int32,descVal : Any)-> [String:Any]{
        
        var resMap = [String:Any]();
        resMap["code"] = Int(codeVal);
        resMap["data"] = descVal;
        return resMap;
    }
    
    func getTIMConversationByID(map : [String:Any])-> TIMConversation{
        
        

        let type = map["conversationType"] as! Int ;
        let id = map["id"] as! Int;
    
     
        return TIMManager.sharedInstance().getConversation( TIMConversationType.init(rawValue: type)!, receiver:  String(id))
  
    }
     func saveChannel(channel : FlutterMethodChannel) {
         mChannel = channel;
    }
}

