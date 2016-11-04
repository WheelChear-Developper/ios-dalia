//
//  FBManager.m
//  FBPOSTVIEW
//
//  Created by FAHC03-139 on 12/26/12.
//  Copyright (c) 2012 NECVN-BIGLOBE. All rights reserved.

#import "FBManager.h"
#define FBSESSION @"FBSESSION"
@implementation FBManager
+ (FBManager *)instance{
    static FBManager *manager = nil;
    if (!manager) {
        manager = [[FBManager alloc] init];
    }
    return manager;
}
- (id)init
{
    self = [super init];
    if (self) {
        switch ([FBSession activeSession].state) {
            case FBSessionStateCreated:
                break;
            case FBSessionStateCreatedTokenLoaded:
                [self loadSession:nil object:nil];
                break;
            case FBSessionStateCreatedOpening:
                break;
            case FBSessionStateOpen:
                break;
            case FBSessionStateOpenTokenExtended:
                break;
            case FBSessionStateClosedLoginFailed:
                break;
            case FBSessionStateClosed:
                break;
            default:
                break;
        }
        
        
    }
    return self;
}
- (void)saveSession:(FBAccessTokenData *)session{
    [[FBSessionTokenCachingStrategy defaultInstance] cacheFBAccessTokenData:session];
}
- (void)loadSession:(SEL)actionFinish object:(id)object{
    
    
    NSBundle* mainBundle = [NSBundle mainBundle];
    
    NSString *appID = [mainBundle objectForInfoDictionaryKey:@"FacebookAppID"];
    NSString *urlSchemeSuffix = @"";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        urlSchemeSuffix = @"oebgaaahf";
    }else{
        //        urlSchemeSuffix = [NSString stringWithFormat:@"fb%@",appID];
    }
    
    
    
    // Get the bundle identifier
    [mainBundle bundleIdentifier];
    
    //    if (session) {
    FBSession *session = [[FBSession alloc] initWithAppID:appID
                                              permissions:[NSArray arrayWithObjects:@"publish_actions",@"email",nil]
                                          urlSchemeSuffix:urlSchemeSuffix
                                       tokenCacheStrategy:[FBSessionTokenCachingStrategy defaultInstance]];
    [FBSession setActiveSession:session];
    [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorWithNoFallbackToWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        switch (session.state) {
            case FBSessionStateCreated:
                break;
            case FBSessionStateCreatedTokenLoaded:
                break;
            case FBSessionStateCreatedOpening:
                break;
            case FBSessionStateOpen:
                break;
            case FBSessionStateOpenTokenExtended:
                break;
            case FBSessionStateClosedLoginFailed:
                break;
            case FBSessionStateClosed:
                break;
                
            default:
                break;
        }
        if (status == FBSessionStateOpen || status == FBSessionStateOpenTokenExtended){
            if (actionFinish) {
                int64_t delayInSeconds = .3;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self performSelectorOnMainThread:actionFinish withObject:object waitUntilDone:NO];
                });
            }
            
            
        }
        
    }];
}
- (BOOL)isLogin{
    return [FBSession activeSession].isOpen;
}
- (BOOL)login{
    if (![FBSession activeSession].isOpen) {
        
        [self loadSession:@selector(requestName) object:nil];
        return NO;
    }
    return YES;
}
- (void)logout {
    if ([FBSession.activeSession isOpen]) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        [self performSelectorOnMainThread:@selector(saveSession:) withObject:nil waitUntilDone:NO];
        //        if ([self respondsToSelector:@selector(setNameSTR:)]) {
        //            [self performSelectorOnMainThread:@selector(setNameSTR:) withObject:@"" waitUntilDone:YES];
        //        }
    }
    //    [self performSelectorInBackground:@selector(logoutNow) withObject:nil];
}
- (NSString *)getName {
    
    if ([FBSession activeSession].isOpen && !([self.name length] > 0)) {
        [self performSelectorOnMainThread:@selector(requestName) withObject:nil waitUntilDone:NO];
    }
    return self.name;
}
//- (void)setNameSTR:(NSString *)str {
//    self.name = str;
//	/*
//	 Remember check _delegate before calling it
//	 */
//    if (_delegate && [_delegate respondsToSelector:@selector(updateName:)]) {
//        [_delegate performSelectorOnMainThread:@selector(updateName:) withObject:self.name waitUntilDone:YES];
//    }
//}
- (void)requestName {
    [self performSelectorOnMainThread:@selector(saveSession:) withObject:[FBSession activeSession].accessTokenData waitUntilDone:YES];
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                       id<FBGraphUser> user,
                                       NSError *error) {
         if (!error) {
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             [dic setValue:user forKey:@"user"];
             NSURLResponse *res;
             NSError *err;
             NSString *imageDL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",user.id];
             NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageDL]] returningResponse:&res error:&err];
             if (data) {
                 [dic setValue:data forKey:@"image"];
             }
             
             int64_t delayInSeconds = .2;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 if ([self.delegate respondsToSelector:@selector(getSuccessInfoUser:)]) {
                     [self.delegate performSelectorOnMainThread:@selector(getSuccessInfoUser:) withObject:dic waitUntilDone:YES];
                 }
             });
             
             
         }
     }];
}

#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    
    if (FBSession.activeSession.isOpen) {
        if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
            // if we don't already have the permission, then we request it now
            [[FBSession activeSession] requestNewPublishPermissions:[NSArray arrayWithObjects:@"publish_actions",nil] defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
                if (!error) {
                    action();
                }
            }];
        } else {
            action();
        }
    }else{
        [self loadSession:@selector(performPublishAction:) object:action];
    }
    
    
}


// Post Status Update button handler; will attempt to invoke the native
// share dialog and, if that's unavailable, will post directly
- (void)postStatusUpdateClick:(NSString *)message andWithObject:(MPCouponObject *)object{
    // Post a status update to the user's feed via the Graph API, and display an alert view
//    if ([self.delegate respondsToSelector:@selector(postStatusComplete:)]) {
//        [self.delegate postStatusComplete:nil];
//    }
    // with the results or an error.
     __block id blockDelegate = self.delegate;
    [self performPublishAction:^{
        // otherwise fall back on a request for permissions and a direct post
        [FBRequestConnection startForPostStatusUpdate:message
                                    completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                        if (error == nil) {
                                            NSLog(@"post success");
                                            
                                            [blockDelegate postStatusComplete:nil];
                                
                                            
                                            
                                        } else {
                                            NSLog(@"post failed");
                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:TITLE_MESSAGE_SHARE_FACEBOOK message:MESSAGE_SHARE_SOCIAL_ERROR delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alertView show];
                                        }
                                        
                                    }];
        
    }];
}
- (void)postStatus:(NSString *)mes WithPhoto:(UIImage *)img{
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    if (!img) {
        return;
    }
    [self performPublishAction:^{
        // otherwise fall back on a request for permissions and a direct post
        NSString *message = mes;
        UIImage *image = img;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:UIImagePNGRepresentation(image) forKey:@"picture"];
        if (mes) {
            [params setValue:message forKey:@"message"];
        }
        
        
        // use the "startWith" helper static on FBRequest to both create and start a request, with
        // a specified completion handler.
        [FBRequestConnection startWithGraphPath:@"me/photos"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  if ([self.delegate respondsToSelector:@selector(postStatusComplete:)]) {
                                      [self.delegate performSelectorOnMainThread:@selector(postStatusComplete:) withObject:error  waitUntilDone:YES];
                                  }
                                  
                              }];
        
    }];
}



#pragma mark - ManagerDoanloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param{
    
}

- (void)downloadDataFail:(DownloadParam *)param{
    
}

@end
