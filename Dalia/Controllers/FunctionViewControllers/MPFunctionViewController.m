//
//  MPFunctionViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPFunctionViewController.h"
#import "MPTabBarViewController.h"
#import "MPFunctionViewController+WebViewBottomBar.h"

@interface MPFunctionViewController ()
@end

@implementation MPFunctionViewController

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
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bg.png"]];
    [view setFrame:CGRectMake(0, 0, 320, 32)];
    UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
    CGRect titleFrame = title.frame;
    titleFrame.origin.x = TITLE_HEADER_LEFT;
    titleFrame.size.width = 320;
    titleFrame.size.height = 21;
    titleFrame.origin.y = (view.frame.size.height - titleFrame.size.height)/2;
    title.frame = titleFrame;
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    
    [view addSubview:title];
    NSLog(@"type function: %ld",(long)functionType);
    [contentView addSubview:view];

    UILabel* label_member_no;
    
    switch (functionType) {
        case ElevenFunctionType_1:
        {
            [title setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function1"] objectForKey:@"titleHeader"]];
        }
            break;
            
        case ElevenFunctionType_2:
        {
/*
            //来店スタンプ
            label_member_no =  [[UILabel alloc] initWithFrame:CGRectMake(240.0f, 0.0f, 70.0f, 32.0f)];
            label_member_no.textAlignment = NSTextAlignmentRight;
            label_member_no.textColor = [UIColor whiteColor];
            [label_member_no setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
            NSString *member_no = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_NO];
            if ( [member_no length] > 0 ){
                label_member_no.text = [NSString stringWithFormat:@"No.%@", member_no];
            }
            
            [title setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function2"] objectForKey:@"titleHeader"]];
            MPCouponStampView *couponStampView = (MPCouponStampView*)[Utility viewInBundleWithName:@"MPCouponStampView"];
            couponStampView.delegate = self;
            [couponStampView setFrame:CGRectMake(5, view.frame.size.height +5, 310, contentView.frame.size.height - view.frame.size.height -10)];
            [contentView addSubview:couponStampView];
            [contentView bringSubviewToFront:couponStampView];
 */
        }
            break;
            
        case ElevenFunctionType_3:
        {
            //ホームページ
/*
            [title setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function3"] objectForKey:@"titleHeader"]];
             webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 320, contentView.frame.size.height - view.frame.size.height)];
            [webView setBackgroundColor:[UIColor clearColor]];
            [webView setScalesPageToFit:YES];
            [contentView addSubview:webView];
            [contentView bringSubviewToFront:webView];
            
            [[ManagerDownload sharedInstance] getLink:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
            [self addBottomBar];
 */
        }
            break;
            
        case ElevenFunctionType_4:
        {
            //友人の紹介
/*
            [title setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function4"] objectForKey:@"titleHeader"]];
            MPCouponShareView *couponShareView = (MPCouponShareView*)[Utility viewInBundleWithName:@"MPCouponShareView"];
            couponShareView.delegate = self;
            [couponShareView setFrame:CGRectMake(0, view.frame.size.height, 320, contentView.frame.size.height - view.frame.size.height)];
            [contentView addSubview:couponShareView];
            [contentView bringSubviewToFront:couponShareView];
 */
        }
            break;
            
        case ElevenFunctionType_5:
        {

        }
            break;
            
        case ElevenFunctionType_6:
        {

        }
            break;
            
        case ElevenFunctionType_7:
        {

        }
            break;
            
        case ElevenFunctionType_8:
        {
            
        }
            break;
            
        case ElevenFunctionType_9:
        {

        }
            break;
            
        case ElevenFunctionType_10:
        {

        }
            break;
            
        case ElevenFunctionType_11:
        {

        }
            break;
            
        case ElevenFunctionType_12:
        {
            
        }
            break;
            
        default:
            break;
    }

    if (label_member_no){
        [contentView addSubview:label_member_no];
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        case RequestType_GET_LINK:
        {
            NSString *str = [param.listData lastObject];
            NSLog(@"object: %@",str);
            if (![str isEqualToString:@""]) {
                NSURL *url = [NSURL URLWithString:str];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }else{
                [webView loadHTMLString:@"</br><font size= '1.5'>&nbsp;&nbsp;&nbsp;ホームページは指定されていません。</font>" baseURL:nil];
            }
        }
            break;
        case RequestType_GET_BOOK_LINK:
        {
            NSString *str = [param.listData lastObject];
            NSLog(@"object: %@",str);
            if (![str isEqualToString:@""]) {
                NSURL *url = [NSURL URLWithString:str];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
            }else{
                [webView loadHTMLString:@"</br><font size= '1.5'>&nbsp;&nbsp;&nbsp;予約は指定されていません。</font>" baseURL:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
    
}

#pragma mark - MPCouponStampViewDelegate
- (void)backToCouponTab {
    
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:1];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:1];
    //[[MPTabBarViewController sharedInstance] setUpTabBar];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MPCouponShareViewDelegate
- (void)getCouponShare:(MPCouponObject *)object {
/*
    MPCouponShareViewController *couponShareViewController = [[MPCouponShareViewController alloc] initWithNibName:@"MPCouponShareViewController" bundle:nil];
    [couponShareViewController setData:object];
    [self.navigationController pushViewController:couponShareViewController animated:YES];
*/
}

- (void)getTaskWithFunctions:(ElevenFunctionType)type {
    
    [super getTaskWithFunctions:type];
    functionType = type;
}

- (void)getCurponButtonClicked:(long)No {
}

- (void)backButtonClicked:(UIButton *)sender {
    
    for (UIView *view in contentView.subviews) {
        [view removeFromSuperview];
    }
    [[MPTabBarViewController sharedInstance] setDisableHomeButton:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
    for (UIView *view in contentView.subviews) {
        [view removeFromSuperview];
    }
}

- (void)setUserIDColor:(NSString*)colorNo {
}

- (void)setArertCurpon:(NSString*)no {
}

- (void)arert_StampErr {
}

- (void)setInfomation:(NSString*)comment{
}

- (void)arert_AllStamp:(NSString*)strFromInt UUID:(NSString*)uuid {
}

-(void)setNotStampForm {
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
