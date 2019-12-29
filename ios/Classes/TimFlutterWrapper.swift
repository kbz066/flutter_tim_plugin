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
        }else if(TimMethodList.SendMessage == call.method){
            sendMessage(call: call,result: result);
        }
        
     
    }
    func  sendMessage(call: FlutterMethodCall, result: @escaping FlutterResult){
  
        var map : [String: Any]=call.arguments as! [String : Any];
        

        var type =  map["messageType"] as! Int;
        
        switch type {
        case MessageType.Text:
            sendTextMessage(map,result)
            break;

        default:
            break
        }

        
    }
    
    func sendTextMessage(_ map : [String: Any],_ result: @escaping FlutterResult){
        var content = map["content"] as! [String : Any];
        
        var timMessage = TIMMessage()
        
        
        var textElm = TIMTextElem();
        textElm.text = content["text"] as! String ;
        
        
        timMessage.add(textElm);
        
        sendMessageCallBack(MessageType.Text,map ,timMessage ,result)
    }
    
    func sendMessageCallBack(_ type : Int,_ map : [String:Any],_ timMessage : TIMMessage,  _ result: @escaping FlutterResult){
        
        var conversation = getTIMConversationByID(map: map);
        func succ(){
            // result(buildResponseMap(codeVal : 0, descVal : "sendMessage  ok"))
            print("sendMessageCallBack。             succ")
        }
        
        func fail (code : Int32?, desc : String?){
             result(buildResponseMap(codeVal : code! ,descVal : desc!))
            print("sendMessageCallBack。    fail   ")
        }
        
        conversation.send(timMessage, succ: succ, fail: fail)

        
    }
    
    
    func  login(call: FlutterMethodCall, result: @escaping FlutterResult){
        var map : [String: Any]=call.arguments as! [String : Any];
        
        var param = TIMLoginParam();
        param.identifier = map["userID"] as! String;
      
        param.userSig = GenerateTestUserSig.genTestUserSig(param.identifier)
        
        func succ(){
             result(buildResponseMap(codeVal : 0, descVal : "login  ok"))
            print("登陆。             succ")
        }
        
        func fail (code : Int32?, desc : String?){
             result(buildResponseMap(codeVal : code! ,descVal : desc!))
            print("登陆。    fail         \(code)  \(desc)  \(param.identifier)")
        }

        
       
        TIMManager.sharedInstance()?.login(param, succ: succ, fail: fail )
        
        

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

