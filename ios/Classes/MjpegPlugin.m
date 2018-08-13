#import "MjpegPlugin.h"
#import "LiveViewController.h"

@implementation MjpegPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    channel = [FlutterMethodChannel
               methodChannelWithName:@"mjpeg"
               binaryMessenger:[registrar messenger]];
    
    UIViewController *viewController = (UIViewController *)registrar.messenger;
    MjpegPlugin* instance = [[MjpegPlugin alloc] initWithViewController:viewController];
    
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"liveView" isEqualToString:call.method]) {
      
      NSString *url = call.arguments[@"url"];
            
      self.root = [UIApplication sharedApplication].keyWindow.rootViewController;
      self.vc = [[LiveViewController alloc] init];
      self.vc.url = url;
      self.nav = [[UINavigationController alloc] initWithRootViewController:self.vc];
      
      [self.root presentViewController:self.nav animated:true completion:nil];
      
      result(nil);

  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
