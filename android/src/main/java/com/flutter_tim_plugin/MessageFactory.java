package com.flutter_tim_plugin;

import android.util.JsonWriter;


import com.tencent.imsdk.TIMImage;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMMessage;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.JSONUtil;

public class MessageFactory {

    private MessageFactory() {
    }

    private static class SingletonInstance {
        private static final MessageFactory INSTANCE = new MessageFactory();
    }

    public static MessageFactory getInstance() {
        return SingletonInstance.INSTANCE;
    }


    public String imageElement2String(TIMMessage msg) {

        Map dataMap=new HashMap();
        dataMap.put("msgId",msg.getMsgId());
        dataMap.put("msgSeq",msg.getSeq());
        dataMap.put("rand",msg.getRand());
        dataMap.put("time",msg.timestamp());
        dataMap.put("isSelf",msg.isSelf());
        dataMap.put("status",msg.status().getStatus());
        dataMap.put("sender",msg.getSender());


        List elementList=new ArrayList();
        System.out.println( "发送消息成功  getElementCount  "+msg.getElementCount());
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMImageElem element = (TIMImageElem) msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("path",element.getPath());
            elementMap.put("imageFormat",element.getImageFormat());
            elementMap.put("level",element.getLevel());
            elementMap.put("taskId",element.getTaskId());


            ArrayList imageList = new ArrayList();
            for (int j = 0; j < element.getImageList().size(); j++) {
                Map imageListMap=new HashMap();
                imageListMap.put("url",element.getImageList().get(j).getUrl());
                imageListMap.put("height",element.getImageList().get(j).getHeight());
                imageListMap.put("size",element.getImageList().get(j).getSize());
                imageListMap.put("type",element.getImageList().get(j).getType());
                imageListMap.put("uuid",element.getImageList().get(j).getUuid());
                imageListMap.put("width",element.getImageList().get(j).getWidth());
                imageList.add(imageListMap);
            }
            elementMap.put("imageList",imageList);


            elementList.add(elementMap);

            // elementList.add();
        }

        dataMap.put("element",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }

}