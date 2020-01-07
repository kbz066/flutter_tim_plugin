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
    
    
    static func customMessage2String(_ msg : TIMMessage)-> String{
        
        print("customMessage2String===============")
        var map = buildBasicMap(msg);
        
        map["messageType"] = MessageType.Custom;
        
        var elementList = Array<[String:Any]>();
              
        var count = msg.elemCount();
        for index in 0..<count{
            var element  =  msg.getElem(index) as! TIMCustomElem;
            
       
            var elementMap = ["data":Array(element.data)]
            elementList.append(elementMap);
            
        }
        map["elementList"] = elementList;
        return convertDictionaryToJSONString(dict: map)
    }
    
    static func imageMessage2String(_ msg : TIMMessage)-> String{
        print("customMessage2String===============")
            var map = buildBasicMap(msg);
            
            map["messageType"] = MessageType.Image;
            
            var elementList = Array<[String:Any]>();
                  
            var count = msg.elemCount();
            for index in 0..<count{
                var element  =  msg.getElem(index) as! TIMImageElem;
                
           
                var elementMap = [String:Any]();
                elementMap["path"] = element.path;
                elementMap["imageFormat"] = element.format.rawValue;
                elementMap["level"] = element.level.rawValue;
                elementMap["taskId"] = element.taskId;
        
                
                var images = Array<Any>();
                
                var timImageList = element.imageList as! Array<TIMImage>;
                for image in timImageList {
                    var imageListMap = [String:Any]();
                    
                    imageListMap["url"] = image.url;
                    imageListMap["height"] = image.height;
                    imageListMap["size"] = image.size;
                    imageListMap["type"] = image.type.rawValue;
                    imageListMap["uuid"] = image.uuid;
                    imageListMap["width"] = image.width;
                    
                    images.append(imageListMap);
                }
                
        
                elementMap["imageList"] = images;
                elementList.append(elementMap);
                
            }
            map["elementList"] = elementList;
            return convertDictionaryToJSONString(dict: map)
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
        }else if(elem is TIMFaceElem){
            return MessageType.Face
        }else if(elem is TIMLocationElem){
            return MessageType.Location
        }else{
            return -99
        }
    }
    static func convertDictionaryToJSONString(dict : Dictionary<String,Any>)->String {
        let data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let jsonStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return jsonStr! as String
    }


}
