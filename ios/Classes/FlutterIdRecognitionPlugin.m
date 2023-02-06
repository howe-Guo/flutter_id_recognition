#import "FlutterIdRecognitionPlugin.h"

@implementation FlutterIdRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
      FlutterMethodChannel* methodChannel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_id_recognition"
            binaryMessenger:[registrar messenger]];
  FlutterIdRecognitionPlugin* instance = [[FlutterIdRecognitionPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else{
    result(FlutterMethodNotImplemented);
  }
}

@end
