//
//  MPHomeViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPHomeViewController.h"

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
    
    //アカウント画面呼び出し
    if([Configuration getFirstUserInfoSet] == false){
        
        TheUserInfoViewController *initialViewController = [[TheUserInfoViewController alloc] initWithNibName:@"TheUserInfoViewController" bundle:nil];
        initialViewController.TheUserInfoViewControllerDelegate = self;
        [self presentViewController:initialViewController animated:NO completion:nil];
    }

    //🔴navigation表示
    [self setBasicNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] SetCustomNavigationLogo:[UIImage imageNamed:@"header_logo.png"]];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [contentView setHidden:NO];
    
    //スクロールビュー作成
    _scr_rootview = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    _scr_rootview.delegate = self;
    _scr_rootview.showsVerticalScrollIndicator = NO;
    _scr_rootview.backgroundColor = [UIColor clearColor];
    [_scr_rootview setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    _scr_inView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 0)];
    [_scr_rootview addSubview:_scr_inView];
    _scr_rootview.contentSize = _scr_inView.bounds.size;
    _scr_rootview.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:_scr_rootview];
    
    _cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scr_inView.frame.size.width, _scr_inView.frame.size.height)];
    _cornerView.backgroundColor = [UIColor clearColor];
    _cornerView.clipsToBounds = YES;
    [_cornerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_scr_inView addSubview:_cornerView];
    
    //横スクロールイメージビュー追加（商品紹介）
    _topImageView = (MPTopImagesView*)[Utility viewInBundleWithName:@"MPTopImagesView"];
    _topImageView.delegate = self;
    if ([[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] top_image_type] isEqualToString:@"rectangular"]) {
        _topImageView.isSquare = NO;
    }else{
        _topImageView.isSquare = YES;
    }

    NSLog(@"%f",contentView.frame.size.height);
    float heightCalc = (contentView.frame.size.height) / DIV_PART_FROM_MAINVIEW;

    float topImageHeight = 0;
    float newMessageHeight,listFunHeight = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        topImageHeight = heightCalc * 2.5;
        newMessageHeight = heightCalc * 2.5;
        listFunHeight = heightCalc;
    }else{
        topImageHeight = heightCalc*1.85;
        newMessageHeight = heightCalc *2.25;
        listFunHeight = heightCalc;
    }
    
    CGRect topImageViewFrame = _topImageView.frame;
    topImageViewFrame.origin.x = 2;
    topImageViewFrame.origin.y = 2;
    topImageViewFrame.size.width = topImageViewFrame.size.width - 4;
    topImageViewFrame.size.height = topImageHeight;
    _topImageView.frame = topImageViewFrame;
    [_cornerView addSubview:_topImageView];

    // ブロック１設定
    UIImageView* iv_block1 = [[UIImageView alloc] init];
    iv_block1.contentMode = UIViewContentModeScaleAspectFit;
    iv_block1.frame = CGRectMake(2, _topImageView.frame.origin.y + _topImageView.frame.size.height + 2, _cornerView.frame.size.width / 3, 100);
    iv_block1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:iv_block1];

    UIButton *btn_block1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block1.frame = iv_block1.frame;
    [btn_block1 addTarget:self action:@selector(push_block1:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block1 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block1 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cornerView addSubview:btn_block1];

    // ブロック２設定
    UIImageView* iv_block2 = [[UIImageView alloc] init];
    iv_block2.contentMode = UIViewContentModeScaleAspectFit;
    iv_block2.frame = CGRectMake(2 + iv_block1.frame.origin.x + iv_block1.frame.size.width, _topImageView.frame.origin.y + _topImageView.frame.size.height + 2, _cornerView.frame.size.width / 3, 100);
    iv_block2.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:iv_block2];

    UIButton *btn_block2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block2.frame = iv_block2.frame;
    [btn_block2 addTarget:self action:@selector(push_block2:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block2 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block2 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cornerView addSubview:btn_block2];

    // ブロック３設定
    UIImageView* iv_block3 = [[UIImageView alloc] init];
    iv_block3.contentMode = UIViewContentModeScaleAspectFit;
    iv_block3.frame = CGRectMake(2 + iv_block2.frame.origin.x + iv_block2.frame.size.width, _topImageView.frame.origin.y + _topImageView.frame.size.height + 2, _cornerView.frame.size.width / 3, 100);
    iv_block3.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:iv_block3];

    UIButton *btn_block3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block3.frame = iv_block3.frame;
    [btn_block3 addTarget:self action:@selector(push_block3:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_block3 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
//    [btn_block3 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cornerView addSubview:btn_block3];

    // ブロック４設定
    UIImageView* iv_block4 = [[UIImageView alloc] init];
    iv_block4.contentMode = UIViewContentModeScaleAspectFit;
    iv_block4.frame = CGRectMake(2, iv_block1.frame.origin.y + iv_block1.frame.size.height + 2, _cornerView.frame.size.width / 2, 100);
    iv_block4.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:iv_block4];

    UIButton *btn_block4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block4.frame = iv_block4.frame;
    [btn_block4 addTarget:self action:@selector(push_block4:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn_block4 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
    //    [btn_block4 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cornerView addSubview:btn_block4];

    // ブロック５設定
    UIImageView* iv_block5 = [[UIImageView alloc] init];
    iv_block5.contentMode = UIViewContentModeScaleAspectFit;
    iv_block5.frame = CGRectMake(2 + iv_block4.frame.origin.x + iv_block4.frame.size.width, iv_block1.frame.origin.y + iv_block1.frame.size.height + 2, _cornerView.frame.size.width / 2, 100);
    iv_block5.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:iv_block5];

    UIButton *btn_block5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_block5.frame = iv_block5.frame;
    [btn_block5 addTarget:self action:@selector(push_block5:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn_block5 setImage:[UIImage imageNamed:@"toppic02.png"] forState:UIControlStateNormal];
    //    [btn_block5 setImage:[UIImage imageNamed:@"toppic02_push.png"] forState:UIControlStateHighlighted];
    btn_block5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cornerView addSubview:btn_block5];

    //🔵RECOMMEND ITEM
    UIView* view_Recommend_Item = [[UIView alloc] initWithFrame:CGRectMake(0, btn_block4.frame.origin.y + btn_block4.frame.size.height + 2 + 10, contentView.frame.size.width, 270)];
    view_Recommend_Item.backgroundColor = [UIColor clearColor];
    [_cornerView addSubview:view_Recommend_Item];

    //RECOMMEND ITEM TITLE
    UIImage *img_RecommendTitle = [UIImage imageNamed:@"ttl_recommenditem.png"];
    UIImageView* iv_RecommendTitle = [[UIImageView alloc] initWithImage:img_RecommendTitle];
    iv_RecommendTitle.contentMode = UIViewContentModeScaleAspectFit;
    iv_RecommendTitle.frame = CGRectMake(10, 5, view_Recommend_Item.frame.size.width - 20, 25);
    [view_Recommend_Item addSubview:iv_RecommendTitle];

    // RECOMMEND ITEMブロック1設定
    UIImage *img_recommend1 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend1 = [[UIImageView alloc] init];
    iv_Recommend1.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend1.frame = CGRectMake(10, iv_RecommendTitle.frame.origin.y + iv_RecommendTitle.frame.size.height + 5, (_cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend1];

    UIButton *btn_Recommend1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend1.frame = iv_Recommend1.frame;
    btn_Recommend1.backgroundColor = [UIColor clearColor];
    btn_Recommend1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend1 setImage:img_recommend1 forState:UIControlStateNormal];
    [btn_Recommend1 addTarget:self action:@selector(push_recomend1:) forControlEvents:UIControlEventTouchUpInside];
//    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend1];

    // RECOMMEND ITEMブロック2設定
    UIImage *img_recommend2 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend2 = [[UIImageView alloc] init];
    iv_Recommend2.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend2.frame = CGRectMake(2 + iv_Recommend1.frame.origin.x + iv_Recommend1.frame.size.width, iv_RecommendTitle.frame.origin.y + iv_RecommendTitle.frame.size.height + 5, (_cornerView.frame.size.width - 20)/ 3, 100);
    iv_Recommend2.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend2];

    UIButton *btn_Recommend2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend2.frame = iv_Recommend2.frame;
    btn_Recommend2.backgroundColor = [UIColor clearColor];
    btn_Recommend2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend2 setImage:img_recommend2 forState:UIControlStateNormal];
    [btn_Recommend2 addTarget:self action:@selector(push_recomend2:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend2];

    // RECOMMEND ITEMブロック3設定
    UIImage *img_recommend3 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend3 = [[UIImageView alloc] init];
    iv_Recommend3.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend3.frame = CGRectMake(2 + iv_Recommend2.frame.origin.x + iv_Recommend2.frame.size.width, iv_RecommendTitle.frame.origin.y + iv_RecommendTitle.frame.size.height + 5, (_cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend3.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend3];

    UIButton *btn_Recommend3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend3.frame = iv_Recommend3.frame;
    btn_Recommend3.backgroundColor = [UIColor clearColor];
    btn_Recommend3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend3 setImage:img_recommend3 forState:UIControlStateNormal];
    [btn_Recommend3 addTarget:self action:@selector(push_recomend3:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend3];


    // RECOMMEND ITEMブロック4設定
    UIImage *img_recommend4 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend4 = [[UIImageView alloc] init];
    iv_Recommend4.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend4.frame = CGRectMake(10, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height + 2, (_cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend4.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend4];

    UIButton *btn_Recommend4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend4.frame = iv_Recommend4.frame;
    btn_Recommend4.backgroundColor = [UIColor clearColor];
    btn_Recommend4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend4 setImage:img_recommend4 forState:UIControlStateNormal];
    [btn_Recommend4 addTarget:self action:@selector(push_recomend4:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend4];

    // RECOMMENDブロック5設定
    UIImage *img_recommend5 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend5 = [[UIImageView alloc] init];
    iv_Recommend5.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend5.frame = CGRectMake(2 + iv_Recommend4.frame.origin.x + iv_Recommend4.frame.size.width, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height + 2, (_cornerView.frame.size.width - 20)/ 3, 100);
    iv_Recommend5.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend5];

    UIButton *btn_Recommend5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend5.frame = iv_Recommend5.frame;
    btn_Recommend5.backgroundColor = [UIColor clearColor];
    btn_Recommend5.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend5 setImage:img_recommend5 forState:UIControlStateNormal];
    [btn_Recommend5 addTarget:self action:@selector(push_recomend5:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend5];

    // RECOMMEND ITEMブロック6設定
    UIImage *img_recommend6 = [UIImage imageNamed:@"unavailable.gif"];
    UIImageView* iv_Recommend6 = [[UIImageView alloc] init];
    iv_Recommend6.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend6.frame = CGRectMake(2 + iv_Recommend5.frame.origin.x + iv_Recommend5.frame.size.width, iv_Recommend1.frame.origin.y + iv_Recommend1.frame.size.height + 2, (_cornerView.frame.size.width - 20) / 3, 100);
    iv_Recommend6.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [view_Recommend_Item addSubview:iv_Recommend6];

    UIButton *btn_Recommend6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend6.frame = iv_Recommend6.frame;
    btn_Recommend6.backgroundColor = [UIColor clearColor];
    btn_Recommend6.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend6 setImage:img_recommend6 forState:UIControlStateNormal];
    [btn_Recommend6 addTarget:self action:@selector(push_recomend6:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_Recommend1.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend6];

    // RECOMMEND ITEM MORE
    UIImage *img_Recommend_Item_More = [UIImage imageNamed:@"ttl_more.png"];
    UIImageView* iv_Recommend_Item_More = [[UIImageView alloc] initWithImage:img_Recommend_Item_More];
    iv_Recommend_Item_More.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend_Item_More.frame = CGRectMake(10, iv_Recommend4.frame.origin.y + iv_Recommend4.frame.size.height + 5, view_Recommend_Item.frame.size.width - 20, 25);

    UIButton *btn_Recommend_Item_More = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend_Item_More.frame = iv_Recommend_Item_More.frame;
    btn_Recommend_Item_More.backgroundColor = [UIColor clearColor];
    btn_Recommend_Item_More.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend_Item_More setImage:img_Recommend_Item_More forState:UIControlStateNormal];
    [btn_Recommend_Item_More addTarget:self action:@selector(push_recomend_Item_More:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_RecommendMore.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Item addSubview:btn_Recommend_Item_More];

    //🔵RECOMMEND MENU
    view_Recommend_Menu = [[UIView alloc] initWithFrame:CGRectMake(0, view_Recommend_Item.frame.origin.y + view_Recommend_Item.frame.size.height + 2, contentView.frame.size.width, 270)];
    view_Recommend_Menu.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [_cornerView addSubview:view_Recommend_Menu];

    UIImage *img_RecommendMenu = [UIImage imageNamed:@"ttl_recommendmenu.png"];
    UIImageView* iv_RecommendMenu = [[UIImageView alloc] initWithImage:img_RecommendMenu];
    iv_RecommendMenu.contentMode = UIViewContentModeScaleAspectFit;
    iv_RecommendMenu.frame = CGRectMake(10, 5, view_Recommend_Menu.frame.size.width - 20, 25);
    [view_Recommend_Menu addSubview:iv_RecommendMenu];

    //RECOMMEND MENUテーブル
    _RecommendMenuList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iv_RecommendMenu.frame.origin.y + iv_RecommendMenu.frame.size.height + 2, _cornerView.frame.size.width, 0) style:UITableViewStylePlain];
    [_RecommendMenuList_tableView setBackgroundColor:[UIColor clearColor]];
    _RecommendMenuList_tableView.delegate = self;
    _RecommendMenuList_tableView.dataSource = self;
    _RecommendMenuList_tableView.scrollEnabled = false;
    [_RecommendMenuList_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [view_Recommend_Menu addSubview:_RecommendMenuList_tableView];

    UINib *nib = [UINib nibWithNibName:@"MPMenuListHomeCell" bundle:nil];
    [_RecommendMenuList_tableView registerNib:nib forCellReuseIdentifier:@"newMenuListIdentifier"];
    [_RecommendMenuList_tableView reloadData];

    // RECOMMEND MENU MORE
    UIImage *img_Recommend_Menu_More = [UIImage imageNamed:@"ttl_more.png"];
    iv_Recommend_Menu_More = [[UIImageView alloc] initWithImage:img_Recommend_Menu_More];
    iv_Recommend_Menu_More.contentMode = UIViewContentModeScaleAspectFit;
    iv_Recommend_Menu_More.frame = CGRectMake(10, _RecommendMenuList_tableView.frame.origin.y + _RecommendMenuList_tableView.frame.size.height + 10, view_Recommend_Menu.frame.size.width - 20, 25);

    btn_Recommend_Menu_More = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Recommend_Menu_More.frame = iv_Recommend_Menu_More.frame;
    btn_Recommend_Menu_More.backgroundColor = [UIColor clearColor];
    btn_Recommend_Menu_More.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_Recommend_Menu_More setImage:img_Recommend_Menu_More forState:UIControlStateNormal];
    [btn_Recommend_Menu_More addTarget:self action:@selector(push_recomend_Menu_More:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_RecommendMore.adjustsImageWhenHighlighted = NO;
    [view_Recommend_Menu addSubview:btn_Recommend_Menu_More];

    //🔵WHATS NEW
    view_WhatsNew = [[UIView alloc] initWithFrame:CGRectMake(0, view_Recommend_Menu.frame.origin.y + view_Recommend_Menu.frame.size.height + 2, contentView.frame.size.width, 270)];
    view_Recommend_Menu.backgroundColor = [UIColor whiteColor];
    [_cornerView addSubview:view_WhatsNew];

    UIImage *img_WhatsNew = [UIImage imageNamed:@"ttl_whatsnew.png"];
    UIImageView* iv_WhatsNew = [[UIImageView alloc] initWithImage:img_WhatsNew];
    iv_WhatsNew.contentMode = UIViewContentModeScaleAspectFit;
    iv_WhatsNew.frame = CGRectMake(10, 5, view_WhatsNew.frame.size.width - 20, 25);
    [view_WhatsNew addSubview:iv_WhatsNew];

    //RECOMMEND MENUテーブル
    _WhatsNew_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iv_WhatsNew.frame.origin.y + iv_WhatsNew.frame.size.height + 2, _cornerView.frame.size.width, 0) style:UITableViewStylePlain];
    [_WhatsNew_tableView setBackgroundColor:[UIColor clearColor]];
    _WhatsNew_tableView.delegate = self;
    _WhatsNew_tableView.dataSource = self;
    _WhatsNew_tableView.scrollEnabled = false;
    [_WhatsNew_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [view_WhatsNew addSubview:_WhatsNew_tableView];

    UINib *nib2 = [UINib nibWithNibName:@"MPNewHomeCell" bundle:nil];
    [_WhatsNew_tableView registerNib:nib2 forCellReuseIdentifier:@"newHomeIdentifier"];
    [_WhatsNew_tableView reloadData];

    // RECOMMEND MENU MORE
    UIImage *img_WhatsNew_More = [UIImage imageNamed:@"ttl_more.png"];
    iv_WhatsNew_More = [[UIImageView alloc] initWithImage:img_WhatsNew_More];
    iv_WhatsNew_More.contentMode = UIViewContentModeScaleAspectFit;
    iv_WhatsNew_More.frame = CGRectMake(10, _WhatsNew_tableView.frame.origin.y + _WhatsNew_tableView.frame.size.height + 10, view_WhatsNew.frame.size.width - 20, 25);

    btn_WhatsNew_More = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_WhatsNew_More.frame = iv_WhatsNew_More.frame;
    btn_WhatsNew_More.backgroundColor = [UIColor clearColor];
    btn_WhatsNew_More.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn_WhatsNew_More setImage:img_WhatsNew_More forState:UIControlStateNormal];
    [btn_WhatsNew_More addTarget:self action:@selector(push_recomend_Menu_More:) forControlEvents:UIControlEventTouchUpInside];
    //    btn_RecommendMore.adjustsImageWhenHighlighted = NO;
    [view_WhatsNew addSubview:btn_WhatsNew_More];

    //スクロールビュー大きさ再設定
    _scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, view_WhatsNew.frame.origin.y + view_WhatsNew.frame.size.height + 35);
    _scr_rootview.contentSize = _scr_inView.bounds.size;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];

    [self resizeTable];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_close_TopNavigation:NO];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];

    }else{

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] close_Tab:NO];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == _RecommendMenuList_tableView){

        return 3;
    }

    if(tableView == _WhatsNew_tableView){

        return 4;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if(tableView == _RecommendMenuList_tableView){

    }

    if(tableView == _WhatsNew_tableView){

    }

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView == _RecommendMenuList_tableView){

        return 100.0;
    }

    if(tableView == _WhatsNew_tableView){

        return 100.0;
    }

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _RecommendMenuList_tableView){

        MPMenuListHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newMenuListIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMenuListHomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

//        [cell setData:[self.listObject objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];

        return cell;
    }

    if(tableView == _WhatsNew_tableView){

        MPNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newHomeIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPNewHomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        //        [cell setData:[self.listObject objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];

        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
/*
    MPNewDetailViewController *newDetailVC = [[MPNewDetailViewController alloc] initWithNibName:@"MPNewDetailViewController" bundle:nil];
    [newDetailVC setData:[self.listObject objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newDetailVC animated:YES];
*/
 }



- (void)showWebView:(NSString *)text {
/*
    MPHomeWebViewViewController *webViewVC = [[MPHomeWebViewViewController alloc] initWithNibName:@"MPHomeWebViewViewController" bundle:nil];
    webViewVC.linkUrl = text;
    [self.navigationController pushViewController:webViewVC animated:YES];
*/
}

- (void)backButtonClicked:(UIButton *)sender {

}

-(void)push_block1:(UIButton*)button {

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

-(void)push_recomend_Item_More:(UIButton*)button {

}

-(void)push_recomend_Menu_More:(UIButton*)button {

}

- (void)resizeTable {

    //テーブル高さをセルの最大値へセット
    _RecommendMenuList_tableView.frame = CGRectMake(_RecommendMenuList_tableView.frame.origin.x, _RecommendMenuList_tableView.frame.origin.y, _RecommendMenuList_tableView.frame.size.width, 0);
    _RecommendMenuList_tableView.frame =
    CGRectMake(_RecommendMenuList_tableView.frame.origin.x,
               _RecommendMenuList_tableView.frame.origin.y,
               _RecommendMenuList_tableView.contentSize.width,
               MAX(_RecommendMenuList_tableView.contentSize.height,
                   _RecommendMenuList_tableView.bounds.size.height));

    //Recommend moreボタン位置
    CGRect cg_Recomend_Menu_more = btn_Recommend_Menu_More.frame;
    cg_Recomend_Menu_more.origin.y = _RecommendMenuList_tableView.frame.origin.y + _RecommendMenuList_tableView.frame.size.height + 5;
    iv_Recommend_Menu_More.frame = cg_Recomend_Menu_more;
    btn_Recommend_Menu_More.frame = cg_Recomend_Menu_more;

    //Recommend_Menuサイズ修正
    CGRect cg_Recomend_Menu = view_Recommend_Menu.frame;
    cg_Recomend_Menu.size.height = btn_Recommend_Menu_More.frame.origin.y + btn_Recommend_Menu_More.frame.size.height;
    view_Recommend_Menu.frame = cg_Recomend_Menu;

    //WhatsNew位置修正
    CGRect cg_WhatsNew = view_WhatsNew.frame;
    cg_WhatsNew.origin.y = view_Recommend_Menu.frame.origin.y + view_Recommend_Menu.frame.size.height;
    view_WhatsNew.frame = cg_WhatsNew;

    //エリアテーブル位置設定
    _WhatsNew_tableView.frame = CGRectMake(_WhatsNew_tableView.frame.origin.x, _WhatsNew_tableView.frame.origin.y, _WhatsNew_tableView.frame.size.width, 0);
    _WhatsNew_tableView.frame =
    CGRectMake(_WhatsNew_tableView.frame.origin.x,
               _WhatsNew_tableView.frame.origin.y,
               _WhatsNew_tableView.contentSize.width,
               MAX(_WhatsNew_tableView.contentSize.height,
                   _WhatsNew_tableView.bounds.size.height));

    //Recommend moreボタン位置
    CGRect cg_WhatsNew_more = btn_WhatsNew_More.frame;
    cg_WhatsNew_more.origin.y = _WhatsNew_tableView.frame.origin.y + _WhatsNew_tableView.frame.size.height + 5;
    iv_WhatsNew_More.frame = cg_WhatsNew_more;
    btn_WhatsNew_More.frame = cg_WhatsNew_more;

    //WhatsNew位置修正
    btn_WhatsNew_More.frame = iv_WhatsNew_More.frame;
    cg_WhatsNew = view_WhatsNew.frame;
    cg_WhatsNew.size.height = btn_WhatsNew_More.frame.origin.y + btn_WhatsNew_More.frame.size.height;
    view_WhatsNew.frame = cg_WhatsNew;

    [_scr_inView setFrame:CGRectMake(0, 0, _scr_inView.frame.size.width, view_WhatsNew.frame.origin.y + view_WhatsNew.frame.size.height)];
    _scr_rootview.contentSize = _scr_inView.bounds.size;
}


#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {


        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

@end
