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
    // INSERTED  M.ama 2016.10.26 START
    // 新着情報取得設定
    UIImageView *iv_news_count;
    UILabel *lbl_news_count;
    // INSERTED  M.ama 2016.10.26 END

    // INSERTED  M.ama 2016.10.26 START
    // 新着情報取得設定
    UIImageView *iv_coupon_count;
    UILabel *lbl_coupon_count;
    // INSERTED  M.ama 2016.10.26 END
}
@property (nonatomic) BOOL bln_ScreenSetting;

+ (MPTabBarViewController*) sharedInstance;
- (void)setUpTabBar;
- (void)selectTab:(long)tabID;
- (void)setDisableHomeButton:(BOOL)isEnable;
// INSERTED  M.ama 2016.10.26 START
// 新着情報取得設定
- (void)setNewsCount:(long)count;
- (void)setCouponCount:(long)count;
// INSERTED  M.ama 2016.10.26 END

@end
