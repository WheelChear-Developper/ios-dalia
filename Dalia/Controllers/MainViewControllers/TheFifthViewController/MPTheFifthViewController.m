//
//  MPTheFifthViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheFifthViewController.h"

@implementation MPTheFifthViewController

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

    _lbl_version.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:NO];
    [self setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_setting.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    sw_newsNotification.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_recommended.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_recommendedMenu.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_catalog.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_curpon.transform = CGAffineTransformMakeScale(0.9, 0.9);
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
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
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

- (IBAction)sw_newsNotification:(id)sender {
}

- (IBAction)sw_recommended:(id)sender {
}

- (IBAction)sw_recommendedMenu:(id)sender {
}

- (IBAction)sw_catalog:(id)sender {
}

- (IBAction)sw_curpon:(id)sender {
}

- (IBAction)btn_transfer:(id)sender {

    MPTransferViewController *vc = [[MPTransferViewController alloc] initWithNibName:@"MPTransferViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn_teams:(id)sender {

    MPTermsViewController *vc = [[MPTermsViewController alloc] initWithNibName:@"MPTermsViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn_porisir:(id)sender {
}

@end
