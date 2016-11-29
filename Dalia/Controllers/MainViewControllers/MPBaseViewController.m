//
//  MPBaseViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"

#import "MPSlideMenuView.h"
#import "MPHomeViewController.h"
#import "MPTheSecondViewController.h"
#import "MPTheThirdViewController.h"
#import "MPTheFourthViewController.h"
#import "MPTheFifthViewController.h"

#define FRAME_HEIGHT 44
#define FRAME_ORGIN 0
#define ICON_WIDTH 210
#define ICON_HEIGHT 44
#define FRAME_FOR_BACK_BUTTON CGRectMake(0, 0, 50, 44)

@interface MPBaseViewController () <MPSlideMenuViewDelegate>
{
    MPSlideMenuView* _view_NaviMenu;
}
@end

@implementation MPBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//hidden status bar
- (BOOL)prefersStatusBarHidden {

    return YES;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    //DeviceID Deploygateへ通知
    DGSLog(@"(log By M.ama) DeviceID : %@", [Utility getDeviceID]);

    [self setUpView];

    [self setCustomNavigaion];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //カスタムトップナビゲーション　オープン
    [self setFadeOut_CustomNavigation:false];

    //タブのオープン
    [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)setUpView {

    //ステータスバー表示設定
    statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.view.backgroundColor = [UIColor blackColor];

    //基本ビュー作成（基本ビューとなる部分）
    _contentView = [[UIView alloc] init];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    CGRect frameContentView = _contentView.frame;
    frameContentView.origin.x = FRAME_ORGIN;
    frameContentView.origin.y = _basic_navigationView.frame.size.height + statusHeight;
    frameContentView.size.width = self.view.frame.size.width;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frameContentView.size.height = self.view.frame.size.height - _basic_navigationView.frame.size.height*2.1 - statusHeight;
    }else{
        frameContentView.size.height = self.view.frame.size.height - _basic_navigationView.frame.size.height - statusHeight;
    }
    _contentView.frame = frameContentView;
    [self.view addSubview:_contentView];

    //基本ナビゲーション作成
    [self.navigationController setNavigationBarHidden:YES];
    _basic_navigationView = [[UIImageView alloc] init];
    [_basic_navigationView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.95]];
    [_basic_navigationView setUserInteractionEnabled:YES];
//    [basic_navigationView setImage:[UIImage imageNamed:@"basic_navigation_back.png"]];
    CGRect basic_frameNavigationView = _basic_navigationView.frame;
    basic_frameNavigationView.origin.x = FRAME_ORGIN;
    basic_frameNavigationView.origin.y = FRAME_ORGIN + statusHeight;
    basic_frameNavigationView.size.width = self.view.frame.size.width;
    basic_frameNavigationView.size.height = FRAME_HEIGHT;
    _basic_navigationView.frame = basic_frameNavigationView;
    [self.view addSubview:_basic_navigationView];

    _basic_navigationIcon = [[UIImageView alloc] initWithFrame:CGRectMake((35 + _basic_navigationView.frame.size.width - ICON_WIDTH)/2, (_basic_navigationView.frame.size.height - ICON_HEIGHT)/2 + 5, ICON_WIDTH - 30, ICON_HEIGHT)];
    [_basic_navigationIcon setContentMode:UIViewContentModeScaleAspectFit];
    [_basic_navigationView addSubview:_basic_navigationIcon];

    //基本　戻るボタン設定
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:FRAME_FOR_BACK_BUTTON];

    UIView * button_BaseView = [[UIView alloc] initWithFrame:FRAME_FOR_BACK_BUTTON];
    [button_BaseView setUserInteractionEnabled:NO];

    UIImage *img_normal_back = [UIImage imageNamed:@"left_yajirushi.png"];
    UIImageView* iv_normal_back = [[UIImageView alloc] initWithImage:img_normal_back];
    iv_normal_back.contentMode = UIViewContentModeScaleAspectFit;
    iv_normal_back.frame = CGRectMake(10, 10, 24, 24);
    [_backButton addSubview:iv_normal_back];

    [_backButton setBackgroundColor:[UIColor clearColor]];
    [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_backButton addSubview:button_BaseView];
    [_basic_navigationView addSubview:_backButton];
    [self setHiddenBackButton:YES];

    //ステータスバー背景設定
    UIView* view_frameNavigationView_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height)];
    view_frameNavigationView_shadow.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:245/255.0 alpha:1.00];
    [self.view addSubview:view_frameNavigationView_shadow];
}

- (void)getTaskWithFunctions:(ElevenFunctionType)type {
}

- (void)backButtonClicked:(UIButton*)sender {
}

- (void)setHiddenBackButton:(BOOL)isHidden {

    [_backButton setHidden:isHidden];
}

-(void)setImage_BasicNavigation:(UIImage*)image {

    [_basic_navigationIcon setImage:image];
}

- (void)setFadeOut_BasicNavigation:(BOOL)isEnable {

    if(isEnable){

        //閉じる場合
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _basic_navigationView.frame;
                             flt_navi.origin.y = - FRAME_HEIGHT;
                             _basic_navigationView.frame = flt_navi;

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
                             CGRect flt_navi = _basic_navigationView.frame;
                             flt_navi.origin.y = 20;
                             _basic_navigationView.frame = flt_navi;

                         } completion:^(BOOL finished){
                             
                             //完了時のコールバック
                             
                         }];
    }
}

- (void)setHidden_BasicNavigation:(BOOL)isEnable {

    _basic_navigationView.hidden = isEnable;

    if(isEnable){

        //基本ステータスバーが無い場合の制御
        CGRect flt_contentView = _contentView.frame;
        flt_contentView.origin.y = 0;
        flt_contentView.size.height = flt_contentView.size.height + statusHeight;
        _contentView.frame = flt_contentView;
    }else{

        //基本ステータスバーが有る場合の制御
        CGRect flt_contentView = _contentView.frame;
        flt_contentView.origin.y = _basic_navigationView.frame.size.height;
        flt_contentView.size.height = flt_contentView.size.height - _basic_navigationView.frame.size.height;
        _contentView.frame = flt_contentView;
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
    UIImage* img_custom_config = [UIImage imageNamed:@"configuration.png"];
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
    _view_NaviMenu = (MPSlideMenuView*)[Utility viewInBundleWithName:@"MPSlideMenuView"];
    _view_NaviMenu.delegate = self;
    _view_NaviMenu.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.88];
    [_view_NaviMenu setFrame:CGRectMake(0, 0, _view_NaviFrame.frame.size.width - 44, _view_NaviFrame.frame.size.height)];
    [_view_NaviFrame addSubview:_view_NaviMenu];
    _view_NaviMenu.hidden = YES;

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
            MPHomeViewController *vc = [[MPHomeViewController alloc] initWithNibName:@"MPHomeViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

            [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:0];
        }
            break;
        case 2:
        {
            MPMembersCardViewController *vc = [[MPMembersCardViewController alloc] initWithNibName:@"MPMembersCardViewController" bundle:nil];
//            vc_Setting.lng_tabNo = self.selectedIndex;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            MPReservationViewController *vc= [[MPReservationViewController alloc] initWithNibName:@"MPReservationViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            /*
             MPReservationViewController *vc= [[MPReservationViewController alloc] initWithNibName:@"MPReservationViewController" bundle:nil];
             [self.navigationController pushViewController:vc animated:YES];
             */
        }
            break;
        case 5:
        {
            /*
             MPReservationViewController *vc= [[MPReservationViewController alloc] initWithNibName:@"MPReservationViewController" bundle:nil];
             [self.navigationController pushViewController:vc animated:YES];
             */
        }
            break;
        case 6:
        {
            /*
             MPReservationViewController *vc= [[MPReservationViewController alloc] initWithNibName:@"MPReservationViewController" bundle:nil];
             [self.navigationController pushViewController:vc animated:YES];
             */
        }
            break;
        case 7:
        {
            MPTheSecondViewController *vc = [[MPTheSecondViewController alloc] initWithNibName:@"MPTheSecondViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

            [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:1];
        }
            break;
        case 8:
        {
            MPTheThirdViewController *vc = [[MPTheThirdViewController alloc] initWithNibName:@"MPTheThirdViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

            [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:2];
        }
            break;
        case 9:
        {
            MPTheFourthViewController *vc = [[MPTheFourthViewController alloc] initWithNibName:@"MPTheFourthViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

            [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];
        }
            break;
        case 10:
        {
            MPTheFifthViewController *vc = [[MPTheFifthViewController alloc] initWithNibName:@"MPTheFifthViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

            [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:4];
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

    _view_NaviMenu.hidden = NO;
    _iv_custom_config.hidden = NO;

    //カスタムナビゲーションのオープン
    [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

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

    _view_NaviMenu.hidden = YES;
    _iv_custom_config.hidden = YES;

    //カスタムナビゲーションのクローズ
    [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

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
