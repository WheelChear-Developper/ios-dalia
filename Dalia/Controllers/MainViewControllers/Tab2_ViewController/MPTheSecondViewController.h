//
//  MPTheSecondViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPNewHomeCell.h"

@interface MPTheSecondViewController : MPBaseViewController<UITableViewDataSource, UITableViewDelegate, ManagerDownloadDelegate>
{
    UITableView *_tableView;
    NSMutableArray *listCoupon;
    NSMutableArray *listCouponBase;
    MPCouponObject *couponUse;
    NSString *dobCoupon;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UIImageView *iv_toppics;
}
@property (nonatomic,strong) NSMutableArray *listObject;

@end
