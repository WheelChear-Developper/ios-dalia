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
#import "MPNewHomeObject.h"
#import "DeployGateSDK/DeployGateSDK.h"

@interface MPHomeViewController : MPBaseViewController<ManagerDownloadDelegate, MPTopImagesViewDelegate, TheUserInfoViewControllerDelegate ,UIScrollViewDelegate>
{
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UIImageView *iv_toppics;
    MPTopImagesView *topImageView;
    NSMutableArray *listCoupon;
    UIButton *btn_curpon;
}

@end