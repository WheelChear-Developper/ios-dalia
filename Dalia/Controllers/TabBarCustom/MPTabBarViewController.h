//
//  MPTabBarViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"
#import "MPSlideMenuView.h"

#define FRAME_HEIGHT 44
#define FRAME_ORGIN 0
#define ICON_WIDTH 210
#define ICON_HEIGHT 44
#define FRAME_FOR_BACK_BUTTON CGRectMake(0, 0, 50, 44)

@interface MPTabBarViewController : UITabBarController <ManagerDownloadDelegate, MPSlideMenuViewDelegate>
{
    long numberTab;
    NSMutableArray *listButton;
    BOOL firstTimeRun;
    NSArray *listShop;
    UIImageView *iv_config;
    UIButton *btn_setting;
    UIImageView *iv_news_count;
    UILabel *lbl_news_count;
    UIImageView *iv_coupon_count;
    UILabel *lbl_coupon_count;

    UIView *view_custom_navigationView;
    UIImageView *iv_custom_config;
    UIButton *btn_custom_setting;
    UIView* view_NaviFrame;
    MPSlideMenuView* view_NaviMenu;
    long lng_NavigationMenu_point;
    float statusHeight;
    UIImageView *bgTabBar;
    UIImageView *iv_custom_navigationIcon;
}
@property (nonatomic) BOOL bln_ScreenSetting;

+ (MPTabBarViewController*) sharedInstance;
- (void)setUpTabBar;
- (void)setCustomNavigaion;
- (void)selectTab:(long)tabID;
- (void)setDisableHomeButton:(BOOL)isEnable;
- (void)setNewsCount:(long)count;
- (void)setCouponCount:(long)count;
- (void)setCustomNavigationHiden:(BOOL)isEnable;
- (void)custom_open_TopNavigation:(UIButton*)button;
- (void)custom_close_TopNavigation:(UIButton*)button;
- (void)open_Tab:(UIButton*)button;
- (void)close_Tab:(UIButton*)button;
- (void)SetCustomNavigationLogo:(UIImage*)image;

@end
