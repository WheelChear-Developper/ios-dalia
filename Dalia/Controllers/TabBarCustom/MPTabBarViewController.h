//
//  MPTabBarViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "ManagerDownload.h"
#import "MPSlideMenuView.h"

#define FRAME_HEIGHT 44
#define FRAME_ORGIN 0
#define ICON_WIDTH 210
#define ICON_HEIGHT 44
#define FRAME_FOR_BACK_BUTTON CGRectMake(0, 0, 50, 44)

@interface MPTabBarViewController : UITabBarController <ManagerDownloadDelegate, MPSlideMenuViewDelegate>
{
    long _numberTab;
    NSMutableArray* _listButton;
    BOOL _firstTimeRun;
    UIView* _view_custom_navigationView;
    UIImageView* _iv_custom_config;
    UIButton* _btn_custom_setting;
    UIView* _view_NaviFrame;
    MPSlideMenuView* _view_NaviMenu;
    float _statusHeight;
    UIImageView* _bgTabBar;
    UIImageView* _iv_custom_navigationIcon;
    UIImageView* _imv_notification;
}
@property (nonatomic) BOOL bln_ScreenSetting;

+ (MPTabBarViewController*) sharedInstance;
- (void)setUpTabBar;
- (void)selectTab:(long)tabID;
- (void)fadeInTab:(BOOL)isEnable;
- (void)tabHidden:(BOOL)isEnable;
- (void)setTabNotificationHidden:(BOOL)isEnable;
- (void)setDisableHomeButton:(BOOL)isEnable;

- (void)setCustomNavigaion;
- (void)setCustomNavigationLogo:(UIImage*)image;
- (void)setCustomNavigationHiden:(BOOL)isEnable;
- (void)custom_TopNavigationHidden:(BOOL)isEnable;

@end
