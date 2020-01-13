import Flutter
import UIKit


public class SwiftTimNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
        

    let channel = FlutterMethodChannel(name: "tim_plugin", binaryMessenger: registrar.messenger())
    
    
    let instance = SwiftTimNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    TimFlutterWrapper.sharedInstance.saveChannel(channel: channel);
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    TimFlutterWrapper.sharedInstance.onFlutterMethodCall(call: call, result: result)
      

    
    //result("iOS " + UIDevice.current.systemVersion)
  }
}
