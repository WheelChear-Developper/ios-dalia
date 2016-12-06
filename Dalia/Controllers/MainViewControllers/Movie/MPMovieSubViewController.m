//
//  MPMovieSubViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/03.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMovieSubViewController.h"

@interface MPMovieSubViewController ()
@end

@implementation MPMovieSubViewController

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
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    NSMutableDictionary* dic_thumbnail = self.obj_video.thumbnail;
    lbl_title.text = self.obj_video.title;
    lbl_comment.text = self.obj_video.detail;

    // スクロールを無効にする
    web_view.scrollView.scrollEnabled = NO;
    // スクロール時の跳ね返りを抑制する
    web_view.scrollView.bounces = NO;

    // UIWebViewにセットするHTMLのテンプレート
    NSString *htmlString = [NSString stringWithFormat:@" \
    <!DOCTYPE html> \
    <html> \
    <head> \
    <meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no, width=%f\"> \
    </head> \
    <body style=\"background:#000000; margin-top:0px; margin-left:0px\"> \
    <iframe width=\"%f\" \
    height=\"%f\" \
    src=\"%@?showinfo=0\" \
    frameborder=\"0\" \
    allowfullscreen> \
    </iframe> \
    </body> \
    </html> \
                            ",
                            [[dic_thumbnail objectForKey:@"width"] doubleValue],
                            [[dic_thumbnail objectForKey:@"width"] doubleValue],
                            [[dic_thumbnail objectForKey:@"height"] doubleValue],
                            self.str_videoUrl];

    // UIWebViewに生成したHTMLをセットする
    [web_view loadHTMLString:htmlString baseURL:nil];

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
        //カスタムトップナビゲーション　クローズ
//        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
//        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
//        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)resizeTable {


}

- (void)backButtonClicked:(UIButton *)sender {
}

- (IBAction)btn_movie_start:(id)sender {
}

- (IBAction)btn_back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_heart:(id)sender {
}

- (IBAction)btn_line:(id)sender {

    NSString *textString = self.str_videoUrl;
    textString = [textString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/text/%@",textString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LINEUrlString]];
}

- (IBAction)btn_facebook:(id)sender {

    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPostVC setInitialText:self.str_videoUrl];
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

- (IBAction)btn_blog:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = self.str_videoUrl;
    [self.navigationController pushViewController:webViewVC animated:YES];
}
@end

