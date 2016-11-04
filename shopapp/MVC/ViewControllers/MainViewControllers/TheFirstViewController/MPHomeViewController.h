//
//  MPHomeViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPTopImagesView.h"
#import "Configuration.h"
#import "TheUserInfoViewController.h"
#import "MPHomeMenuViewController.h"
#import "MPHomeOkonomiViewController.h"
#import "MPHomeMonjyaViewController.h"
#import "MPHomeWebViewViewController.h"
// INSERTED  M.ama 2016.10.26 START
// 新着情報取得設定
#import "MPNewHomeObject.h"
// INSERTED  M.ama 2016.10.26 END

#import "DeployGateSDK/DeployGateSDK.h"

@interface MPHomeViewController : MPBaseViewController<ManagerDownloadDelegate, MPTopImagesViewDelegate, TheUserInfoViewControllerDelegate ,UIScrollViewDelegate>
{
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UIImageView *iv_toppics;

    MPTopImagesView *topImageView;
    // INSERTED  M.ama 2016.10.26 START
    // 新着情報取得設定
    NSMutableArray *listCoupon;
    // INSERTED  M.ama 2016.10.26 END
    // INSERTED BY M.ama 2016.10.31 START
    // 可変テーブル用
    UIButton *btn_curpon;
    // INSERTED BY M.ama 2016.10.31 END
}

@end
