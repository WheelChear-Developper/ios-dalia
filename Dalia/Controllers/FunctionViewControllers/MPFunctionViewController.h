//
//  MPFunctionViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPFunctionViewController : MPBaseViewController<ManagerDownloadDelegate>
{
    ElevenFunctionType functionType;
    UIWebView *webView;
    
    __unsafe_unretained IBOutlet UIView *footerBar;
    __unsafe_unretained IBOutlet UIButton *btnBack, *btnForward, *btnReload, *btnOpenBrowser;
    CGFloat lastContentOffset;
}

@end
