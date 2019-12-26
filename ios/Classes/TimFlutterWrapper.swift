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
        }
     
    }
    func  login(call: FlutterMethodCall, result: @escaping FlutterResult){
        var map : [String: Any]=call.arguments as! [String : Any];
        
        var param = TIMLoginParam();
        param.identifier = map["userID"] as! String;
      
        param.userSig = GenerateTestUserSig.genTestUserSig(param.identifier)
        
        func succ(){
            print("登陆。             succ")
        }
        
        func fail (code : Int32?, desc : String?){
            print("登陆。    fail         \(code)  \(desc)  \(param.identifier)")
        }

        
       
        TIMManager.sharedInstance()?.login(param, succ: succ, fail: fail )
        
        

    }
    ///初始化
    func  initTim(call: FlutterMethodCall, result: @escaping FlutterResult){
        print( type(of: call.arguments))
        
        var config = TIMSdkConfig();
        config.sdkAppId = 1400294549
        
        
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

}

