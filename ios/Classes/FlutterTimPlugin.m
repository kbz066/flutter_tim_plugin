#import "FlutterTimPlugin.h"
#if __has_include(<flutter_tim_plugin/flutter_tim_plugin-Swift.h>)
#import <flutter_tim_plugin/flutter_tim_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_tim_plugin-Swift.h"
#endif

@implementation FlutterTimPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterTimPlugin registerWithRegistrar:registrar];
}
@end
