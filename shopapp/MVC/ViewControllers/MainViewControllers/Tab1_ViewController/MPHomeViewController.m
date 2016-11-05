//
//  MPHomeViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHomeViewController.h"
#import "TopImageDetailView.h"
#import "MPTopImagesView.h"
#import "MPHomeMenuDetailViewController.h"
#import "MPTabBarViewController.h"
#import "MPConfigObject.h"

#define DIV_PART_FROM_MAINVIEW 5

@interface MPHomeViewController ()
@property (nonatomic,strong) NSMutableArray *listObject;
@end

@implementation MPHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    DGSLog(@"(log By M.ama) DeviceID : %@", [Utility getDeviceID]);
    
    //アカウント画面呼び出し
    if([Configuration getFirstUserInfoSet] == false){
        
//        TheUserInfoViewController *initialViewController = [[TheUserInfoViewController alloc] initWithNibName:@"TheUserInfoViewController" bundle:nil];
//        initialViewController.TheUserInfoViewControllerDelegate = self;
//        [self presentViewController:initialViewController animated:NO completion:nil];
    }

    //🔴navigation表示
    [self setNavigationHiden:YES];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];

    NSLog(@"%f",contentView.frame.size.height);
    float heightCalc = (contentView.frame.size.height) / DIV_PART_FROM_MAINVIEW;
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //スクロールビュー作成
    _scr_rootview = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    _scr_rootview.delegate = self;
    _scr_rootview.showsVerticalScrollIndicator = NO;
    _scr_rootview.backgroundColor = [UIColor whiteColor];
    [_scr_rootview setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    scr_inView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 0)];
    [_scr_rootview addSubview:scr_inView];
    _scr_rootview.contentSize = scr_inView.bounds.size;
    [contentView addSubview:_scr_rootview];
    
    cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scr_inView.frame.size.width, scr_inView.frame.size.height)];
    cornerView.backgroundColor = [UIColor whiteColor];
    cornerView.clipsToBounds = YES;
    [cornerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [scr_inView addSubview:cornerView];
    
    //横スクロールイメージビュー追加（商品紹介）
    topImageView = (MPTopImagesView*)[Utility viewInBundleWithName:@"MPTopImagesView"];
    topImageView.delegate = self;
    if ([[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] top_image_type] isEqualToString:@"rectangular"]) {
        topImageView.isSquare = NO;
    }else{
        topImageView.isSquare = YES;
    }
    
    float topImageHeight = 0;
    float newMessageHeight,listFunHeight = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        topImageHeight = heightCalc*3.0;
        newMessageHeight = heightCalc *3.0;
        listFunHeight = heightCalc;
    }else{
        topImageHeight = heightCalc*1.85;
        newMessageHeight = heightCalc *2.25;
        listFunHeight = heightCalc;
    }
    
    CGRect topImageViewFrame = topImageView.frame;
    topImageViewFrame.origin.x = 0;
    topImageViewFrame.origin.y = 0;
    topImageViewFrame.size.height = topImageHeight;
    topImageView.frame = topImageViewFrame;
    [cornerView addSubview:topImageView];
    
    //メニュー画像追加
    UIImage *img_toppics = [UIImage imageNamed:@"toppic02.png"];
    CGFloat cgrange_toppics = (cornerView.frame.size.width - 20) / img_toppics.size.width;
    
    iv_toppics = [[UIImageView alloc] initWithImage:img_toppics];
    iv_toppics.contentMode = UIViewContentModeScaleAspectFit;
    iv_toppics.frame = CGRectMake(15, topImageView.frame.origin.y + topImageView.frame.size.height + 5, cornerView.frame.size.width - 30, img_toppics.size.height * cgrange_toppics);

    UIButton *btn_toppics = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_toppics.frame = CGRectMake(iv_toppics.frame.origin.x, iv_toppics.frame.origin.y, iv_toppics.frame.size.width, iv_toppics.frame.size.height);
    [btn_toppics addTarget:self action:@selector(push_toppics:) forControlEvents:UIControlEventTouchUpInside];
    [btn_toppics setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
    [btn_toppics setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_toppics.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_toppics];
    
    //おいしい焼き方文字
    UILabel *lbl_recipe = [[UILabel alloc] init];
    lbl_recipe.frame = CGRectMake(15, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 5, cornerView.frame.size.width - 30, 24);
    lbl_recipe.backgroundColor = [UIColor clearColor];
    lbl_recipe.textColor = [UIColor blackColor];
    lbl_recipe.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lbl_recipe.textAlignment = NSTextAlignmentCenter;
    lbl_recipe.text = @"おいしい焼き方";
    [cornerView addSubview:lbl_recipe];
    
    //おいしい焼き方画像１
    UIImage *img_yakikata01 = [UIImage imageNamed:@"yakikata01.png"];
    CGFloat cgrange_yakikata01 = (cornerView.frame.size.width - 20) / img_yakikata01.size.width;
    
    UIImageView *iv_yakikata01 = [[UIImageView alloc] initWithImage:img_yakikata01];
    iv_yakikata01.contentMode = UIViewContentModeScaleAspectFit;
    iv_yakikata01.frame = CGRectMake(15, lbl_recipe.frame.origin.y + lbl_recipe.frame.size.height + 5, cornerView.frame.size.width - 30, img_yakikata01.size.height * cgrange_yakikata01);
    
    UIButton *btn_yakikata01 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_yakikata01.frame = CGRectMake(iv_yakikata01.frame.origin.x, iv_yakikata01.frame.origin.y, iv_yakikata01.frame.size.width, iv_yakikata01.frame.size.height);
    [btn_yakikata01 addTarget:self action:@selector(push_yakikata01:) forControlEvents:UIControlEventTouchUpInside];

    [btn_yakikata01 setImage:[UIImage imageNamed:@"yakikata01.png"] forState:UIControlStateNormal];
    [btn_yakikata01 setImage:[UIImage imageNamed:@"yakikata01_push.png"] forState:(UIControlStateNormal|UIControlStateHighlighted)];
    btn_yakikata01.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_yakikata01];
    
    //おいしい焼き方画像２
    UIImage *img_yakikata02 = [UIImage imageNamed:@"yakikata02.png"];
    CGFloat cgrange_yakikata02 = (cornerView.frame.size.width - 20) / img_yakikata02.size.width;
    
    UIImageView *iv_yakikata02 = [[UIImageView alloc] initWithImage:img_yakikata02];
    iv_yakikata02.contentMode = UIViewContentModeScaleAspectFit;
    iv_yakikata02.frame = CGRectMake(15, iv_yakikata01.frame.origin.y + iv_yakikata01.frame.size.height + 10, cornerView.frame.size.width - 30, img_yakikata02.size.height * cgrange_yakikata02);
    
    UIButton *btn_yakikata02 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_yakikata02.frame = CGRectMake(iv_yakikata02.frame.origin.x, iv_yakikata02.frame.origin.y, iv_yakikata02.frame.size.width, iv_yakikata02.frame.size.height);
    [btn_yakikata02 addTarget:self action:@selector(push_yakikata02:) forControlEvents:UIControlEventTouchUpInside];
    [btn_yakikata02 setImage:[UIImage imageNamed:@"yakikata02.png"] forState:UIControlStateNormal];
    [btn_yakikata02 setImage:[UIImage imageNamed:@"yakikata02_push.png"] forState:UIControlStateHighlighted];
    btn_yakikata02.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_yakikata02];
    
    //クーポン文字
    UILabel *lbl_curpon = [[UILabel alloc] init];
    lbl_curpon.frame = CGRectMake(15, iv_yakikata02.frame.origin.y + iv_yakikata02.frame.size.height + 5, cornerView.frame.size.width - 30, 24);
    lbl_curpon.backgroundColor = [UIColor clearColor];
    lbl_curpon.textColor = [UIColor blackColor];
    lbl_curpon.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lbl_curpon.textAlignment = NSTextAlignmentCenter;
    lbl_curpon.text = @"クーポン";
    [cornerView addSubview:lbl_curpon];
    
    //クーポン画像
    UIImage *img_curpon = [UIImage imageNamed:@"hangaku.png"];
    CGFloat cgrange_curpon = (cornerView.frame.size.width - 20) / img_curpon.size.width;
    
    UIImageView *iv_curpon = [[UIImageView alloc] initWithImage:img_curpon];
    iv_curpon.contentMode = UIViewContentModeScaleAspectFit;
    iv_curpon.frame = CGRectMake(15, lbl_curpon.frame.origin.y + lbl_curpon.frame.size.height + 5, cornerView.frame.size.width - 30, img_curpon.size.height * cgrange_curpon);
    
    btn_curpon = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_curpon.frame = CGRectMake(iv_curpon.frame.origin.x, iv_curpon.frame.origin.y, iv_curpon.frame.size.width, iv_curpon.frame.size.height);
    [btn_curpon addTarget:self action:@selector(push_curpon:) forControlEvents:UIControlEventTouchUpInside];
    [btn_curpon setImage:[UIImage imageNamed:@"hangaku.png"] forState:UIControlStateNormal];
//    [btn_curpon setImage:[UIImage imageNamed:@"hangaku_push.png"] forState:UIControlStateHighlighted];
    btn_curpon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_curpon];

    //クーポンイメージダウンロード
    NSURL* url = [NSURL URLWithString:CURPON_IMAGE_URL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               UIImage *image = nil;
                               if (!error){
                                   image = [[UIImage alloc] initWithData:data];
                                   // do whatever you want with image
                               }else{
                                   image = [UIImage imageNamed:@"hangaku.png"];
                               }

                               UIImage *img_curpon = image;
                               CGFloat cgrange_curpon = (cornerView.frame.size.width - 20) / img_curpon.size.width;

                               UIImageView *iv_curpon = [[UIImageView alloc] initWithImage:image];
                               iv_curpon.contentMode = UIViewContentModeScaleAspectFit;
                               iv_curpon.frame = CGRectMake(15, lbl_curpon.frame.origin.y + lbl_curpon.frame.size.height + 5, cornerView.frame.size.width - 30, img_curpon.size.height * cgrange_curpon);

                               btn_curpon.frame = CGRectMake(iv_curpon.frame.origin.x, iv_curpon.frame.origin.y, iv_curpon.frame.size.width, iv_curpon.frame.size.height);
                               [btn_curpon setImage:image forState:UIControlStateNormal];

                           }];

    //スクロールビュー大きさ再設定
    scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, btn_curpon.frame.origin.y + btn_curpon.frame.size.height + 35);
    cornerView.frame = CGRectMake(8, 8, scr_inView.frame.size.width - 16, scr_inView.frame.size.height - 16);
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    //スクロールビュー大きさ再設定
    scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, btn_curpon.frame.origin.y + btn_curpon.frame.size.height + 35);
    cornerView.frame = CGRectMake(8, 8, scr_inView.frame.size.width - 16, scr_inView.frame.size.height - 16);
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

#pragma mark - TopImageDelegate
- (void)showWebView:(NSString *)text {
    
    MPHomeWebViewViewController *webViewVC = [[MPHomeWebViewViewController alloc] initWithNibName:@"MPHomeWebViewViewController" bundle:nil];
    webViewVC.linkUrl = text;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (void)bounceOutAnimationStoped:(UIView*)view {
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         view.alpha = 1;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped:view];
                     }];
}

- (void)bounceInAnimationStoped:(UIView*)view {
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         view.alpha = 1;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                         
                     }];
}

- (void)animationStoped {
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

}

- (void)downloadDataFail:(DownloadParam *)param {
}

-(void)push_toppics:(UIButton*)button {
    
    //メニュー表示
    MPHomeMenuViewController *menuDetailVC = [[MPHomeMenuViewController alloc] initWithNibName:@"MPHomeMenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuDetailVC animated:YES];
}

-(void)push_yakikata01:(UIButton*)button {

    //お好み焼の焼き方画面
    MPHomeOkonomiViewController *OkonomiVC = [[MPHomeOkonomiViewController alloc] initWithNibName:@"MPHomeOkonomiViewController" bundle:nil];
    [self.navigationController pushViewController:OkonomiVC animated:YES];
}

-(void)push_yakikata02:(UIButton*)button {
    
    //もんじゃ焼の焼き方画面
    MPHomeMonjyaViewController *MonjyaVC = [[MPHomeMonjyaViewController alloc] initWithNibName:@"MPHomeMonjyaViewController" bundle:nil];
    [self.navigationController pushViewController:MonjyaVC animated:YES];
}

-(void)push_curpon:(UIButton*)button {
    
    //クーポン画面
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:2];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
