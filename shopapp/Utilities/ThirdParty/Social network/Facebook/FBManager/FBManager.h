//
//  FBManager.h
//  FBPOSTVIEW
//
//  Created by FAHC03-139 on 12/26/12.
//  Copyright (c) 2012 NECVN-BIGLOBE. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <FacebookSDK/FacebookSDK.h>
#import "ManagerDownload.h"
@protocol FBManagerDelegate
- (void)postStatusComplete:(NSError *)error;
- (void)getSuccessInfoUser:(NSDictionary *)info;
@end

@interface FBManager : NSObject<UIAlertViewDelegate,ManagerDownloadDelegate>{
	BOOL shareOkay;
}
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIViewController *parentCV;
@property (assign, nonatomic) NSObject<FBManagerDelegate> *delegate;
+ (FBManager *)instance;
- (BOOL)login;
- (BOOL)isLogin;
- (void)logout;
//- (void)loadSession;
- (NSString *)getName;
- (void)postStatusUpdateClick:(NSString *)message andWithObject: (MPCouponObject*) object;
- (void)postStatus:(NSString *)message WithPhoto:(UIImage *)image;
@end
