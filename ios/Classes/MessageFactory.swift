//
//  MessageFactory.swift
//  flutter_tim_plugin
//
//  Created by kbz on 2019/12/29.
//

class MessageFactory{
    
    func  buildBasicMap( msg : TIMMessage) -> [String:Any]{
        var dataMap =  [String:Any]();
        dataMap["msgId"] = msg.msgId();
        dataMap["msgSeq"] = msg.getSeq();
        dataMap["rand"] = msg.getRand();
        dataMap["time"] = msg.timestamp();
        dataMap["isSelf"] = msg.isSelf();
        dataMap["isPeerReaded"] = msg.isPeerReaded;
        dataMap["isRead"] = msg.isRead());
        dataMap["status"] = msg.status().getStatus);
        dataMap["sender"] = msg.getSender);
        return dataMap;
    }
}
