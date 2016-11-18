//
//  MPWebViewController.m
//  Misepuri
//
//  Created by Fujii-iMac on 2015/11/04.
//  Copyright © 2015年 3SI-TUYENBQ. All rights reserved.
//

#import "MPWebViewController.h"
#import "CustomColor.h"

@interface MPWebViewController ()
@end

@implementation MPWebViewController

@synthesize webView;

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

    webView.scrollView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:_linkUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [titleBackground setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"NewDetail"] objectForKey:@"titleHeader"]];
}

- (void)viewDidAppear:(BOOL)animated {

   //🔴標準navigation
    [self setBasicNavigationHidden:NO];
    [self setNavigationLogo:[UIImage imageNamed:@"header_logo.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationLogo:nil];

    //🔴タブのクローズ
    [(MPTabBarViewController*)[self.navigationController parentViewController] tabHidden:YES];

    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

#pragma mark - WebView Button Actions
- (IBAction)backButtonWebClicked:(id)sender {
    
    [webView goBack];
    [self updateButtonsStatus];
}

- (IBAction)forwardButtonClicked:(id)sender {
    
    [webView goForward];
    [self updateButtonsStatus];
}

- (IBAction)reloadButtonClicked:(id)sender {
    
    [webView reload];
    [self updateButtonsStatus];
}

- (IBAction)openBrowserButtonClicked:(id)sender {

    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Safariでページを開きますか？"
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {

                                            }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"開く"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {

                                                [[UIApplication sharedApplication] openURL:webView.request.URL];

                                            }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)updateButtonsStatus {
    
    _btnBack.selected = ![webView canGoBack];
    _btnBack.userInteractionEnabled = [webView canGoBack];
    _btnForward.selected = ![webView canGoForward];
    _btnForward.userInteractionEnabled = [webView canGoForward];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self updateButtonsStatus];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self updateButtonsStatus];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self updateButtonsStatus];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    NSLog(@"Scrool Potion - %f - %f",_scrollBeginingPoint.y, currentPoint.y);
    if(_scrollBeginingPoint.y < currentPoint.y){

        //標準ナビゲーションのクローズ
        [self close_TopNavigation];

        //下方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:true];

        //アクションボタンスライド
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _footerBar.frame;
                             flt_navi.origin.y = self.view.frame.size.height;
                             _footerBar.frame = flt_navi;

                         } completion:^(BOOL finished){

                             //完了時のコールバック
                             
                         }];

    }else if(_scrollBeginingPoint.y ==0){

        //標準ナビゲーションのオープン
        [self open_TopNavigation];

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //標準ナビゲーションのオープン
        [self open_TopNavigation];

        //上方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

        //アクションボタンスライド
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                             CGRect flt_navi = _footerBar.frame;
                             flt_navi.origin.y = self.view.frame.size.height - 50;
                             _footerBar.frame = flt_navi;

                         } completion:^(BOOL finished){

                             //完了時のコールバック
                             
                         }];
    }
}

@end
