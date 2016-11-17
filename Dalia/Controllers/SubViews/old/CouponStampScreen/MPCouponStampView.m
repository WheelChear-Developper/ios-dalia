//
//  MPCouponStampView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/9/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponStampView.h"
#import <CoreLocation/CoreLocation.h>
#import "ProgressView.h"
#import "MPTabBarViewController.h"

#define SIZE_STAMP 78
#define SIDE_PADDING_STAMP 10
#define LONGITUDINAL_PADDING_STAMP 10
#define ROW_UP_GAP_STAMP 20

@interface MPCouponStampView()<CLLocationManagerDelegate>
{
    // ビーコン利用フラグ
    BOOL is_beacon;
    // ビーコン数
    NSInteger beaconCount;
    int beacon_amount;
    // スタンプボタン
    UIButton* onButton;
    // タイムアウトタイマー
    NSTimer* timeout;
    // アラートビュー
    UIAlertView *alertView;
    // メッセージ表示フラグ
    BOOL is_alert;
}
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet CLBeacon *nearestBeacon;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) BOOL isStamp;
@end

@implementation MPCouponStampView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //基本VIEW背景色設定
    [self setBackgroundColor:[UIColor clearColor]];
    
    [[ManagerDownload sharedInstance] getDetailCouponStamp:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

#pragma mark - ManagerDownloadDelegateƒ
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        case RequestType_GET_DETAIL_COUPON_STAMP:
        {
            couponObject = (MPCouponObject*)[param.listData lastObject];

            // REPLACED BY M.ama 2016.10.27 START
            // スタンプ無効時の表示
            if(couponObject == nil){

                // INSERTED BY M.ama 2016.10.29 START
                //ユーザーランクの色設定
                if ([self.delegate respondsToSelector:@selector(setUserIDColor:)]) {
                    [self.delegate setUserIDColor:@""];
                }
                // INSERTED BY M.ama 2016.10.29 END

                [self.delegate setNotStampForm];

            }else{

                [self setUpView:couponObject];

                // INSERTED BY M.ama 2016.10.26 START
                // クーポン件数取得用更新
                [self.delegate setInfomation:couponObject.stamp_condition];
                // INSERTED BY M.ama 2016.10.26 END
            }
            // REPLACED BY M.ama 2016.10.27 START
        }
            break;
            
        case RequestType_SET_REGIST_COUPON:
        {
            if ([self.delegate respondsToSelector:@selector(backToCouponTab)]) {
                [self.delegate backToCouponTab];
            }
        }
            break;
            
        default:

            // 電子スタンプ機能実装
            if (param.result_code == 205) {
                alertView = [[UIAlertView alloc] initWithTitle:nil message:@"来店スタンプは1日１回迄です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
            // REPLACED BY M.ama 2016.10.11 START
            // iBeaconで設定
            if ([[[param.listData lastObject] objectForKey:@"message"] isEqualToString:@"OK"]) {
                
                [self setArertCurponNo:[[param.listData lastObject] objectForKey:@"count"]];
            }
            // REPLACED BY M.ama 2016.10.11 END

            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

//画面のスタンプViewを追加
- (void)setUpView:(MPCouponObject*)object {
    
    // REPLACED BY ama 2016.10.08 START
    // 土台設定修正
    for (UIView *view in [stampView subviews]) {
        [view removeFromSuperview];
    }
    //土台設定
    [stampView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    //スタンプ台の背景色設定
    stampView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:240/255.0 alpha:1.0];
    // REPLACED BY ama 2016.10.08 START

    if (object) {
        
        // 電子スタンプ機能実装
        [self setBeacons:object];

        // REPLACED BY ama 2016.10.04 START
        //スタンプ数
        numberStampSelected = 0;
        NSArray* ary_stamps = [object.stamp_date_set mutableCopy];
        NSMutableArray* ary_stamps_money = [[NSMutableArray alloc] init];

        for(long l=0;l < ary_stamps.count;l++){
            
            NSMutableDictionary* dic_stamp = [ary_stamps objectAtIndex:l];
            NSString* ss = [dic_stamp objectForKey:@"date_set"];
            if(![ss isEqualToString:@""]){
                
                numberStampSelected += 1;
            }
            
            [ary_stamps_money addObject:[dic_stamp objectForKey:@"price"]];
        }
        // REPLACED BY ama 2016.10.04 END
        
        /*
        numberStampSelected = 20;
        NSMutableArray *d = [[NSMutableArray alloc] init];
        NSMutableDictionary *bt1 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt2 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt3 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt4 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt5 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt6 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt7 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt8 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt9 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt10 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt11 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt12 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt13 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt14 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt15 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt16 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt17 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt18 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt19 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *bt20 = [[NSMutableDictionary alloc] init];
        [bt1 setValue:@"2000/01/01" forKey:@"date_set"];
        [bt2 setValue:@"2000/01/02" forKey:@"date_set"];
        [bt3 setValue:@"2000/01/03" forKey:@"date_set"];
        [bt4 setValue:@"2000/01/04" forKey:@"date_set"];
        [bt5 setValue:@"2000/01/05" forKey:@"date_set"];
        [bt6 setValue:@"2000/01/06" forKey:@"date_set"];
        [bt7 setValue:@"2000/01/07" forKey:@"date_set"];
        [bt8 setValue:@"2000/01/08" forKey:@"date_set"];
        [bt9 setValue:@"2000/01/09" forKey:@"date_set"];
        [bt10 setValue:@"2000/01/10" forKey:@"date_set"];
        [bt11 setValue:@"2000/01/11" forKey:@"date_set"];
        [bt12 setValue:@"2000/01/12" forKey:@"date_set"];
        [bt13 setValue:@"2000/01/13" forKey:@"date_set"];
        [bt14 setValue:@"2000/01/14" forKey:@"date_set"];
        [bt15 setValue:@"2000/01/15" forKey:@"date_set"];
        [bt16 setValue:@"2000/01/16" forKey:@"date_set"];
        [bt17 setValue:@"2000/01/17" forKey:@"date_set"];
        [bt18 setValue:@"2000/01/18" forKey:@"date_set"];
        [bt19 setValue:@"2000/01/19" forKey:@"date_set"];
        [bt20 setValue:@"2000/01/20" forKey:@"date_set"];
        [d addObject:bt1];
        [d addObject:bt2];
        [d addObject:bt3];
        [d addObject:bt4];
        [d addObject:bt5];
        [d addObject:bt6];
        [d addObject:bt7];
        [d addObject:bt8];
        [d addObject:bt9];
        [d addObject:bt10];
        [d addObject:bt11];
        [d addObject:bt12];
        [d addObject:bt13];
        [d addObject:bt14];
        [d addObject:bt15];
        [d addObject:bt16];
        [d addObject:bt17];
        [d addObject:bt18];
        [d addObject:bt19];
        [d addObject:bt20];
        object.stamp_date_set = d;
        */
        
        //ユーザーランクの色設定
        if ([self.delegate respondsToSelector:@selector(setUserIDColor:)]) {
            [self.delegate setUserIDColor:object.rank_color];
        }
        
        long row = 0;
        long column = 0;
        long count_stamp = 0;
        stampCount = numberStampSelected;
        
         //位置によるボタンに位置とサイズを設定
        for (long i = 0; i < 24; i ++) {
            
            //スタンプ用ボックス
            UIImage* img_uncheck = [[UIImage alloc] init];
            UIView* view_totalBox = [[UIView alloc] init];
            UIView* view_boxin = [[UIView alloc] init];
            UIView* view_boxin_white = [[UIView alloc] init];
            //スタンプ
            UIImage* img_stamp = [[UIImage alloc] init];
            UIView* view_stampSet = [[UIView alloc] init];
            //スタンプ用ラベル
            UILabel* lbl_no = [[UILabel alloc] init];
            UILabel* lbl_money = [[UILabel alloc] init];
            UILabel* lbl_date = [[UILabel alloc] init];
            //スタンプ用ボタン
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            
            switch (i % 6) {
                case 0:
                    
                    //スタンプカウント
                    count_stamp += 1;
                    
                    //スタンプボックス
                    view_totalBox.backgroundColor = [UIColor lightGrayColor];
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP+SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプボックス内部
                    img_uncheck = [UIImage imageNamed:@"icon_uncheck_stamp.png"];
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, view_totalBox.frame.size.width - 2, view_totalBox.frame.size.height - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //番号設定
                    lbl_no.frame = CGRectMake(50.0f, view_boxin.frame.size.height - 25.0f, view_boxin.frame.size.width - 5.0f - 50.0f, 25.0f);
                    [view_boxin addSubview:lbl_no];
                    
                    //スタンプ配置用
                    img_stamp = [UIImage imageNamed:@"icon_checked_stamp.png"];
                    view_stampSet = [[UIImageView alloc] initWithImage:img_stamp];
                    view_stampSet.contentMode = UIViewContentModeScaleAspectFit;
                    view_stampSet.backgroundColor = [UIColor clearColor];
                    view_stampSet.frame = CGRectMake(2, 2, view_boxin.frame.size.width - 4, view_boxin.frame.size.height - 4);
                    [view_boxin addSubview:view_stampSet];
                    view_stampSet.hidden = YES;
                    
                    //スタンプ日付追加
                    lbl_date.frame = CGRectMake(0, view_boxin.frame.size.height / 20 * 13, view_boxin.frame.size.width, 10.0f);
                    lbl_date.backgroundColor = [UIColor clearColor];
                    lbl_date.font = [UIFont fontWithName:@"Arial" size:9];
                    lbl_date.textColor = [UIColor redColor];
                    lbl_date.textAlignment = NSTextAlignmentCenter;
                    [view_boxin addSubview:lbl_date];
                    lbl_date.hidden = YES;
                    
                    //金額設定
                    lbl_money.frame = CGRectMake(view_totalBox.frame.origin.x, view_totalBox.frame.origin.y + view_totalBox.frame.size.height, SIZE_STAMP, 25.0f);
                    
                    //ボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [button setTag:count_stamp - 1];
                    [stampView addSubview:button];
                    
                    //スタンプボタンの押された時の処理（押した時）　1.手で押した時
                    [button addTarget:self action:@selector(getStampButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //スタンプボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
                    [button addTarget:self action:@selector(getStampButtonDown:) forControlEvents:UIControlEventTouchDown];
                    
                    break;
                    
                case 1:
                    
                    //スタンプカウント
                    count_stamp += 1;
                    
                    //スタンプボックス
                    view_totalBox.backgroundColor = [UIColor lightGrayColor];
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP+SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプ基本ボックス
                    img_uncheck = [UIImage imageNamed:@"icon_uncheck_stamp.png"];
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //番号設定
                    lbl_no.frame = CGRectMake(50.0f, view_boxin.frame.size.height - 25.0f, view_boxin.frame.size.width - 5.0f - 50.0f, 25.0f);
                    [view_boxin addSubview:lbl_no];
                    
                    //スタンプ配置用
                    img_stamp = [UIImage imageNamed:@"icon_checked_stamp.png"];
                    view_stampSet = [[UIImageView alloc] initWithImage:img_stamp];
                    view_stampSet.contentMode = UIViewContentModeScaleAspectFit;
                    view_stampSet.backgroundColor = [UIColor clearColor];
                    view_stampSet.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_stampSet];
                    view_stampSet.hidden = YES;
                    
                    //スタンプ日付追加
                    lbl_date.frame = CGRectMake(0, view_boxin.frame.size.height / 20 * 13, view_boxin.frame.size.width, 10.0f);
                    lbl_date.backgroundColor = [UIColor clearColor];
                    lbl_date.font = [UIFont fontWithName:@"Arial" size:9];
                    lbl_date.textColor = [UIColor redColor];
                    lbl_date.textAlignment = NSTextAlignmentCenter;
                    [view_boxin addSubview:lbl_date];
                    lbl_date.hidden = YES;
                    
                    //金額設定
                    lbl_money.frame = CGRectMake(view_totalBox.frame.origin.x, view_totalBox.frame.origin.y + view_totalBox.frame.size.height, SIZE_STAMP, 25.0f);
                    
                    //ボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [button setTag:count_stamp - 1];
                    [stampView addSubview:button];
                    
                    //スタンプボタンの押された時の処理（押した時）　1.手で押した時
                    [button addTarget:self action:@selector(getStampButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //スタンプボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
                    [button addTarget:self action:@selector(getStampButtonDown:) forControlEvents:UIControlEventTouchDown];
                    
                    break;
                    
                case 2:
                    
                    //スタンプカウント
                    count_stamp += 1;
                    
                    //スタンプボックス
                    view_totalBox.backgroundColor = [UIColor lightGrayColor];
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP+SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプ基本ボックス
                    img_uncheck = [UIImage imageNamed:@"icon_uncheck_stamp.png"];
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //番号設定
                    lbl_no.frame = CGRectMake(50.0f, view_boxin.frame.size.height - 25.0f, view_boxin.frame.size.width - 5.0f - 50.0f, 25.0f);
                    [view_boxin addSubview:lbl_no];
                    
                    //スタンプ配置用
                    img_stamp = [UIImage imageNamed:@"icon_checked_stamp.png"];
                    view_stampSet = [[UIImageView alloc] initWithImage:img_stamp];
                    view_stampSet.contentMode = UIViewContentModeScaleAspectFit;
                    view_stampSet.backgroundColor = [UIColor clearColor];
                    view_stampSet.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_stampSet];
                    view_stampSet.hidden = YES;
                    
                    //スタンプ日付追加
                    lbl_date.frame = CGRectMake(0, view_boxin.frame.size.height / 20 * 13, view_boxin.frame.size.width, 10.0f);
                    lbl_date.backgroundColor = [UIColor clearColor];
                    lbl_date.font = [UIFont fontWithName:@"Arial" size:9];
                    lbl_date.textColor = [UIColor redColor];
                    lbl_date.textAlignment = NSTextAlignmentCenter;
                    [view_boxin addSubview:lbl_date];
                    lbl_date.hidden = YES;
                    
                    //金額設定
                    lbl_money.frame = CGRectMake(view_totalBox.frame.origin.x, view_totalBox.frame.origin.y + view_totalBox.frame.size.height, SIZE_STAMP, 25.0f);
                    
                    //ボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [button setTag:count_stamp - 1];
                    [stampView addSubview:button];
                    
                    //スタンプボタンの押された時の処理（押した時）　1.手で押した時
                    [button addTarget:self action:@selector(getStampButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //スタンプボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
                    [button addTarget:self action:@selector(getStampButtonDown:) forControlEvents:UIControlEventTouchDown];
                    
                    break;
                    
                case 3:
                    
                    //スタンプカウント
                    count_stamp += 1;
                    
                    //スタンプボックス
                    view_totalBox.backgroundColor = [UIColor lightGrayColor];
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP+SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプ基本ボックス
                    img_uncheck = [UIImage imageNamed:@"icon_uncheck_stamp.png"];
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //番号設定
                    lbl_no.frame = CGRectMake(50.0f, view_boxin.frame.size.height - 25.0f, view_boxin.frame.size.width - 5.0f - 50.0f, 25.0f);
                    [view_boxin addSubview:lbl_no];
                    
                    //スタンプ配置用
                    img_stamp = [UIImage imageNamed:@"icon_checked_stamp.png"];
                    view_stampSet = [[UIImageView alloc] initWithImage:img_stamp];
                    view_stampSet.contentMode = UIViewContentModeScaleAspectFit;
                    view_stampSet.backgroundColor = [UIColor clearColor];
                    view_stampSet.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_stampSet];
                    view_stampSet.hidden = YES;
                    
                    //スタンプ日付追加
                    lbl_date.frame = CGRectMake(0, view_boxin.frame.size.height / 20 * 13, view_boxin.frame.size.width, 10.0f);
                    lbl_date.backgroundColor = [UIColor clearColor];
                    lbl_date.font = [UIFont fontWithName:@"Arial" size:9];
                    lbl_date.textColor = [UIColor redColor];
                    lbl_date.textAlignment = NSTextAlignmentCenter;
                    [view_boxin addSubview:lbl_date];
                    lbl_date.hidden = YES;
                    
                    //金額設定
                    lbl_money.frame = CGRectMake(view_totalBox.frame.origin.x, view_totalBox.frame.origin.y + view_totalBox.frame.size.height, SIZE_STAMP, 25.0f);
                    
                    //ボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [button setTag:count_stamp - 1];
                    [stampView addSubview:button];
                    
                    //スタンプボタンの押された時の処理（押した時）　1.手で押した時
                    [button addTarget:self action:@selector(getStampButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //スタンプボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
                    [button addTarget:self action:@selector(getStampButtonDown:) forControlEvents:UIControlEventTouchDown];
                    
                    break;
                    
                case 4:
                    
                    //スタンプカウント
                    count_stamp += 1;
                    
                    //スタンプボックス
                    view_totalBox.backgroundColor = [UIColor lightGrayColor];
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP * 2 + LONGITUDINAL_PADDING_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプ基本ボックス（長方形ボックス）
                    view_boxin_white = [[UIView alloc] init];
                    view_boxin_white.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin_white.backgroundColor = [UIColor whiteColor];
                    view_boxin_white.frame = CGRectMake(1, 1, SIZE_STAMP * 2 + SIDE_PADDING_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin_white];
                    img_uncheck = [UIImage imageNamed:@"icon_uncheck_stamp.png"];
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //番号設定
                    lbl_no.frame = CGRectMake(50.0f, view_boxin.frame.size.height - 25.0f, view_boxin.frame.size.width - 5.0f - 50.0f, 25.0f);
                    [view_boxin addSubview:lbl_no];
                    
                    //スタンプ配置用
                    img_stamp = [UIImage imageNamed:@"icon_checked_stamp.png"];
                    view_stampSet = [[UIImageView alloc] initWithImage:img_stamp];
                    view_stampSet.contentMode = UIViewContentModeScaleAspectFit;
                    view_stampSet.backgroundColor = [UIColor clearColor];
                    view_stampSet.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_stampSet];
                    view_stampSet.hidden = YES;
                    
                    //スタンプ日付追加
                    lbl_date.frame = CGRectMake(0, view_boxin.frame.size.height / 20 * 13, view_boxin.frame.size.width, 10.0f);
                    lbl_date.backgroundColor = [UIColor clearColor];
                    lbl_date.font = [UIFont fontWithName:@"Arial" size:9];
                    lbl_date.textColor = [UIColor redColor];
                    lbl_date.textAlignment = NSTextAlignmentCenter;
                    [view_boxin addSubview:lbl_date];
                    lbl_date.hidden = YES;
                    
                    //金額設定
                    lbl_money.frame = CGRectMake(view_totalBox.frame.origin.x, view_totalBox.frame.origin.y + view_totalBox.frame.size.height, SIZE_STAMP * 2 + SIDE_PADDING_STAMP, 25.0f);
                    
                    //ボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [button setTag:count_stamp - 1];
                    [stampView addSubview:button];
                    
                    //スタンプボタンの押された時の処理（押した時）　1.手で押した時
                    [button addTarget:self action:@selector(getStampButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //スタンプボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
                    [button addTarget:self action:@selector(getStampButtonDown:) forControlEvents:UIControlEventTouchDown];
                    
                    break;
                    
                case 5:
                    
                    //スタンプボックス
                    view_totalBox.frame = CGRectMake(column * (SIZE_STAMP+SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row * (SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP);
                    [stampView addSubview:view_totalBox];
                    
                    //スタンプ基本ボックス
                    // REPLACED BY ama 2016.10.04 START
                    //スタンプ数によるマーク変更
                    if(count_stamp <= numberStampSelected){
                        img_uncheck = [UIImage imageNamed:@"curpon_box_check.png"];
                    }else{
                        img_uncheck = [UIImage imageNamed:@"curpon_box_uncheck.png"];
                    }
                    // REPLACED BY ama 2016.10.04 END
                    view_boxin = [[UIImageView alloc] initWithImage:img_uncheck];
                    view_boxin.contentMode = UIViewContentModeScaleAspectFit;
                    view_boxin.frame = CGRectMake(1, 1, SIZE_STAMP - 2, SIZE_STAMP - 2);
                    [view_totalBox addSubview:view_boxin];
                    
                    //クーポンボタン追加
                    [button setFrame:CGRectMake(column*(SIZE_STAMP + SIDE_PADDING_STAMP) + SIDE_PADDING_STAMP, row*(SIZE_STAMP + LONGITUDINAL_PADDING_STAMP) + LONGITUDINAL_PADDING_STAMP + (row * ROW_UP_GAP_STAMP), SIZE_STAMP, SIZE_STAMP)];
                    [stampView addSubview:button];
                    
                    //クーポンボタンの押された時の処理（押した時）　1.手で押した時
                    // REPLACED BY ama 2016.10.04 START
                    //スタンプ数によるマーク変更
                    if(count_stamp <= numberStampSelected){
                        
                        switch ((i +1) / 6) {
                            case 1:
                                [button addTarget:self action:@selector(getCurponButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
                                break;
                            case 2:
                                [button addTarget:self action:@selector(getCurponButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
                                break;
                            case 3:
                                [button addTarget:self action:@selector(getCurponButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
                                break;
                            case 4:
                                [button addTarget:self action:@selector(getCurponButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
                                break;
                        }
                    }
                    // REPLACED BY ama 2016.10.04 END
                    break;
            }
            
            // REPLACED BY ama 2016.10.04 START
            // ボタンの番号変数作成
            //番号設定
            long lng_no = (i + 1) - ((i + 1)/6);
            lbl_no.backgroundColor = [UIColor clearColor];
            lbl_no.textColor = [UIColor grayColor];
            lbl_no.font = [UIFont fontWithName:FONT_TITLE_APP size:16];
            lbl_no.textAlignment = NSTextAlignmentRight;
            lbl_no.text = [NSString stringWithFormat:@"%02ld", lng_no];
            // REPLACED BY ama 2016.10.04 END
            
            // REPLACED BY ama 2016.10.04 START
            // 金額設定方法変更
            //金額追加
            if((i+1)%6 != 0){
                lbl_money.backgroundColor = [UIColor clearColor];
                lbl_money.textColor = [UIColor grayColor];
                lbl_money.font = [UIFont fontWithName:FONT_TITLE_APP size:14];
                lbl_money.textAlignment = NSTextAlignmentCenter;
                long lng_money = [[ary_stamps_money objectAtIndex:lng_no - 1] integerValue];
                if(lng_money > 0){
                    lbl_money.text = [NSString stringWithFormat:@"%ld円", lng_money];
                }
                [stampView addSubview:lbl_money];
            }
            // REPLACED BY ama 2016.10.04 END

            //スタンプの大きさによっての処理変更
            if(((i+1) % 6) != 0){
                
                if (count_stamp <= numberStampSelected) {
                    
                    //押されたスタンプ画像設定（ショート）
                    view_stampSet.hidden = NO;
                    
                    //押されたスタンプ日付
                    lbl_date.hidden = NO;
                    
                    //スタンプを押せなくする
                    [button setUserInteractionEnabled:NO];
                    
                    //スタンプ日付設定
                    if ((count_stamp - 1) < [object.stamp_date_set count] ){
                        // REPLACED BY ama 2016.09.29 START
                        // スタンプ日付が無い時の対応
                        NSString* set_date = [[object.stamp_date_set valueForKey:@"date_set"] objectAtIndex:count_stamp - 1];
                        if(![set_date isEqual:[NSNull null]] && [set_date length] > 0){
                            
                            lbl_date.text = [NSString stringWithFormat:@"%@.%@.%@",
                                             [set_date substringWithRange:NSMakeRange(0,4)],
                                             [set_date substringWithRange:NSMakeRange(5,2)],
                                             [set_date substringWithRange:NSMakeRange(8,2)]];
                        }
                        // REPLACED BY ama 2016.09.29 END
                    }
                }
            }

            //カラム計算
            if (column == 2) {
                column = 0;
                row ++;
            }else{
                column ++;
            }
 
        }
        
 
//        if (stampCount == couponObject.stamp_num) {
//            if ([[stampView viewWithTag:stampCount] isKindOfClass:[UIButton class]]) {
//                UIButton *btn = (UIButton*)[self viewWithTag:couponObject.stamp_num];
//                [btn setImage:[UIImage imageNamed:@"icon_get_stamp_selected.png"] forState:UIControlStateNormal];
//                [btn setUserInteractionEnabled:YES];
//            }
//        }
    }
}

// ボタンの押された時の処理（押した時）　1.手で押した時
- (void)getStampButtonClicked:(UIButton*)sender {
    
//    NSLog(@"count = %lu", (unsigned long)couponObject.stamp_date_set.count);
    
    if (is_beacon == NO){
        
        /*
        MPConfirmView *confirmView = (MPConfirmView*)[Utility viewInBundleWithName:@"MPConfirmView"];
        confirmView.delegate = self;
        confirmView.tagStamp = sender;
        [confirmView setData:couponObject];
        // REPLACED BY ama 2016.10.04 START
        // 必要スタンプ数の計算変更
        long amount = (long)sender.tag+1 - numberStampSelected;
        // REPLACED BY ama 2016.10.04 END
        [confirmView setAmount:amount];
        [[MPAppDelegate sharedMPAppDelegate].window addSubview:confirmView];
        */
        
    }else{
        
        _isStamp = YES;
        onButton = sender;
        // REPLACED BY ama 2016.10.04 START
        // 必要スタンプ数の計算変更
        beacon_amount = (long)sender.tag+1 - numberStampSelected;
        // REPLACED BY ama 2016.10.04 END
        //[self iBeaconStartThred];
        timeout = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(stamp_Timer) userInfo:nil repeats:NO];
        [[ProgressView sharedInstance] progressWithTitle:@"Loading..." andView:[MPTabBarViewController sharedInstance].view andDelegate:nil];
        
    }
}

#pragma mark - MPConfirmViewDelegate
- (void)getStamp:(UIButton*)tag {
    
   [[ManagerDownload sharedInstance] getDetailCouponStamp:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

// 電子スタンプ機能実装
-(void)setBeacons:(MPCouponObject*)object {
    
//    NSLog(@"stamp_devices = %@", object.stamp_devices);
    beaconCount = 0;
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]] && [object.stamp_devices count] > 0 ) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        //_beaconRegions = [NSMutableArray array];
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString* bundle_id = [bundle bundleIdentifier];
        NSLog(@"bundle_id = %@", bundle_id);
        is_beacon = YES;
//        NSLog(@"uuid = %@", object.stamp_devices[0][@"uuid"]);
        NSUUID* proximityUUID = [[NSUUID alloc] initWithUUIDString:object.stamp_devices[0][@"uuid"]];
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:bundle_id];
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            // requestAlwaysAuthorizationメソッドが利用できる場合(iOS8以上の場合)
            // 位置情報の取得許可を求めるメソッド
            [_locationManager requestWhenInUseAuthorization];
        } else {
            // requestAlwaysAuthorizationメソッドが利用できない場合(iOS8未満の場合)
            //[_locationManager startMonitoringForRegion:_beaconRegion];
            [_locationManager startRangingBeaconsInRegion:_beaconRegion];
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setup_Timer_7) userInfo:nil repeats:NO];
        }
    } else {
        // iBeaconが利用できない端末の場合
        is_beacon = NO;
        NSLog(@"iBeaconを利用できません。");
    }
}

// ボタンの押された時の処理（離した時）　2.電子スタンプ機能実装
-(void)getStampButtonDown:(UIButton*)sender {
    
    // REPRASED BY M.ama 2016.10.13 START
    // iBeacon認識させないばいい
    if(is_beacon == NO){

       [self.delegate arert_StampErr];
    }else{
        
        [NSThread detachNewThreadSelector:@selector(iBeaconStartThred)
                                 toTarget:self
                               withObject:nil];
    }
    // REPRASED BY M.ama 2016.10.13 END
}

-(void)getCurponButton1Clicked:(UIButton*)sender {
    
    //クーポン１を押した場合
    if ([self.delegate respondsToSelector:@selector(getCurponButtonClicked:)]) {
        [self.delegate getCurponButtonClicked:1];
    }
}

-(void)getCurponButton2Clicked:(UIButton*)sender {
    
    //クーポン２を押した場合
    if ([self.delegate respondsToSelector:@selector(getCurponButtonClicked:)]) {
        [self.delegate getCurponButtonClicked:2];
    }
}

-(void)getCurponButton3Clicked:(UIButton*)sender {
    
    //クーポン３を押した場合
    if ([self.delegate respondsToSelector:@selector(getCurponButtonClicked:)]) {
        [self.delegate getCurponButtonClicked:3];
    }
}

-(void)getCurponButton4Clicked:(UIButton*)sender {
    
    //クーポン４を押した場合
    if ([self.delegate respondsToSelector:@selector(getCurponButtonClicked:)]) {
        [self.delegate getCurponButtonClicked:4];
    }
}

// ユーザの位置情報の許可状態を確認するメソッド
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusDenied) {
        // ユーザが位置情報の使用を許可していない
        is_beacon = NO;
        if ( [couponObject.stamp_devices count] > 0 && is_alert == NO ){
            alertView = [[UIAlertView alloc] initWithTitle:nil message:@"「設定」画面の「プライバシー」を開いてこのアプリの「位置情報サービス」をONにしてください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else if (status == kCLAuthorizationStatusNotDetermined) {
        // ユーザが位置情報の使用を許可していない
    } else if(status == kCLAuthorizationStatusAuthorizedAlways) {
        // ユーザが位置情報の使用を常に許可している場合
    } else if(status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // ユーザが位置情報の使用を使用中のみ許可している場合
        
    }
    is_alert = YES;
}

// 領域計測が開始した場合
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    
    NSLog(@"監視開始");
}

// 指定した領域に入った場合
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    NSLog(@"指定した領域に入った");
    
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

// 指定した領域から出た場合
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region {
    
    NSLog(@"指定した領域から出た");
    
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

// 領域内にいるかどうかを確認する処理
-(void)locationManager:(CLLocationManager *)manager
     didDetermineState:(CLRegionState)state
             forRegion:(CLRegion *)region {
    
    switch (state) {
        case CLRegionStateInside:
            if([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]){
                NSLog(@"Enter %@",region.identifier);
                //Beacon の範囲内に入った時に行う処理を記述する
                //[self sendLocalNotificationForMessage:@"Already Entering"];
                NSLog(@"Beacon の範囲内に入った");
            }
            break;
            
        case CLRegionStateOutside:
        case CLRegionStateUnknown:
        default:
            break;
    }
}

// Beacon信号を検出した場合
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    if (beacons.count > 0) {
        self.nearestBeacon = beacons.firstObject;
        //self.str = [[NSString alloc] initWithFormat:@"UUID = %@ %f [m]\n", region.proximityUUID.UUIDString, self.nearestBeacon.accuracy];
        
        //if (_isStamp == YES && [stampArray[row] isEqualToString:@""] ){
        if (_isStamp == YES ){
            if ( [timeout isValid] ){
                [timeout invalidate];
            }
            if ( self.nearestBeacon.accuracy > 0.0f ){
                //[[ProgressView sharedInstance] removeHUD];
                NSLog(@"UUID = %@ major = %@ minor = %@　%f[m]", region.proximityUUID.UUIDString, [self.nearestBeacon.major stringValue], [self.nearestBeacon.minor stringValue], self.nearestBeacon.accuracy);
                
                // majorとminorを確認
                BOOL isBeacon = NO;
                for ( int i=0; i<[couponObject.stamp_devices count]; i++){
                    NSDictionary *beacon_info = couponObject.stamp_devices[i];
                    if ( [beacon_info[@"major"] integerValue] == [self.nearestBeacon.major integerValue] && [beacon_info[@"minor"] integerValue] == [self.nearestBeacon.minor integerValue] ){
                        isBeacon = YES;
                        break;
                    }
                }
                if ( isBeacon ){
                    NSString *strFromInt = [NSString stringWithFormat:@"%d",beacon_amount];

                    // RESERVED BY M.ama 2016.10.27 START
                    // 複数スタンプ選択更新
                    if(beacon_amount == 1){

                        // REPLACED BY ama 2016.10.05 START
                        // iBeacon識別追加
                        [[ManagerDownload sharedInstance] submitStamp:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponObject withCode:@"beacon_stamp" withAmount:strFromInt withUUID:region.proximityUUID.UUIDString withMajor:[self.nearestBeacon.major stringValue] withMinor:[self.nearestBeacon.minor stringValue] delegate:self];
                        // REPLACED BY ama 2016.10.05 END
                    }else{

                        [self.delegate arert_AllStamp:strFromInt UUID:region.proximityUUID.UUIDString];
                    }
                    // RESERVED BY M.ama 2016.10.27 START

                }else{
                    [[ProgressView sharedInstance] removeHUD];
                    //[self openConfirmView];
                }
                
                [_locationManager stopMonitoringForRegion:_beaconRegion];
                [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
                
            }else{
                [[ProgressView sharedInstance] removeHUD];
                //[self openConfirmView];
            }
            
        }
        _isStamp = NO;
    }
}

-(void)iBeaconStartThred {
    
    //[_locationManager startMonitoringForRegion:_beaconRegion];
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
}

-(void)stamp_Timer {
    
    //[_locationManager stopMonitoringForRegion:_beaconRegion];
    [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
    
    [[ProgressView sharedInstance] removeHUD];
    //[self openConfirmView];
    
    // INSERTED BY M.ama 2016.10.13 START
    // 手入力時のエラー表示
    [self.delegate arert_StampErr];
    // INSERTED BY M.ama 2016.10.13 END
}

-(void)setup_Timer_7 {
    
    //[_locationManager stopMonitoringForRegion:_beaconRegion];
    [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
}

-(void)openConfirmView {
    
    MPConfirmView *confirmView = (MPConfirmView*)[Utility viewInBundleWithName:@"MPConfirmView"];
    confirmView.delegate = self;
    confirmView.tagStamp = onButton;
    [confirmView setData:couponObject];
    [confirmView setAmount:beacon_amount];
    [[MPAppDelegate sharedMPAppDelegate].window addSubview:confirmView];
}

// INSERTED BY M.ama 2016.10.12 START
// クーポン件数取得用更新
- (void)setArertCurponNo:(NSString*)no {
    
    [self.delegate setArertCurpon:no];
}
// INSERTED BY M.ama 2016.10.12 END


// INSERTED BY M.ama 2016.10.27 START
// 複数スタンプ選択更新
-(void)setTotalStamp:(NSString*)uuid {

    NSString *strFromInt = [NSString stringWithFormat:@"%d",beacon_amount];

    [[ManagerDownload sharedInstance] submitStamp:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponObject withCode:@"beacon_stamp" withAmount:strFromInt withUUID:uuid withMajor:[self.nearestBeacon.major stringValue] withMinor:[self.nearestBeacon.minor stringValue] delegate:self];
}
// INSERTED BY M.ama 2016.10.27 END

@end
