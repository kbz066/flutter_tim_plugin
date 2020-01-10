package com.flutter_tim_plugin;

import android.util.JsonWriter;


import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMElemType;
import com.tencent.imsdk.TIMFileElem;
import com.tencent.imsdk.TIMImage;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSoundElem;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMVideoElem;

import org.json.JSONObject;

import java.lang.reflect.Field;
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






    public String basicMessage2String(TIMMessage msg){
        Map map = buildBasicMap(msg);
        List elementList=new ArrayList();
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMElem element =  msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("type",element.getType().value());

            elementList.add(elementMap);

        }
        map.put("elementList",elementList);
        return new JSONObject(map).toString();
    }

    public String imageMessage2String(TIMMessage msg) {

        Map dataMap=buildBasicMap(msg);


        List elementList=new ArrayList();
        dataMap.put("messageType",TIMElemType.Image.value());
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
                imageListMap.put("type",element.getImageList().get(j).getType().value());
                imageListMap.put("uuid",element.getImageList().get(j).getUuid());
                imageListMap.put("width",element.getImageList().get(j).getWidth());

                imageList.add(imageListMap);
            }
            elementMap.put("imageList",imageList);


            elementList.add(elementMap);


        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }

    public String soundMessage2String(TIMMessage msg) {
        Map dataMap=buildBasicMap(msg);

        dataMap.put("messageType",TIMElemType.Sound.value());

        List elementList=new ArrayList();
        System.out.println( "发送消息成功  getElementCount  "+msg.getElementCount());
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMSoundElem element = (TIMSoundElem) msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("path",element.getPath());
            elementMap.put("duration",element.getDuration());
            elementMap.put("dataSize",element.getDataSize());
            elementMap.put("taskId",element.getTaskId());
            elementMap.put("uuid",element.getUuid());


            elementList.add(elementMap);

        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }


    public String fileMessage2String(TIMMessage msg){



        Map dataMap=buildBasicMap(msg);
        dataMap.put("messageType",TIMElemType.File.value());


        List elementList=new ArrayList();
        System.out.println( "收到文件消息成功  getElementCount  "+msg.getElementCount());
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMFileElem element = (TIMFileElem) msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("fileName",element.getFileName());
            elementMap.put("fileSize",element.getFileSize());
            elementMap.put("path",element.getPath());
            elementMap.put("taskId",element.getTaskId());
            elementMap.put("uuid",element.getUuid());


            System.out.println("打印   "+msg.getMessageLocator().toString());

            elementList.add(elementMap);

        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }

    public String videoMessage2String(TIMMessage msg) {
        Map dataMap=buildBasicMap(msg);

        dataMap.put("messageType",TIMElemType.Video.value());

        List elementList=new ArrayList();
        System.out.println( "消息视频  getElementCount  "+msg.getElementCount());
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMVideoElem element = (TIMVideoElem) msg.getElement(i);

            System.out.println(" 视频信息  "+element.getVideoPath());
            Map elementMap=new HashMap();
            elementMap.put("videoPath",element.getVideoPath());
            elementMap.put("snapshotPath",element.getSnapshotPath());

            elementMap.put("videoUUID",element.getVideoInfo().getUuid());
            elementMap.put("videoType",element.getVideoInfo().getType());
            elementMap.put("videoSize",element.getVideoInfo().getSize());
            elementMap.put("duaration",element.getVideoInfo().getDuaration());

            elementMap.put("snapshotUUID",element.getSnapshotInfo().getUuid());
            elementMap.put("snapshotType",element.getSnapshotInfo().getType());
            elementMap.put("snapshotHeight",element.getSnapshotInfo().getHeight());
            elementMap.put("snapshotWidth",element.getSnapshotInfo().getWidth());


            elementList.add(elementMap);

        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }

    private Map buildBasicMap(TIMMessage msg){
        Map dataMap=new HashMap();
        dataMap.put("msgId",msg.getMsgId());
        dataMap.put("msgSeq",msg.getSeq());
        dataMap.put("rand",msg.getRand());
        dataMap.put("time",msg.timestamp());
        dataMap.put("isSelf",msg.isSelf());
        dataMap.put("isPeerReaded",msg.isPeerReaded());
        dataMap.put("isRead",msg.isRead());
        dataMap.put("status",msg.status().getStatus());
        dataMap.put("sender",msg.getSender());
        return dataMap;
    }
    public String customMessage2String(TIMMessage msg) {
        Map dataMap=buildBasicMap(msg);

        dataMap.put("messageType",TIMElemType.Custom.value());

        List elementList=new ArrayList();
        System.out.println( "发送消息成功  getElementCount  "+msg.getElementCount());
        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMCustomElem element = (TIMCustomElem) msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("data",element.getData());
            elementList.add(elementMap);

        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }
    public String textMessage2String(TIMMessage msg) {
        Map dataMap=buildBasicMap(msg);

        dataMap.put("messageType",TIMElemType.Text.value());

        List elementList=new ArrayList();

        for (int i = 0; i < msg.getElementCount(); i++) {
            TIMTextElem element = (TIMTextElem) msg.getElement(i);
            Map elementMap=new HashMap();
            elementMap.put("text",element.getText());
            elementList.add(elementMap);

        }

        dataMap.put("elementList",elementList);

        System.out.println("打印  "+new JSONObject(dataMap).toString());

        return new JSONObject(dataMap).toString();
    }

    public List<String> message2List(List<TIMMessage> timList){
        List<String> list=new ArrayList<>();
        for (TIMMessage msg : timList) {

            TIMElem elem = msg.getElement(0);

            //获取当前元素的类型
            TIMElemType elemType = elem.getType();
            System.out.println( "elem type: " + elemType.name());
            if (elemType == TIMElemType.Text) {

                list.add(textMessage2String(msg));
                //处理文本消息
            } else if (elemType == TIMElemType.Image) {

                list.add(imageMessage2String(msg));
            }else if (elemType == TIMElemType.Sound) {

                list.add(soundMessage2String(msg));
            }else if (elemType == TIMElemType.File) {

                list.add(fileMessage2String(msg));
            }else if (elemType == TIMElemType.Video) {

                list.add(videoMessage2String(msg));
            }else if (elemType == TIMElemType.Custom) {

                list.add(customMessage2String(msg));
            }else {



                list.add(basicMessage2String(msg));
                System.out.println("message2List      elemType     "+elemType);
            }

        }


        return list;
    }



}