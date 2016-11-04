//
//  MPHomeWebViewViewController.m
//  Misepuri
//
//  Created by Fujii-iMac on 2015/11/04.
//  Copyright © 2015年 3SI-TUYENBQ. All rights reserved.
//

#import "MPHomeWebViewViewController.h"
#import "CustomColor.h"
#import "MPUIConfigObject.h"

@interface MPHomeWebViewViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleBackground;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIView *footerBar;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnForward;
@property (strong, nonatomic) IBOutlet UIButton *btnReload;
@property (strong, nonatomic) IBOutlet UIButton *btnOpenBrowser;

- (IBAction)backButtonWebClicked:(id)sender;
- (IBAction)forwardButtonClicked:(id)sender;
- (IBAction)reloadButtonClicked:(id)sender;
- (IBAction)openBrowserButtonClicked:(id)sender;

@end

@implementation MPHomeWebViewViewController

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
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //XIB自身での表示とする
    [contentView setHidden:YES];

    [self addBottomBar];
    
    NSURL *url = [NSURL URLWithString:_linkUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.titleBackground setText:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"NewDetail"] objectForKey:@"titleHeader"]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
/*
    if (_contents) {

        if (_contents.is_read == 0) {

            //reset badge app here
            if ([MPAppDelegate sharedMPAppDelegate].totalBadge > 0) {
                [MPAppDelegate sharedMPAppDelegate].totalBadge -=1;
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MPAppDelegate sharedMPAppDelegate].totalBadge];
            }
            
            //did read message
            [[ManagerDownload sharedInstance] readMessage:[Utility getDeviceID] withAppID:[Utility getAppID] withMessageID:_contents.id delegate:self];
        }
    }
*/
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

#define  kFooterBarHeight       44
#pragma mark - Add Bottom Bar
- (void)addBottomBar {
    
    webView.delegate = self;
    webView.scrollView.delegate = self;
    [self setFooterBarHide:NO];
    [self.view bringSubviewToFront:_footerBar];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setFooterBarHide:NO];
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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Safariでページを開きますか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"開く", nil];
    alertView.tag = 68;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 68 && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:webView.request.URL];
    }
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (lastContentOffset > scrollView.contentOffset.y) { // scroll down
        [self setFooterBarHide:NO];
    }
    else if (scrollView.contentOffset.y > 0 && lastContentOffset < scrollView.contentOffset.y) { // scroll up
        [self setFooterBarHide:YES];
    }
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)setFooterBarHide:(BOOL)isHide {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isHide) {
            _footerBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height, _footerBar.frame.size.width, kFooterBarHeight);
        } else {
            _footerBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - kFooterBarHeight, _footerBar.frame.size.width, kFooterBarHeight);
        }
    }];
}

@end
