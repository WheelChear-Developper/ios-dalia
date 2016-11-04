//
//  MPAppDelegate.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ManagerDownload.h"

@interface MPAppDelegate : UIResponder <UIApplicationDelegate,ManagerDownloadDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) BOOL networkStatus;
@property (nonatomic, strong) NSString* enableNotificationString;
@property (strong, nonatomic) NSOperationQueue *mainQueue;
@property (nonatomic) BOOL fullScreenVideoIsPlaying;
+ (MPAppDelegate*) sharedMPAppDelegate;
@property (nonatomic) long totalBadge;
@property (nonatomic) long couponBadge;

@end
