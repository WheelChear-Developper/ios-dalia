//
//  MPTabBarViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "ManagerDownload.h"

#define FRAME_HEIGHT 44
#define FRAME_ORGIN 0
#define ICON_WIDTH 210
#define ICON_HEIGHT 44
#define FRAME_FOR_BACK_BUTTON CGRectMake(0, 0, 50, 44)

@interface MPTabBarViewController : UITabBarController <ManagerDownloadDelegate>
{
    long _numberTab;
    NSMutableArray* _listButton;
    BOOL _firstTimeRun;

    UIImageView* _bgTabBar;    
    UIImageView* _imv_notification;
}
@property (nonatomic) BOOL bln_ScreenSetting;

+ (MPTabBarViewController*) sharedInstance;
- (void)setUpTabBar;
- (void)setTabViewIndex:(long)tabID;
- (void)selectTab:(long)tabID;
- (void)setFadeOut_Tab:(BOOL)isEnable;
- (void)setHidden_Tab:(BOOL)isEnable;
- (void)setTabNotificationHidden:(BOOL)isEnable;
- (void)setDisableHomeButton:(BOOL)isEnable;

@end
