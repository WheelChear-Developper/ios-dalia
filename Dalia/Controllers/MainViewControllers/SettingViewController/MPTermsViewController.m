//
//  MPTermsViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/29/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTermsViewController.h"
#import "MPConfigObject.h"
#import "CustomColor.h"

@interface MPTermsViewController ()
@end

@implementation MPTermsViewController

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
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //タイトルのグラデーション
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view_title.frame.size.width, self.view_title.frame.size.height);
    gradient.colors = @[
                        (id)[UIColor colorWithRed:0.992 green:0.937 blue:0.831 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.894 green:0.820 blue:0.694 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.780 green:0.706 blue:0.576 alpha:1].CGColor
                        ];
    [self.view_title.layer addSublayer:gradient];
    
    //XIB表示のため、contentViewを非表示
    [contentView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:YES];

    NSString *company = @"Miコーポレーション株式会社";
    NSString *appName = [NSString stringWithFormat:@"%@アプリ",[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] appName]];

    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"xxxx" withString:appName];
    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"[companyName]" withString:company];
}

- (void)downloadDataSuccess:(DownloadParam *)param {
    
    listCompany = param.listData;
    
    [self updateTermCondition];
}

- (void) downloadDataFail:(DownloadParam *)param  {
    
    [self updateTermCondition];
}

- (void) updateTermCondition {
    
    NSString *company;
    if (listCompany && listCompany.count) {
        company = [[listCompany objectAtIndex:0] objectForKey:@"company"];
    } else {

        company = @"Miコーポレーション株式会社";
    }

    NSString *appName = [NSString stringWithFormat:@"%@アプリ",[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] appName]];

    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"xxxx" withString:appName];
    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"[companyName]" withString:company];
}

- (void)backButtonClicked:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
