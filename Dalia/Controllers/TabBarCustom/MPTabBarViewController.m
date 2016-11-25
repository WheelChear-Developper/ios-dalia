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

#import "MPShopObject.h"
#import "MPConfigObject.h"

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

        bt.frame = CGRectMake(i * widthBT, 0, widthBT, rect.size.height);
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
        [UIView animateWithDuration:0.5f
                              delay:0.5f
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
        [UIView animateWithDuration:0.5f
                              delay:0.5f
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

#pragma mark - Custom Navigation Set
- (void)setCustomNavigaion {

    _statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    ///////////// カスタムナビゲーション /////////////

    //カスタムナビゲーション作成
    _view_custom_navigationView = [[UIView alloc] init];
    [_view_custom_navigationView setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:245/255.0 alpha:0.95]];
    [_view_custom_navigationView setUserInteractionEnabled:YES];
    CGRect custom_frameNavigationView = _view_custom_navigationView.frame;
    custom_frameNavigationView.origin.x = FRAME_ORGIN;
    custom_frameNavigationView.origin.y = FRAME_ORGIN + _statusHeight;
    custom_frameNavigationView.size.width = self.view.frame.size.width;
    custom_frameNavigationView.size.height = FRAME_HEIGHT;
    _view_custom_navigationView.frame = custom_frameNavigationView;
    [self.view addSubview:_view_custom_navigationView];

    //カスタムナビゲーションメニューアイコン設定
    UIImage *img_custom_navigationView_back = [UIImage imageNamed:@"icon_menu.png"];
    UIImageView* iv_custom_navigationView_back = [[UIImageView alloc] initWithImage:img_custom_navigationView_back];
    iv_custom_navigationView_back.contentMode = UIViewContentModeScaleAspectFit;
    iv_custom_navigationView_back.frame = CGRectMake(10, 10, 44 - 20, _view_custom_navigationView.frame.size.height - 20);
    [_view_custom_navigationView addSubview:iv_custom_navigationView_back];

    //カスタムナビゲーションタイトル画像設定
    _iv_custom_navigationIcon = [[UIImageView alloc] initWithFrame:CGRectMake((35 + custom_frameNavigationView.size.width - ICON_WIDTH)/2, (custom_frameNavigationView.size.height - ICON_HEIGHT)/2 + 5, ICON_WIDTH - 30, ICON_HEIGHT)];
    [_iv_custom_navigationIcon setContentMode:UIViewContentModeScaleAspectFit];
    [_view_custom_navigationView addSubview:_iv_custom_navigationIcon];

    //カスタムナビゲーション　メニューオープンボタン設置
    UIImage *img_custom_config = [UIImage imageNamed:@"configuration.png"];
    _iv_custom_config = [[UIImageView alloc] initWithImage:img_custom_config];
    _iv_custom_config.contentMode = UIViewContentModeScaleAspectFit;
    _iv_custom_config.frame = CGRectMake(10, 10, 24, 24);
    [_view_custom_navigationView addSubview:_iv_custom_config];

    _btn_custom_setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn_custom_setting.frame = CGRectMake(0, 0, 44, 44);
    [_btn_custom_setting addTarget:self action:@selector(custom_open_NavigationMenu:) forControlEvents:UIControlEventTouchDown];
    [_view_custom_navigationView addSubview:_btn_custom_setting];

    //ステータスバー背景設定
    UIView* view_frameNavigationView_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _statusHeight)];
    view_frameNavigationView_shadow.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:245/255.0 alpha:1.00];
    [self.view addSubview:view_frameNavigationView_shadow];

    ///////////// サイドメニュー /////////////

    //ナビゲーションメニュー設定
    long lng_NavigationMenu_point = - self.view.frame.size.width;
    _view_NaviFrame = [[UIView alloc] initWithFrame:CGRectMake(lng_NavigationMenu_point, _statusHeight, self.view.frame.size.width, self.view.frame.size.height - _statusHeight)];
    _view_NaviFrame.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_view_NaviFrame];
    [self.view bringSubviewToFront:_view_NaviFrame];

    //ナビゲーション画面用　closeボタン設置
    UIImage *im_custom_NavigationMenu_closeButton = [UIImage imageNamed:@"customMenu_close.png"];
    UIImageView* iv_custom_NavigationMenu_closeButton = [[UIImageView alloc] initWithImage:im_custom_NavigationMenu_closeButton];
    iv_custom_NavigationMenu_closeButton.contentMode = UIViewContentModeScaleAspectFit;
    iv_custom_NavigationMenu_closeButton.frame = CGRectMake(_view_NaviFrame.frame.size.width - 10 - 24, 10, 24, 24);
    [_view_NaviFrame addSubview:iv_custom_NavigationMenu_closeButton];

    UIButton* btn_custom_btn_close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_custom_btn_close.frame = CGRectMake(_view_NaviFrame.frame.size.width - 44, 0, 44, 44);
    [btn_custom_btn_close addTarget:self action:@selector(custom_close_NavigationMenu:) forControlEvents:UIControlEventTouchDown];
    [_view_NaviFrame addSubview:btn_custom_btn_close];

    //メニュー用view
    [_view_NaviMenu removeFromSuperview];
    _view_NaviMenu = (MPSlideMenuView*)[Utility viewInBundleWithName:@"MPSlideMenuView"];
    _view_NaviMenu.delegate = self;
    _view_NaviMenu.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.88];
    [_view_NaviMenu setFrame:CGRectMake(0, 0, _view_NaviFrame.frame.size.width - 44, _view_NaviFrame.frame.size.height)];
    [_view_NaviFrame addSubview:_view_NaviMenu];

    //SwipeGestureのインスタンスを生成
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(custom_close_NavigationMenu:)];
    //スワイプの方向（右から左）
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    //self.viewにジェスチャーをのせる
    [self.view addGestureRecognizer:swipeLeftGesture];
}

- (void)setNavigationSetView:(long)count {

    //メニュー閉じる
    [self.view bringSubviewToFront:_view_NaviFrame];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = _view_NaviFrame.frame;
                         flt_navi.origin.x = - _view_NaviFrame.frame.size.width;
                         _view_NaviFrame.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック

                     }];

    //1.Home
    //2.MembersCard
    //3.Resrve
    //4.Point
    //5.Whats,New
    //6.Online Shop
    //7.Coupon
    //8.Menu
    //9.Access
    //10.Setting

    switch (count) {
        case 1:
        {
            MPHomeViewController *vc_Setting = [[MPHomeViewController alloc] initWithNibName:@"MPHomeViewController" bundle:nil];
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];

            [self selectTab:0];
        }
            break;
        case 2:
        {
            MPMembersCardViewController *vc_Setting = [[MPMembersCardViewController alloc] initWithNibName:@"MPMembersCardViewController" bundle:nil];
            vc_Setting.lng_tabNo = self.selectedIndex;
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];
        }
            break;
        case 3:
        {
            /*
             SettingViewController *vc_Setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
             UIViewController *vc = vc_Setting;
             NSMutableArray *listVC = [[NSMutableArray alloc] init];
             [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
             [self setViewControllers:listVC animated:YES];
             */
        }
            break;
        case 4:
        {
            /*
             SettingViewController *vc_Setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
             UIViewController *vc = vc_Setting;
             NSMutableArray *listVC = [[NSMutableArray alloc] init];
             [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
             [self setViewControllers:listVC animated:YES];
             */
        }
            break;
        case 5:
        {
            /*
             SettingViewController *vc_Setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
             UIViewController *vc = vc_Setting;
             NSMutableArray *listVC = [[NSMutableArray alloc] init];
             [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
             [self setViewControllers:listVC animated:YES];
             */
        }
            break;
        case 6:
        {
            /*
             SettingViewController *vc_Setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
             UIViewController *vc = vc_Setting;
             NSMutableArray *listVC = [[NSMutableArray alloc] init];
             [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
             [self setViewControllers:listVC animated:YES];
             */
        }
            break;
        case 7:
        {
            MPTheSecondViewController *vc_Setting = [[MPTheSecondViewController alloc] initWithNibName:@"MPTheSecondViewController" bundle:nil];
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];

            [self selectTab:1];
        }
            break;
        case 8:
        {
            MPTheThirdViewController *vc_Setting = [[MPTheThirdViewController alloc] initWithNibName:@"MPTheThirdViewController" bundle:nil];
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];

            [self selectTab:2];
        }
            break;
        case 9:
        {
            MPTheFourthViewController *vc_Setting = [[MPTheFourthViewController alloc] initWithNibName:@"MPTheFourthViewController" bundle:nil];
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];

            [self selectTab:3];
        }
            break;
        case 10:
        {
            MPTheFifthViewController *vc_Setting = [[MPTheFifthViewController alloc] initWithNibName:@"MPTheFifthViewController" bundle:nil];
            UIViewController *vc = vc_Setting;
            NSMutableArray *listVC = [[NSMutableArray alloc] init];
            [listVC addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
            [self setViewControllers:listVC animated:YES];
            
            [self selectTab:4];
        }
            break;
            
        default:
            break;
    }
}

- (void)setImage_CustomNavigation:(UIImage*)image {

    [_iv_custom_navigationIcon setImage:image];
}

- (void)setFadeOut_CustomNavigation:(BOOL)flg {

    if(flg){

        //閉じる場合
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _view_custom_navigationView.frame;
                             flt_navi.origin.y = - FRAME_HEIGHT;
                             _view_custom_navigationView.frame = flt_navi;

                         } completion:^(BOOL finished){

                             //完了時のコールバック
                             
                         }];

    }else{

        //開ける場合
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _view_custom_navigationView.frame;
                             flt_navi.origin.y = 20;
                             _view_custom_navigationView.frame = flt_navi;

                         } completion:^(BOOL finished){
                             
                             //完了時のコールバック
                             
                         }];
    }
}

- (void)setHidden_CustomNavigation:(BOOL)isEnable {

    _view_custom_navigationView.hidden = isEnable;
}

- (void)custom_open_NavigationMenu:(UIButton*)button {

    [self.view bringSubviewToFront:_view_NaviFrame];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = _view_NaviFrame.frame;
                         flt_navi.origin.x = 0.0f;
                         _view_NaviFrame.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック

                     }];
}

- (void)custom_close_NavigationMenu:(UIButton*)button {

    [self.view bringSubviewToFront:_view_NaviFrame];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = _view_NaviFrame.frame;
                         flt_navi.origin.x = - _view_NaviFrame.frame.size.width;
                         _view_NaviFrame.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック
                         
                     }];
}

@end
