//
//  MPTabBarViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTabBarViewController.h"
#import "MPHomeViewController.h"
#import "MPTheSecondViewController.h"
#import "MPTheThirdViewController.h"
#import "MPTheFourthViewController.h"
#import "MPTheFifthViewController.h"
#import "MPMembersCardViewController.h"
#import "MPStampCardViewController.h"

#import "MPShopObject.h"
#import "MPConfigObject.h"
#import "MPReservationViewController.h"

#define SIZE_BADGE_NUMBER 25

@interface MPTabBarViewController ()
@end

@implementation MPTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _listButton = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    if (!_firstTimeRun) {
        [self customTabBar];
        _firstTimeRun = YES;
    }
}

- (void)dealloc {

    _listButton = nil;
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    [self setUpTabBar];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - Singleton Mothod
+ (MPTabBarViewController *)sharedInstance {
    
    static dispatch_once_t onceToken;
    static MPTabBarViewController *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[MPTabBarViewController alloc] init];
        }
    });
    
    return sharedInstance;
}

#pragma mark - Custom TabBar
- (void)customTabBar {

    [self.tabBar setHidden:YES];
    CGRect rect = self.tabBar.frame;
    rect.size.height = 50;
    _bgTabBar = [[UIImageView alloc] initWithFrame:rect];
    [_bgTabBar setTag:1111];
    [_bgTabBar setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:245/255.0 alpha:0.95]];
    [_bgTabBar setUserInteractionEnabled:YES];
    float widthBT = rect.size.width / _numberTab;
    for (int i = 0; i < _numberTab; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor clearColor]];

        NSString *urlImageNomal = @"";
        NSString *urlImageSelected = @"";

        switch (i) {

            case 0:{
                urlImageNomal = @"footer_btn_home.png";
                urlImageSelected = @"footer_btn_home_on.png";
                break;
            }

            case 1:{
                urlImageNomal = @"footer_btn_coupon.png";
                urlImageSelected = @"footer_btn_coupon_on.png";
                break;
            }

            case 2:{
                urlImageNomal = @"footer_btn_menu.png";
                urlImageSelected = @"footer_btn_menu_on.png";
                break;
            }

            case 3:{
                urlImageNomal = @"footer_btn_access.png";
                urlImageSelected = @"footer_btn_access_on.png";
                break;
            }

            case 4:{
                urlImageNomal = @"footer_btn_setting.png";
                urlImageSelected = @"footer_btn_setting_on.png";
                break;
            }

            default:
                break;
        }

        bt.frame = CGRectMake(5 + i * widthBT, 5, widthBT - 10, rect.size.height - 10);
        [bt setTag:i];
        [bt setBackgroundImage:[UIImage imageNamed:urlImageNomal] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:urlImageSelected] forState:UIControlStateHighlighted];
        [bt setBackgroundImage:[UIImage imageNamed:urlImageSelected] forState:UIControlStateSelected];

        [bt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_bgTabBar addSubview:bt];
        [_listButton addObject:bt];

        //カスタムナビゲーション　メニューオープンボタン設置
        if(i == 1){

            UIImage *img_notification = [UIImage imageNamed:@"new_badge.png"];
            _imv_notification = [[UIImageView alloc] initWithImage:img_notification];
            _imv_notification.contentMode = UIViewContentModeScaleAspectFit;
            _imv_notification.frame = CGRectMake(10 + rect.size.width / 5 * i, 10, 5, 5);
            [_bgTabBar addSubview:_imv_notification];
            _imv_notification.hidden = YES;
        }
    }
    [self.view addSubview:_bgTabBar];
    
    [self selectTab:0];
}

- (void)buttonClicked:(UIButton*)sender {

    NSLog(@"TagNo_%d",sender.tag);
/*
    if (sender.tag != 3) {
        [self setUpTabBar];
    }
    if (sender.tag == 0) {

        //[[ManagerDownload sharedInstance] getListShop:[Utility getAppID] delegate:self];

        [self setDisableHomeButton:YES];

    }else if(sender.tag == 1){
        [MPAppDelegate sharedMPAppDelegate].totalBadge -= [MPAppDelegate sharedMPAppDelegate].couponBadge;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MPAppDelegate sharedMPAppDelegate].totalBadge];
    }else if(sender.tag == 3){
        //        [[ManagerDownload sharedInstance] getListShop:[Utility getAppID] delegate:self];
        //[self setUpTabBar];
    }
 */
    long tagNum = [sender tag];

    [self selectTab:tagNum];
}

#pragma mark - Setup Tabar
- (void)setUpTabBar {
    
    UIViewController *vc = nil;
    NSMutableArray *listVC = [[NSMutableArray alloc] init];
    
    _numberTab = 5;
    
    for (int i = 0; i < _numberTab; i ++) {
        switch (i) {
            case 0:
            {
                MPHomeViewController *homeVC = [[MPHomeViewController alloc] initWithNibName:@"MPHomeViewController" bundle:nil];
                vc = homeVC;
            }
                break;
                
            case 1:
            {
                MPTheSecondViewController *theSecondVC = [[MPTheSecondViewController alloc] initWithNibName:@"MPTheSecondViewController" bundle:nil];
                vc = theSecondVC;
            }
                break;
                
            case 2:
            {
                MPTheThirdViewController *theThirdVC = [[MPTheThirdViewController alloc] initWithNibName:@"MPTheThirdViewController" bundle:nil];
                vc = theThirdVC;
            }
                break;
                
            case 3:
            {

                MPTheFourthViewController *theFourthVC = [[MPTheFourthViewController alloc] initWithNibName:@"MPTheFourthViewController" bundle:nil];
                vc = theFourthVC;
            }
                break;
                
            case 4:
            {
                MPTheFifthViewController *theFifthVC = [[MPTheFifthViewController alloc] initWithNibName:@"MPTheFifthViewController" bundle:nil];
                vc = theFifthVC;
            }
                break;
                
            default:
                break;
        }
        
        if (vc) {
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            vc = nil;
        }
    }
    
    [self setViewControllers:listVC animated:YES];
}

- (void)setTabViewIndex:(long)tabID {

    self.selectedIndex = tabID;

    [self selectTab:tabID];

}

- (void)selectTab:(long)tabID {

    for (UIButton *bt in _listButton) {
        if (bt.tag == tabID) {

            [bt setSelected:YES];

        }else{

            [bt setSelected:NO];
        }
    }
    self.selectedIndex = tabID;
}

- (void)setFadeOut_Tab:(BOOL)flg {

    if(flg){

        //閉じる場合
        [UIView animateWithDuration:0.1f
                              delay:0.1f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _bgTabBar.frame;
                             flt_navi.origin.y = self.view.frame.size.height;
                             _bgTabBar.frame = flt_navi;

                         } completion:^(BOOL finished){

                             //完了時のコールバック

                         }];

    }else{

        //開ける場合
        [UIView animateWithDuration:0.1f
                              delay:0.1f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _bgTabBar.frame;
                             flt_navi.origin.y = self.view.frame.size.height - 50;
                             _bgTabBar.frame = flt_navi;

                         } completion:^(BOOL finished){
                             
                             //完了時のコールバック
                             
                         }];
    }
}

- (void)setHidden_Tab:(BOOL)isEnable {

    _bgTabBar.hidden = isEnable;
}

- (void)setTabNotificationHidden:(BOOL)isEnable {

    _imv_notification.hidden = isEnable;
}

- (void)setDisableHomeButton:(BOOL)isEnable {

    UIView *specialView = [[self.view viewWithTag:1111] viewWithTag:0];
    if ([specialView isKindOfClass:[UIButton class]]) {
        if (isEnable) {
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"footer_btn_home_on.png"] forState:UIControlStateSelected];
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"footer_btn_home_on.png"] forState:UIControlStateHighlighted];
        }else{
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"footer_btn_home.png"] forState:UIControlStateSelected];
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"footer_btn_home.png"] forState:UIControlStateHighlighted];
        }
    }
}


@end
