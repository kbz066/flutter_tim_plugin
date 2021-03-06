import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim_plugin/message/conversation.dart';
import 'package:flutter_tim_plugin/message/message.dart';
import 'package:flutter_tim_plugin/tim_method_key.dart';
import 'message/message_content.dart';
import 'message/message_factory.dart';

class TimFlutterPlugin {
  ///新消息
  static Function(List<Message>) onNewMessageWrapper;

  ///用户状态回调
  static Function(int userState) onUserStatusListener;

  static Function(Message msg, int left) onMessageReceived;

  static final MethodChannel _channel = const MethodChannel('tim_plugin');

  ///初始化 SDK
  ///
  ///[appkey] appkey
  static Future<Map> init(int sdkAppid) async {
    var res = await _channel.invokeMethod(TimMethodKey.Init, sdkAppid);
    _addNativeMethodCallHandler();

    return res;
  }

  /// 腾讯云 SDKAppId，需要替换为您自己账号下的 SDKAppId。
  /// userId 用户id
  /// time  签名过期时间，建议不要设置的过短
  /// key  计算签名用的加密密钥
  static Future<String> getUserSig(
      int appid, String userId, int time, String key) async {
    Map arguments = {
      "appid": appid,
      "time": time,
      "key": key,
      "userId": userId
    };
    return await _channel.invokeMethod(TimMethodKey.GetUserSig, arguments);
  }

  ///登录
  static Future<Map> login(String userID, String userSig) async {
    Map arguments = {"userID": userID, "userSig": userSig};

    return await _channel.invokeMethod(TimMethodKey.Login, arguments);
  }

  ///登出
  static Future<Map> logout() async {
    return await _channel.invokeMethod(TimMethodKey.Logout);
  }

  ///发送消息
  static Future<Message> sendMessage(
      {@required int id,
      @required int conversationType,
      @required MessageContent content}) async {
    Map map = {
      "id": id,
      "conversationType": conversationType,
      "content": content.encode(),
      "messageType": content.getMessageType()
    };

    Map resultMap = await _channel.invokeMethod(TimMethodKey.SendMessage, map);

    if (resultMap == null) {
      return null;
    }

    Message msg = MessageFactory.instance
        .map2SendMessage(resultMap, content.getMessageType());
    return msg;
  }

  /// 下载文件
  static Future<Map> downloadFile(
      {@required int conversationType,
      @required String path,
      @required int rand,
      @required bool isSelf,
      @required int time,
      @required int id,
      @required int msgSeq}) async {
    Map map = {
      "conversationType": conversationType,
      "rand": rand,
      "self": isSelf,
      "seq": msgSeq,
      "timestamp": time,
      "id": id,
      "path": path
    };
    return await _channel.invokeMethod(TimMethodKey.DownloadFile, map);
  }

  /// 下载视频消息
  static Future<Map> downloadVideo(
      {@required int conversationType,
      @required String snapshotPath,
      @required String videoPath,
      @required int rand,
      @required bool isSelf,
      @required int time,
      @required int id,
      @required int msgSeq}) async {
    Map map = {
      "conversationType": conversationType,
      "rand": rand,
      "self": isSelf,
      "seq": msgSeq,
      "timestamp": time,
      "id": id,
      "videoPath": videoPath,
      "snapshotPath": snapshotPath
    };
    return await _channel.invokeMethod(TimMethodKey.DownloadVideo, map);
  }

  ///获取漫游消息
  static Future<List<Message>> getMessage(
      {@required int conversationType,
      @required int id,
      @required int count}) async {
    Map map = {"conversationType": conversationType, "count": count, "id": id};
    var resultMap = await _channel.invokeMethod(TimMethodKey.GetMessage, map);
    print('resultMap-------getMessage---------->   ${resultMap} ');
    return MessageFactory.instance.string2ListMessage(resultMap["data"]);
  }

  ///获取本地消息
  static Future<List<Message>> getLocalMessage(
      {@required int conversationType,
      @required int id,
      @required int count}) async {
    Map map = {"conversationType": conversationType, "count": count, "id": id};

    var resultMap =
        await _channel.invokeMethod(TimMethodKey.GetLocalMessage, map);

    print('resultMap-------getLocalMessage---------->    $resultMap');

    return MessageFactory.instance.string2ListMessage(resultMap["data"]);
  }

  ///删除会话
  static Future<Map> deleteConversation(
      {@required int conversationType,
      @required int id,
      bool delLocalMsg = false}) async {
    Map map = {
      "conversationType": conversationType,
      "delLocalMsg": delLocalMsg,
      "id": id
    };
    return await _channel.invokeMethod(TimMethodKey.DeleteConversation, map);
  }

  ///创建群组
  static Future<Map> createGroup(
      {@required String type, @required String name}) async {
    Map map = {
      "type": type,
      "name": name,
    };
    return await _channel.invokeMethod(TimMethodKey.CreateGroup, map);
  }

  ///邀请用户入群
  static Future inviteGroupMember(
      {@required String groupId, @required List<String> memList}) async {
    Map map = {
      "groupId": groupId,
      "memList": memList,
    };
    return await _channel.invokeMethod(TimMethodKey.InviteGroupMember, map);
  }

  ///申请入群
  static Future applyJoinGroup(
      {@required String groupId, String reason}) async {
    Map map = {
      "groupId": groupId,
      "reason": reason,
    };
    return await _channel.invokeMethod(TimMethodKey.ApplyJoinGroup, map);
  }

  ///设置消息已读上报
  static Future setReadMessage(
      {@required int conversationType, @required int id}) async {
    Map map = {"conversationType": conversationType, "id": id};
    return await _channel.invokeMethod(TimMethodKey.SetReadMessage, map);
  }

  /// 回撤消息
  static Future revokeMessage(
      {@required int conversationType,
      @required int rand,
      @required bool isSelf,
      @required int time,
      @required int id,
      @required int msgSeq}) async {
    Map map = {
      "conversationType": conversationType,
      "rand": rand,
      "self": isSelf,
      "seq": msgSeq,
      "timestamp": time,
      "id": id,
    };
    return await _channel.invokeMethod(TimMethodKey.RevokeMessage, map);
  }

  static Future<List<Conversation>> getConversationList() async {
    var res = await _channel.invokeMethod(TimMethodKey.GetConversationList);
    return MessageFactory.instance.map2ConversationList(res["data"]);
  }

  static Future<Map> getSelfProfile() async {
    return await _channel.invokeMethod(TimMethodKey.GetSelfProfile);
  }

  static Future<Map> modifySelfProfile(Map map) async {
    return await _channel.invokeMethod(TimMethodKey.ModifySelfProfile, map);
  }

  ///响应原生的事件
  ///

  static void _addNativeMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case TimMethodKey.MethodCallBackKeyNewMessages:
          if (onNewMessageWrapper != null) {
            onNewMessageWrapper(
                MessageFactory.instance.string2ListMessage(call.arguments));
          }

          break;
        case TimMethodKey.MethodCallBackKeyUserStatus:
          if (onUserStatusListener != null) {
            onUserStatusListener(call.arguments);
          }

          break;
      }
      return;
    });
  }
}
