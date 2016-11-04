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
#import "MPShopDetailViewController.h"
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

    listButton = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    if (!firstTimeRun) {
        [self customTabBar];
        firstTimeRun = YES;
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    listShop = param.listData;
    //if (listShop.count == 1) {
        [self setUpTabBar];
    //}
    //listShop = nil;
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

#pragma mark - Setup Tabar
- (void)setUpTabBar {
    
    UIViewController *vc = nil;
    NSMutableArray *listVC = [[NSMutableArray alloc] init];
    
    numberTab = 5;
    
    for (int i = 0; i < numberTab; i ++) {
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

#pragma mark - Custom TabBar
- (void)customTabBar {
    
    [self.tabBar setHidden:YES];
    CGRect rect = self.tabBar.frame;
    rect.size.height = 50;
    UIImageView *bgTabBar = [[UIImageView alloc] initWithFrame:rect];
    [bgTabBar setTag:1111];
    [bgTabBar setImage:[UIImage imageNamed:@"backBottom.png"]];
    [bgTabBar setUserInteractionEnabled:YES];
    float widthBT = rect.size.width / numberTab;
    for (int i = 0; i < numberTab; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor clearColor]];
        
        NSString *urlImageNomal = @"";
        NSString *urlImageSelected = @"";
        
        switch (i) {
                
            case 0:{
                urlImageNomal = @"1.png";
                urlImageSelected = @"1_click.png";
                break;
            }
                
            case 1:{
                urlImageNomal = @"2.png";
                urlImageSelected = @"2_click.png";
                break;
            }
                
            case 2:{
                urlImageNomal = @"3.png";
                urlImageSelected = @"3_click.png";
                break;
            }
                
            case 3:{
                urlImageNomal = @"4.png";
                urlImageSelected = @"4_click.png";
                break;
            }
                
            case 4:{
                urlImageNomal = @"5.png";
                urlImageSelected = @"5_click.png";
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
        [bgTabBar addSubview:bt];
        [listButton addObject:bt];
    }
    [self.view addSubview:bgTabBar];

    // INSERTED  M.ama 2016.10.26 START
    // 新着情報取得設定
    UIImage *img_circle = [UIImage imageNamed:@"red_circle.png"];
    iv_news_count = [[UIImageView alloc] initWithImage:img_circle];
    iv_news_count.contentMode = UIViewContentModeScaleAspectFit;
    iv_news_count.frame = CGRectMake(widthBT + widthBT/2 + 5, rect.origin.y + 3, 17, 17);
    [self.view addSubview:iv_news_count];

    lbl_news_count = [[UILabel alloc] initWithFrame:iv_news_count.frame];
    lbl_news_count.backgroundColor = [UIColor clearColor];
    lbl_news_count.textColor = [UIColor whiteColor];
    lbl_news_count.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9];
    lbl_news_count.textAlignment = NSTextAlignmentCenter;
    lbl_news_count.text = @"";
    [self.view addSubview:lbl_news_count];
    iv_news_count.hidden = YES;
    lbl_news_count.hidden = YES;
    // INSERTED  M.ama 2016.10.26 END

    // INSERTED  M.ama 2016.10.26 START
    // 新着情報取得設定
    iv_coupon_count = [[UIImageView alloc] initWithImage:img_circle];
    iv_coupon_count.contentMode = UIViewContentModeScaleAspectFit;
    iv_coupon_count.frame = CGRectMake(3 * widthBT + widthBT/2 + 5, rect.origin.y + 3, 17, 17);
    [self.view addSubview:iv_coupon_count];

    lbl_coupon_count = [[UILabel alloc] initWithFrame:iv_coupon_count.frame];
    lbl_coupon_count.backgroundColor = [UIColor clearColor];
    lbl_coupon_count.textColor = [UIColor whiteColor];
    lbl_coupon_count.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9];
    lbl_coupon_count.textAlignment = NSTextAlignmentCenter;
    lbl_coupon_count.text = @"";
    [self.view addSubview:lbl_coupon_count];
    iv_coupon_count.hidden = YES;
    lbl_coupon_count.hidden = YES;
    // INSERTED  M.ama 2016.10.26 END

    [self selectTab:0];
}

// INSERTED  M.ama 2016.10.26 START
// 新着情報取得設定
-(void)setNewsCount:(long)count {

    if(count > 0){

        iv_news_count.hidden = NO;
        lbl_news_count.hidden = NO;
        lbl_news_count.text = [NSString stringWithFormat:@"%ld",count];
    }else{

        iv_news_count.hidden = YES;
        lbl_news_count.hidden = YES;
        lbl_news_count.text = @"";
    }
}
// INSERTED  M.ama 2016.10.26 END

// INSERTED  M.ama 2016.10.26 START
// 新着情報取得設定
-(void)setCouponCount:(long)count {

    if(count > 0){

        iv_coupon_count.hidden = NO;
        lbl_coupon_count.hidden = NO;
        lbl_coupon_count.text = [NSString stringWithFormat:@"%ld",count];
    }else{

        iv_coupon_count.hidden = YES;
        lbl_coupon_count.hidden = YES;
        lbl_coupon_count.text = @"";
    }
}
// INSERTED  M.ama 2016.10.26 END

- (void)buttonClicked:(UIButton*)sender {
    
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
    long tagNum = [sender tag];
    
    [self selectTab:tagNum];
}

- (void)selectTab:(long)tabID {
    
    for (UIButton *bt in listButton) {
        if (bt.tag == tabID) {
            
            [bt setSelected:YES];
            
        }else{
            
            [bt setSelected:NO];
        }
    }
	self.selectedIndex = tabID;
}

- (void)setDisableHomeButton:(BOOL)isEnable {
    
    UIView *specialView = [[self.view viewWithTag:1111] viewWithTag:0];
    if ([specialView isKindOfClass:[UIButton class]]) {
        if (isEnable) {
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"1_click.png"] forState:UIControlStateSelected];
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"1_click.png"] forState:UIControlStateHighlighted];
        }else{
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
            [(UIButton*)specialView setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        }
        
    }
}

- (void)dealloc {

    listButton = nil;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
