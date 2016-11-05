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
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //
    contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor grayColor]];
    CGRect frameContentView = contentView.frame;
    frameContentView.origin.x = FRAME_ORGIN;
    frameContentView.origin.y = statusHeight;
    frameContentView.size.width = self.view.frame.size.width;
    frameContentView.size.height = self.view.frame.size.height - statusHeight;

    contentView.frame = frameContentView;
    //[ contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:contentView];
    //[contentView setBackgroundColor:[UIColor redColor]];

    //ナビゲーション作成
    [self.navigationController setNavigationBarHidden:YES];
    navigationView = [[UIImageView alloc] init];
    [navigationView setBackgroundColor:[UIColor clearColor]];
    [navigationView setUserInteractionEnabled:YES];
    [navigationView setImage:[UIImage imageNamed:@"navigation_back.png"]];
    CGRect frameNavigationView = navigationView.frame;
    frameNavigationView.origin.x = FRAME_ORGIN;
    frameNavigationView.origin.y = FRAME_ORGIN + statusHeight;
    frameNavigationView.size.width = self.view.frame.size.width;
    frameNavigationView.size.height = FRAME_HEIGHT;
    navigationView.frame = frameNavigationView;
    [self.view addSubview:navigationView];
    
    UIImageView *navigationIcon = [[UIImageView alloc] initWithFrame:CGRectMake((frameNavigationView.size.width - ICON_WIDTH)/2, (frameNavigationView.size.height - ICON_HEIGHT)/2, ICON_WIDTH, ICON_HEIGHT)];
    //[navigationIcon setImage:[UIImage imageNamed:@"navigation_icon.png"]];
    [navigationIcon setContentMode:UIViewContentModeScaleAspectFit];
    [navigationView addSubview:navigationIcon];
    
    //戻るボタン設定
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
    [navigationView addSubview:backButton];
    [self setHiddenBackButton:YES];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frameContentView.size.width, frameContentView.size.height)];
    [imageView setImage:[UIImage imageNamed:@"background.png"]];
    [contentView addSubview:imageView];

    //サイド設定ボタン設置
    UIImage *img_config = [UIImage imageNamed:@"configuration.png"];
    iv_config = [[UIImageView alloc] initWithImage:img_config];
    iv_config.contentMode = UIViewContentModeScaleAspectFit;
    iv_config.frame = CGRectMake(frameNavigationView.size.width - 24 - 10, 10 + statusHeight, 24, 24);
    [self.view addSubview:iv_config];
    iv_config.hidden = NO;
    
    btn_setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_setting.frame = CGRectMake(frameNavigationView.size.width - 44, 0, 44, 44);
    [btn_setting addTarget:self action:@selector(push_setting:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn_setting];
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
