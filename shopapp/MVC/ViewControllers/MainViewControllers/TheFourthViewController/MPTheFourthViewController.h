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
// INSERTED BY M.ama 2016.10.25 START
// 誕生日登録による表示変更
#import "MPMemberObject.h"
// INSERTED BY M.ama 2016.10.25 END

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

    // INSERTED BY M.ama 2016.10.25 START
    // 誕生日登録による表示変更
    MPMemberObject* memberObj;
    BOOL bln_TotalBirthday;
    // INSERTED BY M.ama 2016.10.25 END

    // INSERTED BY M.ama 2016.10.25 START
    // 可変テーブル用変数
    long lng_TotalHeight;
    // INSERTED BY M.ama 2016.10.25 END

    // INSERTED BY M.ama 2016.102.30 START
    // テーブル高さ調整
    UILabel *lbl_notList;
    UIImageView *birthday_backclorview;
    UILabel *birthday_title;
    UIImage *birthday_img_toppics;
    UIImageView *birthday_buttonView;
    UIButton *btn_Birthday;
    // INSERTED BY M.ama 2016.102.30 END
}
@end
