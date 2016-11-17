//  Created by Dan Clarke on 18/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>

@protocol LazyInternetDelegate;

@interface LazyInternet : NSObject <NSURLSessionDelegate> {

    NSURLConnection *intConnection;
    NSMutableData *activeDownload;
    id <LazyInternetDelegate> delegate;
    NSString *unique;

    long _statusCode;
}
- (void)startDownload:(NSString *)url withDelegate:(id)_delegate withUnique:(id)_unique;

@end

@protocol LazyInternetDelegate

- (void)lazyInternetDidLoad:(NSData*)data withUnique:(id)unique;

@end
