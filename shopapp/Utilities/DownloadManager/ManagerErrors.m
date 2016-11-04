//
//  ManagerErrors.m
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import "ManagerErrors.h"

@implementation ManagerErrors
+ (ManagerErrors *)sharedInstance{
    static ManagerErrors *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[ManagerErrors alloc] init];
        }
    });
    return sharedInstance;
}

// Show the error message
- (void)alertErrMsgWith:(NSString *)msg {
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        if (!alert.visible) {
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    });
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

- (void)alertErrWithTitle: (NSString *)title MsgWith:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!alert.visible) {
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title, nil) message:msg delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            [alert show];
        }
    });
}

- (BOOL)errorRequestFromParameter:(DownloadParam *)param{
    NSLog(@"Http status code : %ld",param.http_code);
    NSLog(@"status code : %ld",param.result_code);
    NSLog(@"status apple code : %ld",param.apple_error_code);
    NSLog(@"message: %@",param.result_err_mes);
    BOOL notErr = NO;
    switch (param.http_code) {
        case ERROR_HTTP_DONT_NETWORK:
            if (param.apple_error_code == -1009) {
                notErr = NO;
                [self alertNoNetwork];
            }else{
                [self alertErrMsgWith:@"接続タイムアウトが発生しました。"];
            }
            
            break;
        case ERROR_BAD_REQUEST:{
            
            break;
        }
        case ERROR_TOO_MANY_REQUEST:
            notErr = NO;
            
            break;
        case ERROR_INTERNAL_SERVER:
            notErr = NO;
            
            break;
        case ERROR_BAD_GATE_WAY:
            notErr = NO;
            
            break;
        case ERROR_SERVICE_UNAVAILABLE:
            notErr = NO;
            
            break;
        case ERROR_GATEWAY_TIMEOUT:
            notErr = NO;
            
            break;
        case ERROR_FORBIDDEN:{
            
            break;
        } case ERROR_NOT_FOUND:{
            
            break;
        }
        default:
            break;
    }
    
    
    
    return notErr;
}
- (void)alertNoNetwork{
    [self alertErrMsgWith:@"インターネットに接続できません。"];
}
@end
