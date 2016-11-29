//
//  MPTermsViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTermsViewController.h"

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
    
    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];
    
    //タイトルのグラデーション
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view_title.frame.size.width, self.view_title.frame.size.height);
    gradient.colors = @[
                        (id)[UIColor colorWithRed:0.992 green:0.937 blue:0.831 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.894 green:0.820 blue:0.694 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.780 green:0.706 blue:0.576 alpha:1].CGColor
                        ];
    [self.view_title.layer addSublayer:gradient];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴navigation表示
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_setting.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    NSString *company = @"Miコーポレーション株式会社";
    NSString *appName = [NSString stringWithFormat:@"%@アプリ",[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] appName]];

    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"xxxx" withString:appName];
    termContent.text = [termContent.text stringByReplacingOccurrencesOfString:@"[companyName]" withString:company];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    _scr_rootview.delegate = nil;

    [super viewWillDisappear:animated];
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
