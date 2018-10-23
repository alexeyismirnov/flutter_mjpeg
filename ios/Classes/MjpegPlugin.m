#import "MjpegPlugin.h"
#import "LiveViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface MjpegPlugin ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

static const int SOURCE_CAMERA = 0;
static const int SOURCE_GALLERY = 1;

@implementation MjpegPlugin {
    UIImagePickerController *_imagePickerController;
    FlutterResult _result;
    NSDictionary *_arguments;
}

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
      
  } else if ([@"pickVideo" isEqualToString:call.method]) {
      self.viewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
      
      _imagePickerController = [[UIImagePickerController alloc] init];
      
      _imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
      _imagePickerController.delegate = self;
      _imagePickerController.mediaTypes = @[
                                            (NSString *)kUTTypeMovie, (NSString *)kUTTypeAVIMovie, (NSString *)kUTTypeVideo,
                                            (NSString *)kUTTypeMPEG4
                                            ];
      _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
      
      _result = result;
      _arguments = call.arguments;
      
      int imageSource = [[_arguments objectForKey:@"source"] intValue];
      
      switch (imageSource) {
          case SOURCE_CAMERA:
          [self showCamera];
          break;
          case SOURCE_GALLERY:
          [self showPhotoLibrary];
          break;
          default:
          result([FlutterError errorWithCode:@"invalid_source"
                                     message:@"Invalid video source."
                                     details:nil]);
          break;
      }
      
  } else {
    result(FlutterMethodNotImplemented);
  }
}
    
- (void)showCamera {
        // Camera is not available on simulators
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.viewController presentViewController:_imagePickerController animated:YES completion:nil];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Camera not available."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
    
- (void)showPhotoLibrary {
    NSLog(@"qq2");
    
    // No need to check if SourceType is available. It always is.
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.viewController presentViewController:_imagePickerController animated:YES completion:nil];
}
    
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    if (videoURL != nil) {
        NSData *data = [NSData dataWithContentsOfURL:videoURL];
        NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
        NSString *tmpFile = [NSString stringWithFormat:@"image_picker_%@.MOV", guid];
        NSString *tmpDirectory = NSTemporaryDirectory();
        NSString *tmpPath = [tmpDirectory stringByAppendingPathComponent:tmpFile];
        
        if ([[NSFileManager defaultManager] createFileAtPath:tmpPath contents:data attributes:nil]) {
            _result(tmpPath);
        } else {
            _result([FlutterError errorWithCode:@"create_error"
                                        message:@"Temporary file could not be created"
                                        details:nil]);
        }
    } else {
        
    }
    
    _result = nil;
    _arguments = nil;
}
    
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
    _result(nil);
    
    _result = nil;
    _arguments = nil;
}

@end
