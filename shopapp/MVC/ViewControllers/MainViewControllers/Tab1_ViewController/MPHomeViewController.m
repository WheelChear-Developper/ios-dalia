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

    NSLog(@"%f",contentView.frame.size.height);
    float heightCalc = (contentView.frame.size.height) / DIV_PART_FROM_MAINVIEW;

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
    topImageViewFrame.origin.x = 2;
    topImageViewFrame.origin.y = 2;
    topImageViewFrame.size.width = topImageViewFrame.size.width - 4;
    topImageViewFrame.size.height = topImageHeight;
    topImageView.frame = topImageViewFrame;
    [cornerView addSubview:topImageView];

    // ブロック１設定
    UIImageView* iv_block1 = [[UIImageView alloc] init];
    iv_block1.contentMode = UIViewContentModeScaleAspectFit;
    iv_block1.frame = CGRectMake(2, topImageView.frame.origin.y + topImageView.frame.size.height + 2, cornerView.frame.size.width / 3, 100);
    iv_block1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [cornerView addSubview:iv_block1];

    UIButton *btn_block1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block1.frame = iv_block1.frame;
    [btn_block1 addTarget:self action:@selector(push_block1:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block1 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block1 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_block1];

    // ブロック２設定
    UIImageView* iv_block2 = [[UIImageView alloc] init];
    iv_block2.contentMode = UIViewContentModeScaleAspectFit;
    iv_block2.frame = CGRectMake(2 + iv_block1.frame.origin.x + iv_block1.frame.size.width, topImageView.frame.origin.y + topImageView.frame.size.height + 2, cornerView.frame.size.width / 3, 100);
    iv_block2.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [cornerView addSubview:iv_block2];

    UIButton *btn_block2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block2.frame = iv_block2.frame;
    [btn_block2 addTarget:self action:@selector(push_block2:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block2 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block2 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_block2];

    // ブロック３設定
    UIImageView* iv_block3 = [[UIImageView alloc] init];
    iv_block3.contentMode = UIViewContentModeScaleAspectFit;
    iv_block3.frame = CGRectMake(2 + iv_block2.frame.origin.x + iv_block2.frame.size.width, topImageView.frame.origin.y + topImageView.frame.size.height + 2, cornerView.frame.size.width / 3, 100);
    iv_block3.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [cornerView addSubview:iv_block3];

    UIButton *btn_block3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block3.frame = iv_block3.frame;
    [btn_block3 addTarget:self action:@selector(push_block3:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block3 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block3 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_block3];

    // ブロック４設定
    UIImageView* iv_block4 = [[UIImageView alloc] init];
    iv_block4.contentMode = UIViewContentModeScaleAspectFit;
    iv_block4.frame = CGRectMake(2, iv_block1.frame.origin.y + iv_block1.frame.size.height + 2, cornerView.frame.size.width / 2, 100);
    iv_block4.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [cornerView addSubview:iv_block4];

    UIButton *btn_block4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block4.frame = iv_block4.frame;
    [btn_block4 addTarget:self action:@selector(push_block4:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn_block4 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
    //    [btn_block4 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_block4];

    // ブロック５設定
    UIImageView* iv_block5 = [[UIImageView alloc] init];
    iv_block5.contentMode = UIViewContentModeScaleAspectFit;
    iv_block5.frame = CGRectMake(2 + iv_block4.frame.origin.x + iv_block4.frame.size.width, iv_block1.frame.origin.y + iv_block1.frame.size.height + 2, cornerView.frame.size.width / 2, 100);
    iv_block5.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [cornerView addSubview:iv_block5];

    UIButton *btn_block5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block5.frame = iv_block5.frame;
    [btn_block5 addTarget:self action:@selector(push_block5:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn_block5 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
    //    [btn_block5 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cornerView addSubview:btn_block5];

    //RECOMMEND ITEM
    UIView* view_RecommendItem = [[UIView alloc] initWithFrame:CGRectMake(0, btn_block4.frame.origin.y + btn_block4.frame.size.height + 2, contentView.frame.size.width, 230)];
    view_RecommendItem.backgroundColor = [UIColor clearColor];
    [cornerView addSubview:view_RecommendItem];

    //RECOMMEND TITLE
    UILabel *lbl_RecommendTitle = [[UILabel alloc] init];
    lbl_RecommendTitle.frame = CGRectMake(10, 5, view_RecommendItem.frame.size.width - 20, 24);
    lbl_RecommendTitle.backgroundColor = [UIColor clearColor];
    lbl_RecommendTitle.textColor = [UIColor blackColor];
    lbl_RecommendTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lbl_RecommendTitle.textAlignment = NSTextAlignmentLeft;
    lbl_RecommendTitle.text = @"RECOMMEND ITEM";
    [view_RecommendItem addSubview:lbl_RecommendTitle];

    // RECOMMENDブロック1設定
    UIImage *img_recommend1 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend1 = [[UIImageView alloc] init];
    iv_Recommend1.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend1.frame = CGRectMake(10, lbl_RecommendTitle.frame.origin.y + lbl_RecommendTitle.frame.size.height, (cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend1];

    UIButton *btn_Recommend1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend1.frame = iv_Recommend1.frame;
    btn_Recommend1.backgroundColor = [UIColor clearColor];
    btn_Recommend1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend1 setImage:img_recommend1 forState:UIControlStateNormal];
    [btn_Recommend1 addTarget:self action:@selector(push_recomend1:) forControlEvents:UIControlEventTouchUpInside];
//    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend1];

    // RECOMMENDブロック2設定
    UIImage *img_recommend2 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend2 = [[UIImageView alloc] init];
    iv_Recommend2.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend2.frame = CGRectMake(2 + iv_Recommend1.frame.origin.x + iv_Recommend1.frame.size.width, lbl_RecommendTitle.frame.origin.y + lbl_RecommendTitle.frame.size.height, (cornerView.frame.size.width - 20)/ 3, 100);
    iv_Recommend2.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend2];

    UIButton *btn_Recommend2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend2.frame = iv_Recommend2.frame;
    btn_Recommend2.backgroundColor = [UIColor clearColor];
    btn_Recommend2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend2 setImage:img_recommend2 forState:UIControlStateNormal];
    [btn_Recommend2 addTarget:self action:@selector(push_recomend2:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend2];

    // RECOMMENDブロック3設定
    UIImage *img_recommend3 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend3 = [[UIImageView alloc] init];
    iv_Recommend3.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend3.frame = CGRectMake(2 + iv_Recommend2.frame.origin.x + iv_Recommend2.frame.size.width, lbl_RecommendTitle.frame.origin.y + lbl_RecommendTitle.frame.size.height, (cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend3.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend3];

    UIButton *btn_Recommend3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend3.frame = iv_Recommend3.frame;
    btn_Recommend3.backgroundColor = [UIColor clearColor];
    btn_Recommend3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend3 setImage:img_recommend3 forState:UIControlStateNormal];
    [btn_Recommend3 addTarget:self action:@selector(push_recomend3:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend3];


    // RECOMMENDブロック4設定
    UIImage *img_recommend4 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend4 = [[UIImageView alloc] init];
    iv_Recommend4.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend4.frame = CGRectMake(10, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height, (cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend4.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend4];

    UIButton *btn_Recommend4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend4.frame = iv_Recommend4.frame;
    btn_Recommend4.backgroundColor = [UIColor clearColor];
    btn_Recommend4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend4 setImage:img_recommend4 forState:UIControlStateNormal];
    [btn_Recommend4 addTarget:self action:@selector(push_recomend4:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend4];

    // RECOMMENDブロック5設定
    UIImage *img_recommend5 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend5 = [[UIImageView alloc] init];
    iv_Recommend5.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend5.frame = CGRectMake(2 + iv_Recommend4.frame.origin.x + iv_Recommend4.frame.size.width, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height, (cornerView.frame.size.width - 20)/ 3, 100);
    iv_Recommend5.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend5];

    UIButton *btn_Recommend5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend5.frame = iv_Recommend5.frame;
    btn_Recommend5.backgroundColor = [UIColor clearColor];
    btn_Recommend5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend5 setImage:img_recommend5 forState:UIControlStateNormal];
    [btn_Recommend5 addTarget:self action:@selector(push_recomend5:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend5];

    // RECOMMENDブロック6設定
    UIImage *img_recommend6 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend6 = [[UIImageView alloc] init];
    iv_Recommend6.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend6.frame = CGRectMake(2 + iv_Recommend5.frame.origin.x + iv_Recommend5.frame.size.width, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height, (cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend6.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_RecommendItem addSubview:iv_Recommend6];

    UIButton *btn_Recommend6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend6.frame = iv_Recommend6.frame;
    btn_Recommend6.backgroundColor = [UIColor clearColor];
    btn_Recommend6.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend6 setImage:img_recommend6 forState:UIControlStateNormal];
    [btn_Recommend6 addTarget:self action:@selector(push_recomend6:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_RecommendItem addSubview:btn_Recommend6];


    

    //スクロールビュー大きさ再設定
    scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, view_RecommendItem.frame.origin.y + view_RecommendItem.frame.size.height + 35);
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    //スクロールビュー大きさ再設定
//    scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, view_RecommendItem.frame.origin.y + view_RecommendItem.frame.size.height + 35);
//    _scr_rootview.contentSize = scr_inView.bounds.size;
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

/*
-(void)push_toppics:(UIButton*)button {
    
    //メニュー表示
    MPHomeMenuViewController *menuDetailVC = [[MPHomeMenuViewController alloc] initWithNibName:@"MPHomeMenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuDetailVC animated:YES];
}
*/

-(void)push_block1:(UIButton*)button {

    //お好み焼の焼き方画面
//    MPHomeOkonomiViewController *OkonomiVC = [[MPHomeOkonomiViewController alloc] initWithNibName:@"MPHomeOkonomiViewController" bundle:nil];
//    [self.navigationController pushViewController:OkonomiVC animated:YES];
}

-(void)push_block2:(UIButton*)button {

}

-(void)push_block3:(UIButton*)button {

}

-(void)push_block4:(UIButton*)button {

}

-(void)push_block5:(UIButton*)button {

}

-(void)push_recomend1:(UIButton*)button {

}

-(void)push_recomend2:(UIButton*)button {

}

-(void)push_recomend3:(UIButton*)button {

}

-(void)push_recomend4:(UIButton*)button {

}

-(void)push_recomend5:(UIButton*)button {

}

-(void)push_recomend6:(UIButton*)button {

}


/*
-(void)push_curpon:(UIButton*)button {
    
    //クーポン画面
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:2];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];
    [self.navigationController popViewControllerAnimated:YES];
}
*/

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
