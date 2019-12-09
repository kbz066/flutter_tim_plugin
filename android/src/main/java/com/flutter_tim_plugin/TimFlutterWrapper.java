package com.flutter_tim_plugin;



import android.content.Context;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMImage;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMImageType;
import com.tencent.imsdk.TIMLogLevel;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.session.SessionWrapper;

import org.json.JSONObject;
import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TimFlutterWrapper {


    private static Context mContext = null;
    private static MethodChannel mChannel = null;
    private Handler mMainHandler = null;
    private TimFlutterWrapper() {
        mMainHandler=new Handler(Looper.getMainLooper());
    }

    private static class SingletonInstance {
        private static final TimFlutterWrapper INSTANCE = new TimFlutterWrapper();
    }

    public static TimFlutterWrapper getInstance() {
        return SingletonInstance.INSTANCE;
    }


    public void onFlutterMethodCall(MethodCall call, MethodChannel.Result result) {


        System.out.println("method -_------------------->  "+call.method);
        if (TimMethodList.MethodKeyInit.equalsIgnoreCase(call.method)){
            initIM();

        }else if (TimMethodList.MethodKeyLogin.equalsIgnoreCase(call.method)){
            login(call,result);
        }else if (TimMethodList.MethodKeyGetConversationList.equalsIgnoreCase(call.method)){
            getConversationList(call,result);
        }else if (TimMethodList.MethodKeySendMessage.equalsIgnoreCase(call.method)){
            sendMessage(call,result);
        }

    }

    private void sendMessage(MethodCall call, MethodChannel.Result result) {

        System.out.println("sendMessage      "+call.arguments);

        if (call.arguments instanceof Map){
            Map<String,Object> map= (Map<String, Object>) call.arguments;

            int type= (int) map.get("messageType");


            switch (type){
                case MessageTypeEnum.Text:
                    sendTextMessage(map,result);
                    break;
                case MessageTypeEnum.Image:
                    sendImageMessage(map,result);
                    break;
            }


        }
    }

    private void sendImageMessage(Map<String, Object> map, final MethodChannel.Result result) {

        System.out.println("sendImageMessage   userID   "+ map.get("id").toString()+"\n   "+map.get("path").toString());

        //构造一条消息
        TIMMessage msg = new TIMMessage();

        //添加图片
        final TIMImageElem elem = new TIMImageElem();
        elem.setPath(map.get("path").toString());

        //将 elem 添加到消息
        if(msg.addElement(elem) != 0) {

            return;
        }



        //发送消息

        sendMessageCallBack(MessageTypeEnum.Image,map,msg,result);

    }

    private void sendTextMessage(Map<String, Object> map, final MethodChannel.Result result) {

        TIMMessage timMessage=new TIMMessage();
        TIMTextElem elem=new TIMTextElem();
        elem.setText(map.get("text").toString());
        //将elem添加到消息
        if(timMessage.addElement(elem) != 0) {
            System.out.println( "addElement failed");
            return;
        }
        //发送消息
        sendMessageCallBack(MessageTypeEnum.Text,map,timMessage,result);



    }


    /**
     * 发送消息完成后的回调
     * @param type
     * @param map
     * @param timMessage
     * @param result
     */
    private void  sendMessageCallBack(final int type, final Map map, TIMMessage timMessage, final MethodChannel.Result result){

        System.out.println("conversationType  是  "+(TIMConversationType.values()[(int) map.get("conversationType")]));
        TIMConversation conversation = TIMManager.getInstance().getConversation(
                TIMConversationType.values()[(int) map.get("conversationType")],    //会话类型：单聊
                map.get("id").toString());
        conversation.sendMessage(timMessage, new TIMValueCallBack<TIMMessage>() {//发送消息回调
            @Override
            public void onError(int code, String desc) {//发送消息失败
                //错误码 code 和错误描述 desc，可用于定位请求失败原因
                //错误码 code 含义请参见错误码表
                result.success(buildResponseMap(String.valueOf(code),desc));
                System.out.println( "send message failed. code: " + code + " errmsg: " + desc);
            }

            @Override
            public void onSuccess(TIMMessage msg) {//发送消息成功


                switch (type){
                    case MessageTypeEnum.Text:
                        result.success(buildResponseMap(String.valueOf(0),"SendMsg ok"));
                        break;
                    case MessageTypeEnum.Image:
                        Map dataMap=new HashMap();
                        dataMap.put("msgId",msg.getMsgId());
                        dataMap.put("msgSeq",msg.getSeq());
                        dataMap.put("rand",msg.getRand());
                        dataMap.put("time",msg.timestamp());
                        dataMap.put("isSelf",msg.isSelf());
                        dataMap.put("status",msg.status().getStatus());
                        dataMap.put("sender",msg.getSender());


                        result.success(buildResponseMap(String.valueOf(0),    MessageFactory.getInstance().imageElement2String(msg)));
                        break;
                }


            }
        });
    }


    private void getConversationList(MethodCall call, MethodChannel.Result result) {
        //获取单聊会话
        String peer = "sample_user_1";  //获取与用户 "sample_user_1" 的会话
        TIMConversation conversation = TIMManager.getInstance().getConversation(
                TIMConversationType.C2C,    //会话类型：单聊
                peer);


    }

    private void login(MethodCall call, final MethodChannel.Result result) {

        final Map<String,Object> map= (Map<String, Object>) call.arguments;


        String userID = map.get("userID").toString();
        // 获取userSig函数
        String userSig = GenerateTestUserSig.genTestUserSig(userID);

        // identifier 为用户名，userSig 为用户登录凭证
        TIMManager.getInstance().login(userID, userSig, new TIMCallBack() {
            @Override
            public void onError(int code, String desc) {
                //错误码 code 和错误描述 desc，可用于定位请求失败原因
                //错误码 code 列表请参见错误码表

                result.success(buildResponseMap(String.valueOf(code),desc));
                System.out.println("login failed. code: " );
            }

            @Override
            public void onSuccess() {

                System.out.println("登录成功----------------》"+Thread.currentThread().getName());

                result.success(buildResponseMap("0","login Success"));

            }
        });
    }


    private Map<String,Object> buildResponseMap(String codeVal,Object descVal){
        Map<String,Object> successMap=new HashMap<>();
        successMap.put("code",codeVal);
        successMap.put("data",descVal);
        return successMap;
    }

    /**
     * 初始化
     */
    private void initIM() {

        //初始化 IM SDK 基本配置
//判断是否是在主线程
        if (SessionWrapper.isMainProcess(mContext)) {
            TIMSdkConfig config = new TIMSdkConfig(GenerateTestUserSig.SDKAPPID)
                    .enableLogPrint(false)
                    .setLogLevel(TIMLogLevel.DEBUG);


            //初始化 SDK
            boolean init = TIMManager.getInstance().init(mContext, config);

            mChannel.invokeMethod(TimMethodList.MethodCallBackKeyInit,init);

            System.out.println("打印      "+init);
        }
    }

    public void saveContext(Context context) {
        mContext = context;
    }
    public void saveChannel(MethodChannel channel) {
        mChannel = channel;
    }
}