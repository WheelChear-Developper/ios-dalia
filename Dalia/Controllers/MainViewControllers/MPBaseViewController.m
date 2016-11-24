//
//  MPBaseViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "SettingViewController.h"

#define FRAME_HEIGHT 44
#define FRAME_ORGIN 0
#define ICON_WIDTH 210
#define ICON_HEIGHT 44
#define FRAME_FOR_BACK_BUTTON CGRectMake(0, 0, 50, 44)

@interface MPBaseViewController ()
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
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
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

@end
