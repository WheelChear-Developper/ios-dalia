//
//  MPTheSecondViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTheSecondViewController.h"
#import "MPTabBarViewController.h"
#import "MPCouponDetailViewController.h"
#import "MPUIConfigObject.h"
#import "MPNewDetailViewController.h"
#import "MPWpNewsDetailViewController.h"
#import "MPListMessageViewController.h"
#import "MPApnsDAO.h"

#define LIMIT_RECORD_MESSAGE_RECEIVED @"-1"

@interface MPTheSecondViewController ()
@end

@implementation MPTheSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴navigation表示
    [self setBasicNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    
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
    UIImage *img_toppics = [UIImage imageNamed:@"news.png"];
    CGFloat cgrange_toppics = (cornerView.frame.size.width - 20) / img_toppics.size.width;
    
    iv_toppics = [[UIImageView alloc] initWithImage:img_toppics];
    iv_toppics.contentMode = UIViewContentModeScaleAspectFit;
    iv_toppics.frame = CGRectMake(15, 15, cornerView.frame.size.width - 30, img_toppics.size.height * cgrange_toppics);
    [cornerView addSubview:iv_toppics];
    
    //テーブル追加
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 15, cornerView.frame.size.width, 0) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = false;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"MPNewHomeCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"newHomeIdentifier"];
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
    
    //ニュースデータ取得
    [[ManagerDownload sharedInstance] getListMessage:[Utility getDeviceID] withAppID:[Utility getAppID] withLimit:LIMIT_RECORD_MESSAGE_RECEIVED delegate:self];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_MESSAGES:
        {
            self.listObject  = param.listData;
            [_tableView reloadData];
            
            //テーブル高さ調整
            [self resizeTable];

            //TODO: Get default notification
            [[ManagerDownload sharedInstance] getDefaultNotification:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
        }
            break;

        case RequestType_GET_DEFAULT_NOTIFICATION:
            NSLog(@"%@",[param.listData lastObject]);
        {
            MPApnsObject *obj = [param.listData lastObject];

            long lng_notificationNo = [obj.apns_badge integerValue];
            long lng_couponNO = [obj.apns_cp integerValue];

            [MPAppDelegate sharedMPAppDelegate].totalBadge = lng_notificationNo;
            [MPAppDelegate sharedMPAppDelegate].couponBadge = lng_couponNO;

            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:lng_notificationNo];

            [[MPTabBarViewController sharedInstance] setNewsCount:lng_notificationNo - lng_couponNO];
            [[MPTabBarViewController sharedInstance] setCouponCount:lng_couponNO];
        }
            break;
            
        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listObject.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MPNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newHomeIdentifier"];
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPNewHomeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell setData:[self.listObject objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MPNewDetailViewController *newDetailVC = [[MPNewDetailViewController alloc] initWithNibName:@"MPNewDetailViewController" bundle:nil];
    [newDetailVC setData:[self.listObject objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newDetailVC animated:YES];
}

- (void)showListMessage:(UIButton*)sender {
    
    MPListMessageViewController *listMessageVC = [[MPListMessageViewController alloc] initWithNibName:@"MPListMessageViewController" bundle:nil];
    [self.navigationController pushViewController:listMessageVC animated:YES];
}

- (void)resizeTable {
    
    //テーブル高さをセルの最大値へセット
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 0);
    _tableView.frame =
    CGRectMake(_tableView.frame.origin.x,
               _tableView.frame.origin.y,
               _tableView.contentSize.width,
               MAX(_tableView.contentSize.height,
                   _tableView.bounds.size.height));

    // 情報なしの場合のメッセージ
    if(self.listObject.count == 0){

        //
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0, _tableView.frame.origin.y, cornerView.frame.size.width, 34);
        title.textAlignment = NSTextAlignmentCenter;
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextColor:[UIColor blackColor]];
        [title setFont:[UIFont fontWithName:FONT_MESSAGE_APP size:FONT_SIZE_TITLE_APP]];
        [cornerView addSubview:title];
        [title setText:@"現在、新着情報はありません。"];

        //スクロール内のVIEW幅調整
        [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + title.frame.size.height + 50)];

    }else{
        //スクロール内のVIEW幅調整
        [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + _tableView.frame.size.height + 40)];
    }

    _scr_rootview.contentSize = scr_inView.bounds.size;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
