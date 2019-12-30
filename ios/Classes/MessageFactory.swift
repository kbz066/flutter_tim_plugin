//
//  MessageFactory.swift
//  flutter_tim_plugin
//
//  Created by kbz on 2019/12/29.
//

class MessageFactory{
    
    static func  buildBasicMap(_ msg : TIMMessage) -> [String:Any]{
        var dataMap =  [String:Any]();
        dataMap["msgId"] = msg.msgId();
        dataMap["time"] = Int(msg.timestamp()!.timeIntervalSince1970);
        dataMap["isSelf"] = msg.isSelf();
        dataMap["isPeerReaded"] = msg.isPeerReaded();
        dataMap["isRead"] = msg.isReaded();
        dataMap["status"] = msg.status().rawValue;
        dataMap["sender"] = msg.sender();
       
        return dataMap;
    }
    
    static func  basicMessage2String(_ msg : TIMMessage)-> String{
        var map = buildBasicMap(msg);
        var elementList = Array<[String:Any]>();
        
        var count = msg.elemCount();

  
        for index in 0..<count{
            var element : TIMElem =  msg.getElem(index)
            var elementMap = ["type":getElemType(element)]
            
            elementList.append(elementMap);
        }
        

        map["elementList"] = elementList;

        return convertDictionaryToJSONString(dict: map)


    }
    static func getElemType(_ elem : TIMElem)-> Int{
        if(elem is TIMTextElem){
            return MessageType.Text
        }else{
            return 0
        }
    }
    static func convertDictionaryToJSONString(dict : Dictionary<String,Any>)->String {
        let data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let jsonStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return jsonStr! as String
    }


}
