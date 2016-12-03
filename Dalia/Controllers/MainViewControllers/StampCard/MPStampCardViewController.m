//
//  MPStampCardViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/25.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPStampCardViewController.h"

@interface MPStampCardViewController ()
@end

@implementation MPStampCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_stamp.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    // Bluetooth設定確認
    [self detectBluetooth];

    //クーポン情報取得
    [[ManagerDownload sharedInstance] getDetailCouponStamp:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    _scr_rootview.delegate = nil;

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //トップナビゲーション　クローズ
        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //ナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
        
    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //トップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - BlueToothDelegate
- (void)detectBluetooth {

    if(!bluetoothManager)
    {
        // Put on main queue so we can call UIAlertView from delegate callbacks.
        bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    [self centralManagerDidUpdateState:bluetoothManager]; // Show initial state
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {

    switch(bluetoothManager.state)
    {
        case CBCentralManagerStateResetting:
            NSLog(@"The connection with the system service was momentarily lost, update imminent.");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"The platform doesn't support Bluetooth Low Energy.");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"The app is not authorized to use Bluetooth Low Energy.");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"Bluetooth is currently powered off.");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"Bluetooth is currently powered on and available to use.");
            break;
        default:
            NSLog(@"State unknown, update imminent.");
            break;
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_DETAIL_COUPON_STAMP:
        {
            couponStampObject = (MPCouponStampObject*)[param.listData lastObject];

            if(couponStampObject == nil){



            }else{

                //スタンプ画面設定
                [self setStampView];

//                [self.delegate setStampMemberNo:couponObject.member_no];
//                [[NSUserDefaults standardUserDefaults] setObject:couponObject.member_no forKey:MEMBER_NO];

//                [self.delegate setInfomation:couponObject.stamp_condition];

            }

        }
            break;


        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

//画面のスタンプViewを追加
- (void)setStampView {


    //説明設定
    lbl_setsumei.text = couponStampObject.stamp_condition;

    if([couponStampObject.due_date length]>0){

        view_date.hidden = NO;

        //有効期限
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //タイムゾーンの指定
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
        NSDate *date = [formatter dateFromString:couponStampObject.due_date];

        NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"YYYY/MM/dd"];
        NSString* date_converted = [formatter stringFromDate:date];

        NSLog(@"date: %@",date);
        lbl_date.text = [NSString stringWithFormat:@"現在の有効期限:%@",date_converted];
    }else{

        view_date.hidden = YES;
    }

    NSArray* ary_stamp_date_set = couponStampObject.stamp_date_set;

    //スタンプ日付
    lbl_date01.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:0] objectForKey:@"date_set"]];
    lbl_date02.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:1] objectForKey:@"date_set"]];
    lbl_date03.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:2] objectForKey:@"date_set"]];
    lbl_date04.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:3] objectForKey:@"date_set"]];
    lbl_date05.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:4] objectForKey:@"date_set"]];
    lbl_date06.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:5] objectForKey:@"date_set"]];
    lbl_date07.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:6] objectForKey:@"date_set"]];
    lbl_date08.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:7] objectForKey:@"date_set"]];
    lbl_date09.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:8] objectForKey:@"date_set"]];
    lbl_date10.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:9] objectForKey:@"date_set"]];
    lbl_date11.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:10] objectForKey:@"date_set"]];
    lbl_date12.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:11] objectForKey:@"date_set"]];
    lbl_date13.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:12] objectForKey:@"date_set"]];
    lbl_date14.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:13] objectForKey:@"date_set"]];
    lbl_date15.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:14] objectForKey:@"date_set"]];
    lbl_date16.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:15] objectForKey:@"date_set"]];
    lbl_date17.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:16] objectForKey:@"date_set"]];
    lbl_date18.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:17] objectForKey:@"date_set"]];
    lbl_date19.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:18] objectForKey:@"date_set"]];
    lbl_date20.text = [self getDateType:[[ary_stamp_date_set objectAtIndex:19] objectForKey:@"date_set"]];

    //スタンプ数カウント
    numberStampSelected = 0;
    NSArray* ary_stamps = [ary_stamp_date_set mutableCopy];

    for(long l=0;l < ary_stamps.count;l++){

        NSMutableDictionary* dic_stamp = [ary_stamps objectAtIndex:l];
        NSString* ss = [dic_stamp objectForKey:@"date_set"];
        if(![ss isEqualToString:@""]){

            numberStampSelected += 1;

            switch (numberStampSelected) {
                case 1:

                    img_stamp01.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 2:

                    img_stamp02.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 3:

                    img_stamp03.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 4:

                    img_stamp04.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 5:

                    img_stamp05.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 6:

                    img_stamp06.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 7:

                    img_stamp07.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 8:

                    img_stamp08.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 9:

                    img_stamp09.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 10:

                    img_stamp10.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 11:

                    img_stamp11.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 12:

                    img_stamp12.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 13:

                    img_stamp13.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 14:

                    img_stamp14.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 15:

                    img_stamp15.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 16:

                    img_stamp16.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 17:

                    img_stamp17.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 18:

                    img_stamp18.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 19:

                    img_stamp19.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                case 20:

                    img_stamp20.image = [UIImage imageNamed:@"stampcard_mark_stamp.png"];
                    break;
                    
                default:
                    break;
            }


            NSString* tt = [dic_stamp objectForKey:@"isCoupon"];
            if([tt isEqualToString:@"0"]){

                switch (numberStampSelected) {
                    case 1:

                        img_stamp01.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 2:

                        img_stamp02.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 3:

                        img_stamp03.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 4:

                        img_stamp04.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 5:

                        img_stamp05.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 6:

                        img_stamp06.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 7:

                        img_stamp07.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 8:

                        img_stamp08.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 9:

                        img_stamp09.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 10:

                        img_stamp10.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 11:

                        img_stamp11.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 12:

                        img_stamp12.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 13:

                        img_stamp13.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 14:

                        img_stamp14.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 15:

                        img_stamp15.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 16:

                        img_stamp16.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 17:

                        img_stamp17.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 18:
                        
                        img_stamp18.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 19:
                        
                        img_stamp19.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                    case 20:
                        
                        img_stamp20.image = [UIImage imageNamed:@"stampcard_couponget.png"];
                        break;
                        
                    default:
                        break;
                }
            }

        }
    }


}

- (NSString*)getDateType:(NSString*)str_dt {

    NSString* date_converted = @"";
    if(![str_dt isEqualToString:@""]){

        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //タイムゾーンの指定
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
        NSDate *date = [formatter dateFromString:str_dt];

        NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"MM/dd"];
        date_converted = [formatter stringFromDate:date];
    }

    return date_converted;
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_stamp01:(id)sender {
}

- (IBAction)btn_stamp02:(id)sender {
}

- (IBAction)btn_stamp03:(id)sender {
}

- (IBAction)btn_stamp04:(id)sender {
}

- (IBAction)btn_stamp05:(id)sender {
}

- (IBAction)btn_stamp06:(id)sender {
}

- (IBAction)btn_stamp07:(id)sender {
}

- (IBAction)btn_stamp08:(id)sender {
}

- (IBAction)btn_stamp09:(id)sender {
}

- (IBAction)btn_stamp10:(id)sender {
}

- (IBAction)btn_stamp11:(id)sender {
}

- (IBAction)btn_stamp12:(id)sender {
}

- (IBAction)btn_stamp13:(id)sender {
}

- (IBAction)btn_stamp14:(id)sender {
}

- (IBAction)btn_stamp15:(id)sender {
}

- (IBAction)btn_stamp16:(id)sender {
}
@end
