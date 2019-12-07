package com.flutter_tim_plugin;



import android.content.Context;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;

import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMLogLevel;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.session.SessionWrapper;

import java.util.HashMap;
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
        if (call.arguments instanceof Map){
            Map<String,Object> map= (Map<String, Object>) call.arguments;

            String type=map.get("type").toString();


            System.out.println("发送消息   "+  MessageTypeEnum.TEXT.name());
        }
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
                Map<String,String> errorMap=new HashMap<>();
                errorMap.put("code",String.valueOf(code));
                errorMap.put("desc",desc);
                result.success(errorMap);
                System.out.println("login failed. code: " + errorMap);
            }

            @Override
            public void onSuccess() {

                System.out.println("登录成功----------------》"+Thread.currentThread().getName());
                Map<String,String> successMap=new HashMap<>();
                successMap.put("code","0");
                successMap.put("desc","login Success");
                result.success(successMap);

            }
        });
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