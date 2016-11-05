//
//  MPTheThirdViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "MPBaseViewController.h"
#import "MPCouponStampView.h"

@interface MPTheThirdViewController : MPBaseViewController <ManagerDownloadDelegate, MPCouponStampViewDelegate, UIScrollViewDelegate, CBCentralManagerDelegate>
{

    MPCouponStampView *couponStampView;
    CBCentralManager* bluetoothManager;

    __weak IBOutlet UILabel *lbl_Infomation;
    IBOutlet UIScrollView* scr_rootview;
    IBOutlet UIView *scr_inView;
    IBOutlet UIView *cornerView;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_recipe;
@property (weak, nonatomic) IBOutlet UIView *view_stamp;
@property (weak, nonatomic) IBOutlet UIView *view_IdBackColor;

- (void)setArertCurpon:(NSString*)no;

@end
