//
//  MPTheSecondViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheSecondViewController.h"

@interface MPTheSecondViewController ()
@end

@implementation MPTheSecondViewController

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
    [self setBasicNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] SetCustomNavigationLogo:[UIImage imageNamed:@"header_ttl_coupon.png"]];
    
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
    _scr_rootview.backgroundColor = [UIColor colorWithRed:229/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    [contentView addSubview:_scr_rootview];

    _cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scr_inView.frame.size.width, _scr_inView.frame.size.height)];
    _cornerView.backgroundColor = [UIColor clearColor];
    _cornerView.clipsToBounds = YES;
    [_cornerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_scr_inView addSubview:_cornerView];

    //スクロールビュー大きさ再設定
    _scr_inView.frame = CGRectMake(0, 0, contentView.frame.size.width, 200 + 35);
    _scr_rootview.contentSize = _scr_inView.bounds.size;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
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

- (void)backButtonClicked:(UIButton *)sender {

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
