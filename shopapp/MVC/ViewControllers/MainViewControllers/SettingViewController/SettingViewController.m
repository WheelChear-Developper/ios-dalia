//
//  SettingViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "SettingViewController.h"
#import "MPTermsViewController.h"
#import "MPTabBarViewController.h"
#import "MPConfigObject.h"
#import "CustomColor.h"
#import "MPTransferViewController.h"

@interface SettingViewController ()
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];


    //ステータスバー表示設定
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect frameContentView = contentView.frame;
    frameContentView.origin.y = contentView.frame.origin.y + statusHeight;
    frameContentView.size.height = contentView.frame.size.height - statusHeight;
    contentView.frame = frameContentView;

    //タイトルのグラデーション
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view_title.frame.size.width, self.view_title.frame.size.height);
    gradient.colors = @[
                        (id)[UIColor colorWithRed:0.992 green:0.937 blue:0.831 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.894 green:0.820 blue:0.694 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.780 green:0.706 blue:0.576 alpha:1].CGColor
                        ];
    [self.view_title.layer addSublayer:gradient];
    
    versionLabel.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    //XIB表示のため、contentViewを非表示
    [contentView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:YES];
    
    if ([[MPAppDelegate sharedMPAppDelegate].enableNotificationString isEqualToString:@"1"]) {
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"on_button.png"] forState:UIControlStateNormal];
    }else{
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"off_button.png"] forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (IBAction)onOffButtonClicked:(UIButton *)sender {
    
    touchCount ++;
    if (touchCount % 2 ==0) {
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"on_button.png"] forState:UIControlStateNormal];
        [MPAppDelegate sharedMPAppDelegate].enableNotificationString = @"1";
        
    }else{
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"off_button.png"] forState:UIControlStateNormal];
        [MPAppDelegate sharedMPAppDelegate].enableNotificationString = @"0";
    }
    
   [[ManagerDownload sharedInstance] enableNotificationToDevice:[Utility getDeviceID] withAppID:[Utility getAppID] withReceived:[MPAppDelegate sharedMPAppDelegate].enableNotificationString delegate:self];
}

- (IBAction)readTermsButtonClicked:(UIButton *)sender {
    
    MPTermsViewController *termsVC = [[MPTermsViewController alloc] initWithNibName:@"MPTermsViewController" bundle:nil];
    [self.navigationController pushViewController:termsVC animated:YES];
}

- (IBAction)stumTransferButtonClicked:(UIButton *)sender {
    
    MPTransferViewController *transVC = [[MPTransferViewController alloc] initWithNibName:@"MPTransferViewController" bundle:nil];
    [self.navigationController pushViewController:transVC animated:YES];
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)btn_userset:(id)sender {
    
    UserSettingViewController *transVC = [[UserSettingViewController alloc] initWithNibName:@"UserSettingViewController" bundle:nil];
    [self.navigationController pushViewController:transVC animated:YES];
}

@end
