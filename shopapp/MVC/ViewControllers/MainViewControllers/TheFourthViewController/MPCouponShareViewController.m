//
//  MPCouponShareViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponShareViewController.h"
#import "MPTabBarViewController.h"
#define Consumer_Key @"YlDPeQ3VaCZL4pSRRDNy3U7JQ"
#define Consumer_Secret @"BmLNnaAAQp2nG0Twwy5LmBEn6efXBVoz6X3oAEBXFk47MmanLZ"

@interface MPCouponShareViewController ()
@property (nonatomic, strong) NSString *contentTweet;
@end

@implementation MPCouponShareViewController

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
    [contentView addSubview:view];
    [title setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function4"] objectForKey:@"titleHeader"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 320, contentView.frame.size.height - view.frame.size.height) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [contentView addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:YES];
}

- (void)setData:(MPCouponObject *)object {
    
    couponObject = object;
}
- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [MPSocialView heightForHeader:couponObject];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MPSocialView *socialView = (MPSocialView*) [Utility viewInBundleWithName:@"MPSocialView"];
    [socialView setData:couponObject];
    socialView.delegate = self;
    [socialView setBackgroundColor:[UIColor clearColor]];
    return socialView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}

#pragma mark - MPSocialViewDelegate
- (void)invokeSocial:(SocialType)type {
    
    MPSocialShareAlertView *alertView = (MPSocialShareAlertView*) [Utility viewInBundleWithName:@"MPSocialShareAlertView"];
    alertView.delegate = self;
    [alertView setData:couponObject withType:type];
    
    [[MPAppDelegate sharedMPAppDelegate].window addSubview:alertView];
}

#pragma mark - MPSocialShareAlertViewDelegate
- (void)showViewTwitter:(NSString *)share_content {

    self.contentTweet = share_content;
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:Consumer_Key andSecret:Consumer_Secret];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    
    [self loginOAuth];
}

- (void)shareWithFaceBookDone {
    
    isShareTwitterOkay = YES;
    UIAlertView *showView = [[UIAlertView alloc] initWithTitle:TITLE_MESSAGE_SHARE_FACEBOOK message:BODY_MESSAGE_SHARE_FACEBOOK_OKAY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    showView.tag = 1911;
    [showView show];
    
}

-(void)shareWithLinekDone {
    
    isShareLineDone= YES;
    couponObject.coupon_type = 2;
    UIAlertView *showView = [[UIAlertView alloc] initWithTitle:TITLE_MESSAGE_SHARE_LINE message:BODY_MESSAGE_SHARE_LINE_OKAY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    showView.tag = 1911;
    [showView show];
}

- (void)storeAccessToken:(NSString *)accessToken {
    
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"SavedAccessHTTPBody"];
}

- (NSString *)loadAccessToken {
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SavedAccessHTTPBody"];
}
- (void)loginOAuth {
    
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
        NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
        if (success) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @autoreleasepool {
                    NSString *tweet = self.contentTweet;
                    id returned = [[FHSTwitterEngine sharedEngine]postTweet:tweet];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    
                    NSString *message = nil;
                    
                    if ([returned isKindOfClass:[NSError class]]) {
                      //  NSError *error = (NSError *)returned;
                        message = MESSAGE_SHARE_SOCIAL_ERROR;
                        isShareTwitterOkay = NO;
                    } else {
                        NSLog(@"%@",returned);
                        message = BODY_MESSAGE_SHARE_TWITTER_OKAY;
                        isShareTwitterOkay = YES;
                        
                        
                    }
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        @autoreleasepool {
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:TITLE_MESSAGE_SHARE_TWITTER message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [[FHSTwitterEngine sharedEngine]clearAccessToken];
                            [av show];
                            
                        }
                    });
                }
            });
        }
    }];
    [self.navigationController pushViewController:loginController animated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    //[[MPTabBarViewController sharedInstance] setUpTabBar];
    //jump to List coupon screen
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:1];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:1];
    [[MPTabBarViewController sharedInstance] setUpTabBar];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (isShareTwitterOkay|| isShareLineDone) {
        
        // type = 2 with share thank coupon
        couponObject.coupon_type = 2;
        [[ManagerDownload sharedInstance] submitRegistCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponObject delegate:self];
        isShareTwitterOkay = NO;
        isShareLineDone = NO;
    }
    // REPLACE END 2015.01.16
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
