import Flutter
import UIKit


public class SwiftTimNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
        

    let channel = FlutterMethodChannel(name: "tim_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftTimNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    
    print("tim_plugin--------_>")

    //result("iOS " + UIDevice.current.systemVersion)
  }
}
