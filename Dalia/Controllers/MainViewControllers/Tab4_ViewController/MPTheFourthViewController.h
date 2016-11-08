//
//  MPTheFourthViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseViewController.h"
#import "MPCouponCell.h"
#import "ManagerDownload.h"
#import "TVOPickerDate.h"
#import "MPAlertView.h"
#import "MPMemberObject.h"

@interface MPTheFourthViewController : MPBaseViewController<UITableViewDataSource, UITableViewDelegate, MPCouponCellDelegate, ManagerDownloadDelegate, TVOPickerDateDelegate, MPAlertViewDelegate>
{
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UIImageView *iv_toppics;
    
    UITableView *_tableView;
    NSMutableArray *listCoupon;
    NSMutableArray *listCouponBase;
    TVOPickerDate *pickerDate;
    MPCouponObject *couponUse;
    NSString *dobCoupon;
    MPMemberObject* memberObj;
    BOOL bln_TotalBirthday;
    long lng_TotalHeight;
    UILabel *lbl_notList;
    UIImageView *birthday_backclorview;
    UILabel *birthday_title;
    UIImage *birthday_img_toppics;
    UIImageView *birthday_buttonView;
    UIButton *btn_Birthday;
}
@end
