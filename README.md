# flutter dim

基于腾讯云im 封装的一个 flutter im库.所有消息类型都封装了对应的实体类,可以很方便的调用省去自己解析消息。 实体类的属性名完全按照官方文档定义 有不清楚的查看官方文档即可.
## 联系方式
## qq群： 290611780

## 前期准备
[腾讯im官网](https://cloud.tencent.com/document/product/269/36838) 申请开发者账号
并创建应用

通过管理后台 获取到密匙和SDKAppID


# 依赖 IM Flutter plugin

在项目的 `pubspec.yaml` 中写如下依赖

```
dependencies:
  flutter:
    sdk: flutter

   flutter_tim_plugin: ^0.0.1
```

然后在项目路径执行 `flutter packages get` 来下载 Flutter Plugin

# 集成步骤


## 1.初始化 SDK

```
TimFlutterPlugin.init(RongAppKey);

```

## 2.获取密匙sig 

```
官方推荐密匙通过服务器获取防止泄露.

本地可以通过TimFlutterPlugin.getUserSig函数获取封装好的密匙
```
## 3. 登录im
```
 TimFlutterPlugin.login("userid", "密匙sig")

```


# API 调用



## 发送消息

发送文本消息

```
 Message msg=await TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: TextMessage.obtain("要发送的文本消息"));

  }
```
发送图片消息

```
TimFlutterPlugin.sendMessage( id: 2255,conversationType: TIMConversationType.C2C,content: ImageMessage.obtain(path))

```

发送音视频 、自定义等消息消息

```
CustomMessage、VideoMessage、SoundMessage
```
获取漫游和本地消息

```
 TimFlutterPlugin.getLocalMessage(conversationType: TIMConversationType.C2C, id: 2255, count: 5);
 获取漫游使用getMessage
```
音视频 图片 文件 下载

```
downloadFile、downloadVideo
```

## 已有的功能

1. 初始化
2. 登录
3. 登出
4. 获取会话列表
5. 删除一个会话
6. 获取漫游和本地消息
7. 发送图片消息
8. 发送文本消息
9. 发送地理位置消息
10. 发送音频消息
11. 发送视频消息
12. 发送小文件消息
13. 发送自定义消息
14. 设置消息已读上报
15. 回撤消息
16. 创建群组
17. 邀请入群
18. 申请入群
19. 获取用户资料
20. 设置用户资料
21. 监听新消息回调
22. 监听用户状态回调
    
    
  ## 有需要新的api需求或者bug 可到群里联系我 有时间 我会添加和修复
