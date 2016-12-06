//
//  MPHearCatalogCategoryListInfoViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPHearCatalogCategoryListInfoViewController.h"

@interface MPHearCatalogCategoryListInfoViewController ()
@end

@implementation MPHearCatalogCategoryListInfoViewController

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
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"hearcatalog_ttl_title.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //スライドビュー設置
    self.pageView.frame = self.view.bounds;
//    self.pageView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    self.pageView.pageViewStyle = MPQLPageViewButtonBarStyleWithLabel;
    self.pageView.dataSource = self;
    self.pageView.delegate = self;
    [self.view addSubview:self.pageView];
    [self.view bringSubviewToFront:self.basic_navigationView];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    _scr_rootview.delegate = nil;

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    [self resizeTable];
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //トップナビゲーション　クローズ
//        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //トップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //トップナビゲーション　オープン
//        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
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
    return _ary_photoList.count;
}

- (UIView *)pageView:(MPQLPageView *)pageView viewForPageAtIndex:(NSInteger)index
{

    HearCatalogCategoryListInfo_SlideView *view_slide = [HearCatalogCategoryListInfo_SlideView myView];

    view_slide.scr_rootview.delegate = self;

    //テストデータ設定
    [view_slide setCategolyType:_lng_categolyType];
    view_slide.img_photo.image = [UIImage imageNamed:[_ary_photoList objectAtIndex:index]];


    return view_slide;
}

- (void)pageView:(MPQLPageView *)pageView didMoveToPage:(NSInteger)index {
    
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


- (void)resizeTable {

}

- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end


