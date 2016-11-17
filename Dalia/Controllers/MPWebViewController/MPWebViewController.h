//
//  MPWebViewController.h
//  Misepuri
//
//  Created by Fujii-iMac on 2015/11/04.
//  Copyright © 2015年 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPTabBarViewController.h"

@interface MPWebViewController : MPBaseViewController<UIWebViewDelegate, UIScrollViewDelegate, ManagerDownloadDelegate>
{
    UILabel *titleBackground;
    CGPoint _scrollBeginingPoint;
    CGFloat _lastContentOffset;
}
@property (nonatomic, strong) NSString* linkUrl;
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
