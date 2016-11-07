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

    [self setUpTabBar];
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

- (void)setCustomNavigaion {

    statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    ///////////// カスタムナビゲーション /////////////

    //カスタムナビゲーション作成
    view_custom_navigationView = [[UIView alloc] init];
    [view_custom_navigationView setBackgroundColor:[UIColor clearColor]];
    [view_custom_navigationView setUserInteractionEnabled:YES];
    CGRect custom_frameNavigationView = view_custom_navigationView.frame;
    custom_frameNavigationView.origin.x = FRAME_ORGIN;
    custom_frameNavigationView.origin.y = FRAME_ORGIN + statusHeight;
    custom_frameNavigationView.size.width = self.view.frame.size.width;
    custom_frameNavigationView.size.height = FRAME_HEIGHT;
    view_custom_navigationView.frame = custom_frameNavigationView;
    [self.view addSubview:view_custom_navigationView];

    //カスタムナビゲーション背景設定
    UIImage *img_custom_navigationView_back = [UIImage imageNamed:@"navigation_back.png"];
    UIImageView* iv_custom_navigationView_back = [[UIImageView alloc] initWithImage:img_custom_navigationView_back];
    iv_custom_navigationView_back.contentMode = UIViewContentModeScaleAspectFit;
    iv_custom_navigationView_back.frame = CGRectMake(0, 0, view_custom_navigationView.frame.size.width, view_custom_navigationView.frame.size.height);
    [view_custom_navigationView addSubview:iv_custom_navigationView_back];

    //カスタムナビゲーションタイトル画像設定
    UIImageView *iv_custom_navigationIcon = [[UIImageView alloc] initWithFrame:CGRectMake((custom_frameNavigationView.size.width - ICON_WIDTH)/2, (custom_frameNavigationView.size.height - ICON_HEIGHT)/2, ICON_WIDTH, ICON_HEIGHT)];
//    [iv_custom_navigationIcon setImage:[UIImage imageNamed:@"navigation_icon.png"]];
    [iv_custom_navigationIcon setContentMode:UIViewContentModeScaleAspectFit];
    [view_custom_navigationView addSubview:iv_custom_navigationIcon];

    //カスタムナビゲーション　メニューオープンボタン設置
    UIImage *img_custom_config = [UIImage imageNamed:@"configuration.png"];
    iv_custom_config = [[UIImageView alloc] initWithImage:img_custom_config];
    iv_custom_config.contentMode = UIViewContentModeScaleAspectFit;
    iv_custom_config.frame = CGRectMake(10, 10, 24, 24);
    [view_custom_navigationView addSubview:iv_custom_config];

    btn_custom_setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_custom_setting.frame = CGRectMake(0, 0, 44, 44);
    [btn_custom_setting addTarget:self action:@selector(custom_open_NavigationMenu:) forControlEvents:UIControlEventTouchDown];
    [view_custom_navigationView addSubview:btn_custom_setting];

    //ステータスバー背景設定
    UIView* view_frameNavigationView_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, statusHeight)];
    view_frameNavigationView_shadow.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view_frameNavigationView_shadow];

    ///////////// サイドメニュー /////////////
    
    //ナビゲーションメニュー設定
    lng_NavigationMenu_point = - self.view.frame.size.width;
    view_NaviFrame = [[UIView alloc] initWithFrame:CGRectMake(lng_NavigationMenu_point, statusHeight, self.view.frame.size.width, self.view.frame.size.height - statusHeight)];
    view_NaviFrame.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view_NaviFrame];
    [self.view bringSubviewToFront:view_NaviFrame];

    //ナビゲーション画面用　closeボタン設置
    UIImage *im_custom_NavigationMenu_closeButton = [UIImage imageNamed:@"configuration.png"];
    UIImageView* iv_custom_NavigationMenu_closeButton = [[UIImageView alloc] initWithImage:im_custom_NavigationMenu_closeButton];
    iv_custom_NavigationMenu_closeButton.contentMode = UIViewContentModeScaleAspectFit;
    iv_custom_NavigationMenu_closeButton.frame = CGRectMake(view_NaviFrame.frame.size.width - 10 - 24, 10, 24, 24);
    [view_NaviFrame addSubview:iv_custom_NavigationMenu_closeButton];

    UIButton* btn_custom_btn_close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_custom_btn_close.frame = CGRectMake(view_NaviFrame.frame.size.width - 44, 0, 44, 44);
    [btn_custom_btn_close addTarget:self action:@selector(custom_close_NavigationMenu:) forControlEvents:UIControlEventTouchDown];
    [view_NaviFrame addSubview:btn_custom_btn_close];

    //メニュー用view
    view_NaviMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view_NaviFrame.frame.size.width - 44, view_NaviFrame.frame.size.height)];
    view_NaviMenu.backgroundColor = [UIColor blackColor];
    [view_NaviFrame addSubview:view_NaviMenu];

    //SwipeGestureのインスタンスを生成
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(custom_close_NavigationMenu:)];
    //スワイプの方向（右から左）
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    //self.viewにジェスチャーをのせる
    [self.view addGestureRecognizer:swipeLeftGesture];
}

- (void)custom_open_TopNavigation:(UIButton*)button {

//    [self.view bringSubviewToFront:view_custom_navigationView];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = view_custom_navigationView.frame;
                         flt_navi.origin.y = 20;
                         flt_navi.size.height = FRAME_HEIGHT;
                         view_custom_navigationView.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック
                         
                     }];
}

- (void)custom_close_TopNavigation:(UIButton*)button {

//    [self.view bringSubviewToFront:view_custom_navigationView];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = view_custom_navigationView.frame;
                         flt_navi.origin.y = - FRAME_HEIGHT;
                         flt_navi.size.height = 0;
                         view_custom_navigationView.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック
                         
                     }];
}

- (void)custom_open_NavigationMenu:(UIButton*)button {

    [self.view bringSubviewToFront:view_NaviFrame];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = view_NaviFrame.frame;
                         flt_navi.origin.x = 0.0f;
                         view_NaviFrame.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック

                     }];
}

- (void)custom_close_NavigationMenu:(UIButton*)button {

    [self.view bringSubviewToFront:view_NaviFrame];
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                         CGRect flt_navi = view_NaviFrame.frame;
                         flt_navi.origin.x = - view_NaviFrame.frame.size.width;
                         view_NaviFrame.frame = flt_navi;

                     } completion:^(BOOL finished){

                         //完了時のコールバック
                         
                     }];
}

#pragma mark - Custom TabBar
- (void)customTabBar {
    
    [self.tabBar setHidden:YES];
    CGRect rect = self.tabBar.frame;
    rect.size.height = 50;
    UIImageView *bgTabBar = [[UIImageView alloc] initWithFrame:rect];
    [bgTabBar setTag:1111];
    [bgTabBar setImage:[UIImage imageNamed:@"tab_back.png"]];
    [bgTabBar setUserInteractionEnabled:YES];
    float widthBT = rect.size.width / numberTab;
    for (int i = 0; i < numberTab; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor clearColor]];
        
        NSString *urlImageNomal = @"";
        NSString *urlImageSelected = @"";
        
        switch (i) {
                
            case 0:{
                //urlImageNomal = @"1.png";
                urlImageSelected = @"1_click.png";
                break;
            }
                
            case 1:{
                //urlImageNomal = @"2.png";
                urlImageSelected = @"2_click.png";
                break;
            }
                
            case 2:{
                //urlImageNomal = @"3.png";
                urlImageSelected = @"3_click.png";
                break;
            }
                
            case 3:{
                //urlImageNomal = @"4.png";
                urlImageSelected = @"4_click.png";
                break;
            }
                
            case 4:{
                //urlImageNomal = @"5.png";
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

    [self selectTab:0];
}

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

- (void)setCustomNavigationHiden:(BOOL)isEnable {

    view_custom_navigationView.hidden = isEnable;
}

- (void)dealloc {

    listButton = nil;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
