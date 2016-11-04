//
//  MPTheFourthViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTheFourthViewController.h"
#import "MPTabBarViewController.h"
#import "MPCouponDetailViewController.h"
#import "MPUIConfigObject.h"
#import "SettingViewController.h"
// INSERTED By M.ama 2016.10.30 START
// リスト取得件数変更
#import "MPApnsDAO.h"
// INSERTED By M.ama 2016.10.30 END

#define HEIGHT_FOR_SETBIRTHDAY_FRAME 60

@interface MPTheFourthViewController ()
@end

@implementation MPTheFourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // INSERTED BY M.ama 2016.10.25 START
    // 誕生日登録による表示変更
    //３人誕生日設定フラグ
    bln_TotalBirthday = NO;
    // INSERTED BY M.ama 2016.10.25 END
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //スクロールビュー作成
    _scr_rootview = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    _scr_rootview.delegate = self;
    _scr_rootview.backgroundColor = [UIColor colorWithRed:246/255.0 green:229/255.0 blue:203/255.0 alpha:1.0];
    [_scr_rootview setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    scr_inView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 1000)];
    [_scr_rootview addSubview:scr_inView];
    _scr_rootview.contentSize = scr_inView.bounds.size;
    [contentView addSubview:_scr_rootview];
    
    cornerView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, scr_inView.frame.size.width-16, scr_inView.frame.size.height-16)];
    cornerView.backgroundColor = [UIColor whiteColor];
    cornerView.layer.cornerRadius = 8.0;
    cornerView.clipsToBounds = YES;
    [cornerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [scr_inView addSubview:cornerView];
    
    //メニュー画像追加
    UIImage *img_toppics = [UIImage imageNamed:@"coupon.png"];
    CGFloat cgrange_toppics = (cornerView.frame.size.width - 20) / img_toppics.size.width;
    
    iv_toppics = [[UIImageView alloc] initWithImage:img_toppics];
    iv_toppics.contentMode = UIViewContentModeScaleAspectFit;
    iv_toppics.frame = CGRectMake(15, 15, cornerView.frame.size.width - 30, img_toppics.size.height * cgrange_toppics);
    [cornerView addSubview:iv_toppics];

    //テーブル追加
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 10, cornerView.frame.size.width - 30, 0) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = false;
    _tableView.estimatedRowHeight = 220.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"MPCouponCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"couponIdentifier"];
    [_tableView reloadData];

    // INSERTED BY M.ama 2016.102.29 START
    // 通知件数を０にする
    [[MPTabBarViewController sharedInstance] setCouponCount:0];
    // INSERTED BY M.ama 2016.10.29 END
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
    
    //クーポンデータ取得
    [[ManagerDownload sharedInstance] getListCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)backButtonClicked:(UIButton *)sender {
    
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:0];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:0];
    [[MPTabBarViewController sharedInstance] setUpTabBar];
    [[MPTabBarViewController sharedInstance] setDisableHomeButton:YES];
}

// INSERTED BY M.ama 2016.10.25 START
// 可変テーブル用
-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
}
// INSERTED BY M.ama 2016.10.25 END

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    // REPRASED BY M.ama 2016.10.25 START
    // 誕生日登録による表示変更
    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {

            listCoupon = param.listData;
            listCouponBase = [[NSMutableArray alloc] init];
            for (MPCouponObject *obj in listCoupon) {
                if (obj.is_birthday != 1) {
                    [listCouponBase addObject:obj];
                }
            }
            dobCoupon = param.dobCoupon;
            if ([Utility checkNULL:dobCoupon]) {
                [[NSUserDefaults standardUserDefaults] setObject:[Utility checkNULL:dobCoupon] forKey:MONTH_BIRTH];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

            //ユーザー情報取得
            [[ManagerDownload sharedInstance] getMemberInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
        }
            break;

        case RequestType_GET_MEMBER_INFO:
        {
            if(param.listData.count > 0){

                memberObj = param.listData[0];

                NSString* str_hostName = memberObj.birthday;
                NSString* str_child1NAME = memberObj.child1_birthday;
                NSString* str_child2NAME = memberObj.child2_birthday;

                if(![str_hostName isEqualToString:@""]){
                    if(![str_child1NAME isEqualToString:@""]){
                        if(![str_child2NAME isEqualToString:@""]){

                            bln_TotalBirthday = YES;
                        }
                    }
                }

            }else{

                UIAlertController *alert =
                [UIAlertController alertControllerWithTitle:@"読み込みエラー"
                                                    message:@"サーバーからデータ取得できませんでした。"
                                             preferredStyle:UIAlertControllerStyleAlert];

                [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {

                                                        }]];

                [self presentViewController:alert animated:YES completion:nil];
            }

            [_tableView reloadData];

            //TODO: Get default notification
            [[ManagerDownload sharedInstance] getDefaultNotification:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
        }
            break;

        case RequestType_GET_DEFAULT_NOTIFICATION:
            NSLog(@"%@",[param.listData lastObject]);
        {

            // INSERTED By M.ama 2016.10.30 START
            // リスト取得件数変更
            MPApnsObject *obj = [param.listData lastObject];

            long lng_notificationNo = [obj.apns_badge integerValue];
            long lng_couponNO = [obj.apns_cp integerValue];

            [MPAppDelegate sharedMPAppDelegate].totalBadge = lng_notificationNo;
            [MPAppDelegate sharedMPAppDelegate].couponBadge = lng_couponNO;

            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:lng_notificationNo];

            [[MPTabBarViewController sharedInstance] setNewsCount:lng_notificationNo - lng_couponNO];
            [[MPTabBarViewController sharedInstance] setCouponCount:lng_couponNO];

            // INSERTED By M.ama 2016.10.30 END

            // INSERTED BY M.ama 2016.102.30 START
            // テーブル高さ調整
            lng_TotalHeight = 0;
            for(long l=0;l<listCouponBase.count;l++){

                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:l inSection:0];

                CGRect rectOfCellInTableView = [_tableView rectForRowAtIndexPath:indexpath];
                CGRect rectOfCellInSuperview = [_tableView convertRect:rectOfCellInTableView toView:[_tableView superview]];

                lng_TotalHeight += rectOfCellInSuperview.size.height;
            }
            
            //テーブル高さ調整
            [self resizeTable];
            // INSERTED BY M.ama 2016.102.30 END
        }
            break;

        default:
            break;
    }
    // REPRASED BY M.ama 2016.10.25 END
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            
            if (listCouponBase.count > 0) {
                return listCouponBase.count;
            }else{
                return 1;
            }
            
            break;
            
        default:
            break;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            if (listCouponBase) {
                if (listCouponBase.count > 0) {
                    MPCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponIdentifier"];
                    if (cell == nil)
                    {
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPCouponCell" owner:self options:nil];
                        cell = [nib objectAtIndex:0];
                    }
                    cell.delegate = self;
                    [cell setData:[listCouponBase objectAtIndex:indexPath.row]];
                    // cell.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.05];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return cell;
                }else{
                    static NSString *cellIdentifier = @"cellIdentifier";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        [cell setBackgroundColor:[UIColor clearColor]];
                        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
                        [cell setUserInteractionEnabled:NO];
                    }
                    [cell.textLabel setText:NO_LIST_COUPON_MESSAGE];
                    return cell;
                }
            }else{
                static NSString *cellIdentifier = @"cellIdentifier";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell setBackgroundColor:[UIColor clearColor]];
                    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
                    [cell setUserInteractionEnabled:NO];
                }
                [cell.textLabel setText:NO_LIST_COUPON_MESSAGE];
                return cell;
            }
        }
            break;

        default:
            break;
    }
    return nil;
}

- (void)resizeTable {

    // REPLACED BY M.ama 2016.10.25 START
    // 可変テーブル用変数

    //テーブル高さをセルの最大値へセット
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 0);
    _tableView.frame =
    CGRectMake(_tableView.frame.origin.x,
               _tableView.frame.origin.y,
               _tableView.contentSize.width,
               lng_TotalHeight);

    // INSERTED BY M.ama 2016.102.30 START
    // テーブル高さ調整（情報なし対応）
    [lbl_notList removeFromSuperview];
    lbl_notList = [[UILabel alloc] init];
    lbl_notList.frame = CGRectMake(0, _tableView.frame.origin.y, cornerView.frame.size.width, 34);
    lbl_notList.textAlignment = NSTextAlignmentCenter;
    [lbl_notList setBackgroundColor:[UIColor clearColor]];
    [lbl_notList setTextColor:[UIColor blackColor]];
    [lbl_notList setFont:[UIFont fontWithName:FONT_MESSAGE_APP size:FONT_SIZE_TITLE_APP]];
    [cornerView addSubview:lbl_notList];

    if(listCoupon.count == 0){

        lbl_notList.frame = CGRectMake(0, _tableView.frame.origin.y, cornerView.frame.size.width, 34);
        [lbl_notList setText:@"現在、発行されているクーポンはありません"];

    }else{
        //スクロール内のVIEW幅調整
        lbl_notList.frame = CGRectMake(0, _tableView.frame.origin.y, cornerView.frame.size.width, _tableView.frame.size.height);
        [lbl_notList setText:@""];
    }

    [birthday_backclorview removeFromSuperview];
    [birthday_title removeFromSuperview];
    [birthday_buttonView removeFromSuperview];
    [btn_Birthday removeFromSuperview];

    if(bln_TotalBirthday == NO){

        //誕生日ボタン
        birthday_backclorview = [[UIImageView alloc] init];
        birthday_backclorview.frame = CGRectMake(0, lbl_notList.frame.origin.y + lbl_notList.frame.size.height + 15, cornerView.frame.size.width, 34);
        birthday_backclorview.backgroundColor = [UIColor colorWithRed:241/255.0 green:150/255.0 blue:1/255.0 alpha:1.0];
        [cornerView addSubview:birthday_backclorview];

        birthday_title = [[UILabel alloc] init];
        birthday_title.frame = CGRectMake(0, 0, cornerView.frame.size.width, 34);
        birthday_title.textAlignment = NSTextAlignmentCenter;
        [birthday_title setBackgroundColor:[UIColor clearColor]];
        [birthday_title setTextColor:[UIColor whiteColor]];
        [birthday_title setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
        [birthday_backclorview addSubview:birthday_title];
        [birthday_title setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab2] objectForKey:@"titleHeaderBirthday"]];

        birthday_img_toppics = [UIImage imageNamed:@"button_BirthdaySet.png"];
        birthday_buttonView = [[UIImageView alloc] initWithImage:birthday_img_toppics];
        birthday_buttonView.contentMode = UIViewContentModeScaleAspectFit;
        birthday_buttonView.frame = CGRectMake(30, birthday_backclorview.frame.origin.y + birthday_backclorview.frame.size.height + 15, cornerView.frame.size.width - 60, 50);
        [cornerView addSubview:birthday_buttonView];

        btn_Birthday = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn_Birthday.frame = birthday_buttonView.frame ;
        [btn_Birthday addTarget:self action:@selector(setBirthDay) forControlEvents:UIControlEventTouchUpInside];
        [cornerView addSubview:btn_Birthday];

        //スクロール内のVIEW幅調整
        [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 15 + lbl_notList.frame.size.height + birthday_title.frame.size.height + 10 + 10 + 90)];

    }else{

        //スクロール内のVIEW幅調整
        [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 15 + lbl_notList.frame.size.height + 10 + 10 + 5)];
    }
    // INSERTED BY M.ama 2016.102.30 END

    _scr_rootview.contentSize = scr_inView.bounds.size;
    // REPLACED BY M.ama 2016.10.25 END
}

#pragma mark - MPCouponCellDelegate
- (void)useCoupon:(MPCouponObject *)object {
    
    NSLog(@"use coupon:%@",object.coupon_name);
    couponUse = object;
    if (couponUse.limit_num <= 0) {
        
        // REPLACED BY M.ama 2016.10.09 START
        // 無制限クーポン時、直接クーポン表示変更
        [self detailCoupon];
        // REPLACED BY M.ama 2016.10.09 END
    }else{
        
        MPAlertView *alertView = (MPAlertView*) [Utility viewInBundleWithName:@"MPAlertView"];
        //        [alertView setDelegate:self];
        [alertView setData:object.limit_num];
        [alertView.btnOK addTarget:self action:@selector(detailCoupon:) forControlEvents:UIControlEventTouchUpInside];
        [[MPAppDelegate sharedMPAppDelegate].window addSubview:alertView];
    }
}

- (void)detailCoupon {
    
    MPCouponDetailViewController *couponDetailVC = [[MPCouponDetailViewController alloc] initWithNibName:@"MPCouponDetailViewController" bundle:nil];
    [self.navigationController pushViewController:couponDetailVC animated:YES];
    [couponDetailVC setData:couponUse];
    
    [[ManagerDownload sharedInstance] submitUseCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponUse delegate:nil];
    couponUse = nil;
}

#pragma mark - MPAlertViewDelegate
- (void)detailCoupon:(UIButton*)sender {
    
    [sender.superview.superview removeFromSuperview];

    MPCouponDetailViewController *couponDetailVC = [[MPCouponDetailViewController alloc] initWithNibName:@"MPCouponDetailViewController" bundle:nil];
    [self.navigationController pushViewController:couponDetailVC animated:YES];
    [couponDetailVC setData:couponUse];
    
    [[ManagerDownload sharedInstance] submitUseCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponUse delegate:nil];
    couponUse = nil;
}

- (void)setBirthDay {
    
    // REPLACED BY ama 2016.10.04 START
    //プロフィール画面へ遷移
    UserSettingViewController *transVC = [[UserSettingViewController alloc] initWithNibName:@"UserSettingViewController" bundle:nil];
    [self.navigationController pushViewController:transVC animated:YES];
    // REPLACED BY ama 2016.10.04 START
}

#pragma mark - PickerDatetime
- (void)updateDateTime:(NSDate *)date withType:(MISE_PROCESS_DATE_TYPE )type {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SET_BIRTHDAY_USER_DEFAULT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@",[Utility formatDateToString:date]);
    [[NSUserDefaults standardUserDefaults] setObject:[[[Utility formatDateToString:date] componentsSeparatedByString:@"-"] objectAtIndex:1] forKey:MONTH_BIRTH];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[ManagerDownload sharedInstance] submitBirthDay:[Utility getDeviceID] withAppID:[Utility getAppID] withBirthday:[Utility formatDateToString:date] delegate:nil];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
