//
//  MPStampCardViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/25.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPCouponStampObject.h"

@protocol MPStampCardViewControllerDelegate<NSObject>
@end

@interface MPStampCardViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, CBCentralManagerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    CBCentralManager* bluetoothManager;
    MPCouponStampObject* couponStampObject;

    long numberStampSelected;

    __weak IBOutlet UILabel *lbl_No01;
    __weak IBOutlet UILabel *lbl_No02;
    __weak IBOutlet UILabel *lbl_No03;
    __weak IBOutlet UILabel *lbl_No04;
    __weak IBOutlet UILabel *lbl_No05;
    __weak IBOutlet UILabel *lbl_No06;
    __weak IBOutlet UILabel *lbl_No07;
    __weak IBOutlet UILabel *lbl_No08;
    __weak IBOutlet UILabel *lbl_No09;
    __weak IBOutlet UILabel *lbl_No10;
    __weak IBOutlet UILabel *lbl_No11;
    __weak IBOutlet UILabel *lbl_No12;
    __weak IBOutlet UILabel *lbl_No13;
    __weak IBOutlet UILabel *lbl_No14;
    __weak IBOutlet UILabel *lbl_No15;
    __weak IBOutlet UILabel *lbl_No16;
    __weak IBOutlet UILabel *lbl_No17;
    __weak IBOutlet UILabel *lbl_No18;
    __weak IBOutlet UILabel *lbl_No19;
    __weak IBOutlet UILabel *lbl_No20;

    __weak IBOutlet UIImageView *img_stamp01;
    __weak IBOutlet UIImageView *img_stamp02;
    __weak IBOutlet UIImageView *img_stamp03;
    __weak IBOutlet UIImageView *img_stamp04;
    __weak IBOutlet UIImageView *img_stamp05;
    __weak IBOutlet UIImageView *img_stamp06;
    __weak IBOutlet UIImageView *img_stamp07;
    __weak IBOutlet UIImageView *img_stamp08;
    __weak IBOutlet UIImageView *img_stamp09;
    __weak IBOutlet UIImageView *img_stamp10;
    __weak IBOutlet UIImageView *img_stamp11;
    __weak IBOutlet UIImageView *img_stamp12;
    __weak IBOutlet UIImageView *img_stamp13;
    __weak IBOutlet UIImageView *img_stamp14;
    __weak IBOutlet UIImageView *img_stamp15;
    __weak IBOutlet UIImageView *img_stamp16;
    __weak IBOutlet UIImageView *img_stamp17;
    __weak IBOutlet UIImageView *img_stamp18;
    __weak IBOutlet UIImageView *img_stamp19;
    __weak IBOutlet UIImageView *img_stamp20;

    __weak IBOutlet UILabel *lbl_date01;
    __weak IBOutlet UILabel *lbl_date02;
    __weak IBOutlet UILabel *lbl_date03;
    __weak IBOutlet UILabel *lbl_date04;
    __weak IBOutlet UILabel *lbl_date05;
    __weak IBOutlet UILabel *lbl_date06;
    __weak IBOutlet UILabel *lbl_date07;
    __weak IBOutlet UILabel *lbl_date08;
    __weak IBOutlet UILabel *lbl_date09;
    __weak IBOutlet UILabel *lbl_date10;
    __weak IBOutlet UILabel *lbl_date11;
    __weak IBOutlet UILabel *lbl_date12;
    __weak IBOutlet UILabel *lbl_date13;
    __weak IBOutlet UILabel *lbl_date14;
    __weak IBOutlet UILabel *lbl_date15;
    __weak IBOutlet UILabel *lbl_date16;
    __weak IBOutlet UILabel *lbl_date17;
    __weak IBOutlet UILabel *lbl_date18;
    __weak IBOutlet UILabel *lbl_date19;
    __weak IBOutlet UILabel *lbl_date20;

    __weak IBOutlet UILabel *lbl_setsumei;
    __weak IBOutlet UILabel *lbl_date;
    __weak IBOutlet UIView *view_date;

}
@property (nonatomic, assign) id<MPStampCardViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

- (IBAction)btn_stamp01:(id)sender;
- (IBAction)btn_stamp02:(id)sender;
- (IBAction)btn_stamp03:(id)sender;
- (IBAction)btn_stamp04:(id)sender;
- (IBAction)btn_stamp05:(id)sender;
- (IBAction)btn_stamp06:(id)sender;
- (IBAction)btn_stamp07:(id)sender;
- (IBAction)btn_stamp08:(id)sender;
- (IBAction)btn_stamp09:(id)sender;
- (IBAction)btn_stamp10:(id)sender;
- (IBAction)btn_stamp11:(id)sender;
- (IBAction)btn_stamp12:(id)sender;
- (IBAction)btn_stamp13:(id)sender;
- (IBAction)btn_stamp14:(id)sender;
- (IBAction)btn_stamp15:(id)sender;
- (IBAction)btn_stamp16:(id)sender;

@end

