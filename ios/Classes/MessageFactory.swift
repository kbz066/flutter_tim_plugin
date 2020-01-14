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

        dataMap["msgSeq"] = msg.locator()?.seq;
        dataMap["rand"] = msg.locator()?.rand;
        dataMap["time"] = Int(msg.timestamp()!.timeIntervalSince1970);
        dataMap["isSelf"] = msg.isSelf();
        dataMap["isPeerReaded"] = msg.isPeerReaded();
        dataMap["isRead"] = msg.isReaded();
        dataMap["status"] = msg.status().rawValue;
        dataMap["sender"] = msg.sender();
       
        return dataMap;
    }
    
    
    static func customMessage2String(_ msg : TIMMessage)-> String{
        
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
    
    static func fileMessage2String(_ msg : TIMMessage)-> String{
         var map = buildBasicMap(msg);
         
         map["messageType"] = MessageType.Custom;
         
         var elementList = Array<[String:Any]>();
               
         var count = msg.elemCount();
         for index in 0..<count{
             var element  =  msg.getElem(index) as! TIMFileElem;
             
        
            var elementMap = [String:Any]();
            elementMap["fileName"] = element.filename;
            elementMap["fileSize"] = element.fileSize;
            elementMap["path"] = element.path;
            elementMap["taskId"] = element.taskId;
            elementMap["uuid"] = element.uuid;
            
             elementList.append(elementMap);
             
         }
         map["elementList"] = elementList;
         return convertDictionaryToJSONString(dict: map)
    }
    
    static func videoMessage2String(_ msg : TIMMessage)-> String{
         var map = buildBasicMap(msg);
         
         map["messageType"] = MessageType.Sound;
         
         var elementList = Array<[String:Any]>();
               
         var count = msg.elemCount();
         for index in 0..<count{
             var element  =  msg.getElem(index) as! TIMVideoElem;
             
        
            var elementMap = [String:Any]();
            elementMap["videoPath"] = element.videoPath;
            elementMap["snapshotPath"] = element.snapshotPath;
            elementMap["videoUUID"] = element.video.uuid;
            elementMap["videoType"] = element.video.type;
            elementMap["videoSize"] = element.video.size;
            elementMap["duaration"] = element.video.duration;
            
            elementMap["snapshotUUID"] = element.snapshot.uuid;
            elementMap["snapshotType"] = element.snapshot.type;
            elementMap["snapshotHeight"] = element.snapshot.height;
            elementMap["snapshotWidth"] = element.snapshot.width;
            


            elementList.append(elementMap);
             
         }
         map["elementList"] = elementList;
         return convertDictionaryToJSONString(dict: map)
    }
    
    static func soundMessage2String(_ msg : TIMMessage)-> String{

         var map = buildBasicMap(msg);
         
         map["messageType"] = MessageType.Sound;
         
         var elementList = Array<[String:Any]>();
               
         var count = msg.elemCount();
         for index in 0..<count{
             var element  =  msg.getElem(index) as! TIMSoundElem;
             
        
             var elementMap = [String:Any]();
            elementMap["path"] = element.path;
            elementMap["duration"] = element.second;
            elementMap["dataSize"] = element.dataSize;
            elementMap["taskId"] = element.taskId;
            elementMap["uuid"] = element.uuid;
            
            
        
            elementList.append(elementMap);
             
         }
         map["elementList"] = elementList;
         return convertDictionaryToJSONString(dict: map)
    }
    
    static func imageMessage2String(_ msg : TIMMessage)-> String{
     
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
    
    static func textMessage2String(_ msg : TIMMessage)-> String{
        var map = buildBasicMap(msg);
          
          map["messageType"] = MessageType.Text;
          
          var elementList = Array<[String:Any]>();
                var count = msg.elemCount();
                for index in 0..<count{
                    var element  =  msg.getElem(index) as! TIMTextElem;
                         
                    
                    var elementMap = [String:Any]();
    
                    elementMap["text"] = element.text;
                    elementList.append(elementMap);
                         
                     }
        map["text"] = elementList;
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
    static func message2List(timList : Array<TIMMessage>)-> Array<String>{
        var list = Array<String>();
        
    
        for msg in timList {
            let elmCount = msg.elemCount();

            let elemType = getElemType(msg.getElem(0));
            
     
            if (elemType == MessageType.Text) {
   
                list.append(textMessage2String(msg))
              }else if (elemType == MessageType.Image) {

                list.append(imageMessage2String(msg));
              }else if (elemType == MessageType.Sound) {

                  list.append(soundMessage2String(msg));
              }else if (elemType == MessageType.File) {

                  list.append(fileMessage2String(msg));
              }else if (elemType == MessageType.Video) {

                  list.append(videoMessage2String(msg));
              }else if (elemType == MessageType.Custom) {

                  list.append(customMessage2String(msg));
              }else {



                  list.append(basicMessage2String(msg));
                  
              }
            
            

    
            
        }

        return list;
        
    }
    
    
    static func getElemType(_ elem : TIMElem)-> Int{
        if(elem is TIMTextElem){
            return MessageType.Text
        }else if(elem is TIMFaceElem){
            return MessageType.Face
        }else if(elem is TIMLocationElem){
            return MessageType.Location
        }else if(elem is TIMVideoElem){
            return MessageType.Video
        }else if(elem is TIMSoundElem){
            return MessageType.Sound
        }else if(elem is TIMFileElem){
            return MessageType.File
        }else if(elem is TIMCustomElem){
            return MessageType.Custom
        }else if(elem is TIMImageElem){
            return MessageType.Image
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
