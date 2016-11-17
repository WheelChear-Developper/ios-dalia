//
//  MPTheSecondViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheSecondViewController.h"

#define pageCount 3

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
    [contentView setHidden:YES];

    //スライド画面設定
    _view_slide = (MPTheSecond_SlideView*)[Utility viewInBundleWithName:@"MPTheSecond_SlideView"];
    _view_slide.delegate = self;

    // Do any additional setup after loading the view, typically from a nib.
    // スクロールビューのページ遷移を許可する。
    _scr_rootview.pagingEnabled = YES;
    // スクロールビューの横幅を現在の三倍にする
    _scr_rootview.contentSize = CGSizeMake(_scr_rootview.frame.size.width * pageCount, _scr_rootview.frame.size.height);
    // スクロールビューのスクロールバーを非表示にする
    _scr_rootview.showsHorizontalScrollIndicator = NO;
    _scr_rootview.showsVerticalScrollIndicator = NO;
    // ページコントロールのページ数を3ページにする
    [_view_slide setNumberOfPages:pageCount];
    // 現在のページを0に初期化する。
    [_view_slide setCurrentCount:0];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];

    long lng_dt_count = 3;
    long lng_insetViewSize = self.view.frame.size.width * lng_dt_count;
    CGRect rect_inview = _scr_inView.frame;
    rect_inview.size.width = lng_insetViewSize;
    _scr_inView.frame = rect_inview;

    MPTheSecond_SlideView* slideView[lng_dt_count];
    for(long l=0;l<lng_dt_count;l++){

        slideView[l] = (MPTheSecond_SlideView*)[Utility viewInBundleWithName:@"MPTheSecond_SlideView"];
        slideView[l].delegate = self;
        [slideView[l] setFrame:CGRectMake(slideView[l].frame.size.width * l, 0, slideView[l].frame.size.width, slideView[l].frame.size.height)];
        [_scr_inView addSubview:slideView[l]];
    }
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
//        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_close_TopNavigation:NO];

        //タブのオープン
//        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
//        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのオープン
//        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];
        
    }else{

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
//        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのクローズ
//        [(MPTabBarViewController*)[self.navigationController parentViewController] close_Tab:NO];
    }

    CGFloat pageWidth = _scr_rootview.frame.size.width;
    [_view_slide setCurrentCount:floor((_scr_rootview.contentOffset.x - pageWidth / 2) / pageWidth ) + 1];
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

- (void)backButtonClicked:(UIButton *)sender {

}

- (IBAction)btn_back:(id)sender {

    [_view_slide setCurrentCount:0];
    [self setScrrolAction];
}

- (IBAction)btn_next:(id)sender {

    [_view_slide setCurrentCount:1];
    [self setScrrolAction];
}

-(void)setScrrolAction {

    // スクロールビューのframeを取得
    CGPoint offset = _scr_rootview.frame.origin;
    // _scrollViewのフレームを現在のpageControlの値に合わせる
    offset.x = self.view.frame.size.width * [_view_slide getCurrentCount];
    offset.y = -20;
    // スクロールビューを現在の可視領域にスクロールさせる
    [_scr_rootview setContentOffset:offset animated:YES];
}
@end
