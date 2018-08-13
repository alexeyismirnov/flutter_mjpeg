#import <Flutter/Flutter.h>

@class LiveViewController;

static FlutterMethodChannel *channel;

@interface MjpegPlugin : NSObject<FlutterPlugin>
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) UIViewController *root;
@property (nonatomic, retain) LiveViewController *vc;
@property (nonatomic, retain) UINavigationController *nav;

@end
