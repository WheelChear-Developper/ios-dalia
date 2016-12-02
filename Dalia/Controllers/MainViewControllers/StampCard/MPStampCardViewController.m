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
                [self setUpView];

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
- (void)setUpView {


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
