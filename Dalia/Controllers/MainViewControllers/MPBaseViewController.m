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

    [self setUpView];
}

- (void)setUpView {

    //ステータスバー表示設定
    statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //基本ビュー作成（基本ビューとなる部分）
    contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    CGRect frameContentView = contentView.frame;
    frameContentView.origin.x = FRAME_ORGIN;
    frameContentView.origin.y = basic_navigationView.frame.size.height + statusHeight;
    frameContentView.size.width = self.view.frame.size.width;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frameContentView.size.height = self.view.frame.size.height - basic_navigationView.frame.size.height*2.1 - statusHeight;
    }else{
        frameContentView.size.height = self.view.frame.size.height - basic_navigationView.frame.size.height - statusHeight;
    }
    contentView.frame = frameContentView;
    [self.view addSubview:contentView];

    //基本ビューの背景画像設定
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frameContentView.size.width, frameContentView.size.height)];
//    [imageView setImage:[UIImage imageNamed:@"background.png"]];
//    [contentView addSubview:imageView];

    //基本ナビゲーション作成
    [self.navigationController setNavigationBarHidden:YES];
    basic_navigationView = [[UIImageView alloc] init];
    [basic_navigationView setBackgroundColor:[UIColor whiteColor]];
    [basic_navigationView setUserInteractionEnabled:YES];
//    [basic_navigationView setImage:[UIImage imageNamed:@"basic_navigation_back.png"]];
    CGRect basic_frameNavigationView = basic_navigationView.frame;
    basic_frameNavigationView.origin.x = FRAME_ORGIN;
    basic_frameNavigationView.origin.y = FRAME_ORGIN + statusHeight;
    basic_frameNavigationView.size.width = self.view.frame.size.width;
    basic_frameNavigationView.size.height = FRAME_HEIGHT;
    basic_navigationView.frame = basic_frameNavigationView;
    [self.view addSubview:basic_navigationView];

    UIImageView *basic_navigationIcon = [[UIImageView alloc] initWithFrame:CGRectMake((basic_frameNavigationView.size.width - ICON_WIDTH)/2, (basic_frameNavigationView.size.height - ICON_HEIGHT)/2, ICON_WIDTH, ICON_HEIGHT)];
//    [basic_navigationIcon setImage:[UIImage imageNamed:@"navigation_icon.png"]];
    [basic_navigationIcon setContentMode:UIViewContentModeScaleAspectFit];
    [basic_navigationView addSubview:basic_navigationIcon];

    //基本　戻るボタン設定
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:FRAME_FOR_BACK_BUTTON];

    UIView * button_BaseView = [[UIView alloc] initWithFrame:FRAME_FOR_BACK_BUTTON];
    [button_BaseView setUserInteractionEnabled:NO];

    UIImageView *button_imageview = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 18, 18)];
    button_imageview.image = [UIImage imageNamed:@"button_leftback.png"];
    [button_BaseView addSubview:button_imageview];

    UILabel *back_title = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 30, 44)];
    back_title.text = @"戻る";
    back_title.font = [UIFont fontWithName:@"AppleGothic" size:14];
    back_title.textColor = [UIColor whiteColor];
    [button_BaseView addSubview:back_title];

    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addSubview:button_BaseView];
    [basic_navigationView addSubview:backButton];
    [self setHiddenBackButton:YES];

    //基本　サイド設定ボタン設置
    UIImage *img_config = [UIImage imageNamed:@"configuration.png"];
    iv_config = [[UIImageView alloc] initWithImage:img_config];
    iv_config.contentMode = UIViewContentModeScaleAspectFit;
    iv_config.frame = CGRectMake(basic_frameNavigationView.size.width - 24 - 10, 10, 24, 24);
    [basic_navigationView addSubview:iv_config];
    iv_config.hidden = NO;

    btn_setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_setting.frame = CGRectMake(basic_frameNavigationView.size.width - 44, 0, 44, 44);
    [btn_setting addTarget:self action:@selector(push_setting:) forControlEvents:UIControlEventTouchDown];
    [basic_navigationView addSubview:btn_setting];
    btn_setting.hidden = NO;
}

- (void)backButtonClicked:(UIButton*)sender {
}

- (void)getTaskWithFunctions:(ElevenFunctionType)type {
}

- (void)setHiddenBackButton:(BOOL)isHidden {

    [backButton setHidden:isHidden];
}

- (void)setHiddenSettingButton:(BOOL)isEnable  {

    iv_config.hidden = isEnable;
    btn_setting.hidden = isEnable;
}

- (void)push_setting:(UIButton*)button {

    SettingViewController *transVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:transVC animated:YES];
}

- (void)setBasicNavigationHiden:(BOOL)isEnable {

    basic_navigationView.hidden = isEnable;

    if(isEnable){

        //基本ステータスバーが無い場合の制御
        CGRect flt_contentView = contentView.frame;
        flt_contentView.origin.y = 0;
        flt_contentView.size.height = flt_contentView.size.height + statusHeight;
        contentView.frame = flt_contentView;
    }else{

        //基本ステータスバーが有る場合の制御
        CGRect flt_contentView = contentView.frame;
        flt_contentView.origin.y = basic_navigationView.frame.size.height;
        flt_contentView.size.height = flt_contentView.size.height - basic_navigationView.frame.size.height;
        contentView.frame = flt_contentView;
    }
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end
