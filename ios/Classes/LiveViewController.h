//
//  LiveViewController.h
//  mjpeg
//
//  Created by Alexey Smirnov on 8/13/18.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController<NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}
@property (nonatomic) NSString *url;
@property (retain, nonatomic) UIImageView *imageView;

@end
