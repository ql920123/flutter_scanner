#import "ScannerPlugin.h"
#import "ScannerView.h"
#import "ScannerFactory.h"
@implementation ScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"scanner"
            binaryMessenger:[registrar messenger]];
  ScannerPlugin* instance = [[ScannerPlugin alloc] init];
  ScannerFactory* factory = [[ScannerFactory alloc] initWithRegistrar:registrar];
  [registrar registerViewFactory:factory withId:@"scanner"];
//  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
