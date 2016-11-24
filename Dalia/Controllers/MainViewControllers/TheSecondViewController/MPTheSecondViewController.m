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

    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];

    _pageView = [[MPQLPageView alloc] initWithFrame:self.view.bounds];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_coupon.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //クーポンデータ取得
    [[ManagerDownload sharedInstance] getListCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];

    //スライドビュー設置
    self.pageView.frame = self.view.bounds;
    self.pageView.pageViewStyle = MPQLPageViewButtonBarStyleWithLabel;
    self.pageView.dataSource = self;
    self.pageView.delegate = self;
    [self.view addSubview:self.pageView];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
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
    NSLog(@"Scrool Potion - %f - %f",_scrollBeginingPoint.y, currentPoint.y);
    if(_scrollBeginingPoint.y < currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - QLPageViewDataSource
- (NSInteger)initialIndexForPageInPageView:(MPQLPageView *)pageView
{
    return 0;
}

- (NSInteger)numberOfPagesInPageView:(MPQLPageView *)pageView
{
    return 6;
}

- (UIView *)pageView:(MPQLPageView *)pageView viewForPageAtIndex:(NSInteger)index
{
    MPTheSecond_SlideView *view_slide = [MPTheSecond_SlideView myView];

    [view_slide setNumberOfPages:6];
    [view_slide setCurrentCount:index];

    view_slide.scr_rootview.delegate = self;


    //テストデータ設定
    view_slide.view_specialMark.hidden = NO;
    view_slide.lbl_title.text = @"シェアサンクス クーポン";
    [view_slide.img_photo setImage:[UIImage imageNamed:@"coupon_24.png"]];
    view_slide.lbl_name.text = @"シェア感謝!! カット＋カラー";
    view_slide.lbl_Info1.text = @"通常価格から";
    view_slide.lbl_Info2.text = @"30%OFF";
    view_slide.lbl_turn.text = @"あと１回";
    [view_slide.img_stamp setImage:nil];
    view_slide.lbl_date.text = @"2017/12/01(金)";
    view_slide.lbl_message.text = @"※他のクーポンとの併用はできません。\n※2,000円以下のメニューは対象外\n※お会計前にスタッフにご提示ください。\n※このクーポンは１回限定でご利用いただけます。";
    view_slide.lng_messageHeight = view_slide.view_message.frame.size.height;

    view_slide.view_message.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect rct_message = view_slide.view_message.frame;
    rct_message.size.height = 0;
    view_slide.view_message.frame = rct_message;
    
    return view_slide;
}

- (void)pageView:(MPQLPageView *)pageView didMoveToPage:(NSInteger)index {

}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {
            MPCouponObject *couponObj = [param.listData objectAtIndex:0];



        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}


@end
