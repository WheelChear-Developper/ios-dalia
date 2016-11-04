//
//  MPFunctionViewController+WebViewBottomBar.m
//  Misepuri
//
//  Created by HAL on 11/27/13.
//  Copyright (c) 2015 GMO Runsystem JSC. All rights reserved.
//

#import "MPFunctionViewController+WebViewBottomBar.h"

@implementation MPFunctionViewController (WebViewBottomBar)

#define  kFooterBarHeight       44
#pragma mark - Add Bottom Bar

- (void)addBottomBar {

    webView.delegate = self;
    webView.scrollView.delegate = self;
    [self setFooterBarHide:NO];
    [self.view bringSubviewToFront:footerBar];
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
    
    btnBack.selected = ![webView canGoBack];
    btnBack.userInteractionEnabled = [webView canGoBack];
    btnForward.selected = ![webView canGoForward];
    btnForward.userInteractionEnabled = [webView canGoForward];
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
            footerBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height, footerBar.frame.size.width, kFooterBarHeight);
        } else {
            footerBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - kFooterBarHeight, footerBar.frame.size.width, kFooterBarHeight);
        }
    }];
}

@end
