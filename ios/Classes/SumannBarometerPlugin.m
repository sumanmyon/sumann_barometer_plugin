#import "SumannBarometerPlugin.h"
#if __has_include(<sumann_barometer_plugin/sumann_barometer_plugin-Swift.h>)
#import <sumann_barometer_plugin/sumann_barometer_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sumann_barometer_plugin-Swift.h"
#endif

@implementation SumannBarometerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSumannBarometerPlugin registerWithRegistrar:registrar];
}
@end
