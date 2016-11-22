//
//  MPWhatNewInfoViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/21.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPWhatNewInfoViewController.h"

@interface MPWhatNewInfoViewController ()

@end

@implementation MPWhatNewInfoViewController

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
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_whatsnew.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];

    UIImage* img_photo = [UIImage imageNamed:@"whatsnew_18.png"];
    int imageW = img_photo.size.width;
    int imageH = img_photo.size.height;

    // リサイズする倍率を作成する。
    float scale = (imageW > imageH ? 320.0f/imageH : 320.0f/imageW);
    CGSize resizedSize = CGSizeMake(imageW * scale, imageH * scale);
    UIGraphicsBeginImageContext(resizedSize);
    [img_photo drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    _img_photo.translatesAutoresizingMaskIntoConstraints = YES;
    CGFloat flt_img = _img_photo.frame.size.width / img_photo.size.width;
    CGRect rct_frame = _img_photo.frame;
    rct_frame.size.height = img_photo.size.height * flt_img;
    _img_photo.frame = rct_frame;
    _img_photo.image = resizedImage;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        //標準ナビゲーションのオープン
        [self setFadeOut_BasicNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //標準ナビゲーションのオープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //標準ナビゲーションのクローズ
        [self setFadeOut_BasicNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)btn_hart:(id)sender {
}

- (IBAction)btn_facebook:(id)sender {
}

- (IBAction)btn_twitter:(id)sender {
}

- (IBAction)btn_line:(id)sender {
}
@end
