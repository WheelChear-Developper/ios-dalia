//
//  MPTabBarViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"

@interface MPTabBarViewController : UITabBarController <ManagerDownloadDelegate>
{
    int numberTab;
    NSMutableArray *listButton;
    BOOL firstTimeRun;
    NSArray *listShop;
    UIImageView *iv_config;
    UIButton *btn_setting;
    UIImageView *iv_news_count;
    UILabel *lbl_news_count;
    UIImageView *iv_coupon_count;
    UILabel *lbl_coupon_count;
}
@property (nonatomic) BOOL bln_ScreenSetting;

+ (MPTabBarViewController*) sharedInstance;
- (void)setUpTabBar;
- (void)selectTab:(long)tabID;
- (void)setDisableHomeButton:(BOOL)isEnable;
- (void)setNewsCount:(long)count;
- (void)setCouponCount:(long)count;

@end
