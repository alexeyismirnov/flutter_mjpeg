//
//  LiveViewController.m
//  mjpeg
//
//  Created by Alexey Smirnov on 8/13/18.
//

#import "LiveViewController.h"

@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Close"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(closeView:)];
    
    self.navigationItem.leftBarButtonItem = flipButton;
    
    CGRect rc = self.view.bounds;
    
    self.imageView = [[UIImageView alloc]initWithFrame:rc];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:self.imageView];
    
    _responseData = [[NSMutableData alloc] init];
    
    NSURLRequest *theRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
}

-(void) closeView:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    UIImage *recievedImage = [UIImage imageWithData:_responseData];
    self.imageView.image = recievedImage;
    
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
