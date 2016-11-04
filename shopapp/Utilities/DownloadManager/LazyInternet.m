//  Created by Dan Clarke on 18/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


#import "LazyInternet.h"

@implementation LazyInternet

- (void)startDownload:(NSString *)url withDelegate:(id)_delegate withUnique:(id)_unique{

    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
    intConnection = conn;
    delegate = _delegate;
    unique = _unique;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    activeDownload = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    activeDownload = nil;
    intConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    NSData *data = activeDownload;
    activeDownload = nil;
    intConnection = nil;
    [delegate lazyInternetDidLoad:data withUnique:unique];
}

@end

