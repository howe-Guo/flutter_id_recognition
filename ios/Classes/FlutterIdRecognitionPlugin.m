#import "FlutterIdRecognitionPlugin.h"

@interface FlutterIdRecognitionPlugin()
// 身份证信息
@property (nonatomic,strong) IDInfo *IDInfo;
@property (nonatomic,strong) FlutterViewController* controller;
@property (nonatomic, strong) FlutterMethodChannel* methodChannel;
@property (nonatomic, strong) FlutterResult result;
@end


@implementation FlutterIdRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
      self.controller = (FlutterViewController*)self.window.rootViewController;
      self.methodChannel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_id_recognition"
            binaryMessenger:[registrar messenger]];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmIdInfoSuccess:) name:@"confirmidinfosuccess" object:nil];
  FlutterIdRecognitionPlugin* instance = [[FlutterIdRecognitionPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  if ([@"getIDNum" isEqualToString:call.method]) {
      [self getIDRecognition:self.controller];
      self.result = result;
    //result(FlutterMethodNotImplemented);
  }
}

- (void)getIDRecognition:(FlutterViewController *)controller {
    IDCardCaptureViewController *idcardVC = [[IDCardCaptureViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:idcardVC];
    nav.modalPresentationStyle =  UIModalPresentationFullScreen;
    [controller presentViewController:nav animated:YES completion:^{

    }];
    NSLog(@"sadadadadada");
}

- (void)confirmIdInfoSuccess:(NSNotification *)notification{
//    NSLog(@"%@", notification.object[@"idinfo"].num);
    if(notification.object != nil){
        if(self.IDInfo == nil){
            self.IDInfo = [[IDInfo alloc] init];
        }
        self.IDInfo = notification.object[@"idinfo"];
//        NSLog(self.IDInfo.num);

        // iOS 中其他页面向Flutter 中发送消息通过这里
        // 本页中 可以直接使用   [messageChannel sendMessage:dic];
        //处理消息
        NSLog(@"notificationFuncion ");
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        @property (nonatomic,copy) NSString *name; //姓名
//        @property (nonatomic,copy) NSString *num; //身份证号
//        @property (nonatomic,copy) NSString *gender; //性别
//        @property (nonatomic,copy) NSString *nation; //民族
//        @property (nonatomic,copy) NSString *address; //地址
        if (self.methodChannel != nil) {
            [dic setObject: self.IDInfo.name forKey:@"name"];
            [dic setObject:self.IDInfo.num forKey:@"idNum"];
//             [dic setObject:self.IDInfo.gender forKey:@"gender"];
//             [dic setObject: self.IDInfo.nation forKey:@"nation"];
//             [dic setObject:self.IDInfo.address forKey:@"address"];
//            [self.methodChannel invokeMethod:@"getIDRecognition" arguments:dic];
            self.result(dic);
        }
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
