//
//  MPHomeWebViewViewController.h
//  Misepuri
//
//  Created by Fujii-iMac on 2015/11/04.
//  Copyright © 2015年 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPHomeWebViewViewController : MPBaseViewController<UIWebViewDelegate, UIScrollViewDelegate, ManagerDownloadDelegate>
{
    CGFloat lastContentOffset;
}
@property (nonatomic, strong) NSString* linkUrl;

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
