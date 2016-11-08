//
//  MPWpNewsDetailViewController.h
//  Misepuri
//
//  Created by Fujii-iMac on 2015/11/04.
//  Copyright © 2015年 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNewHomeObject.h"
#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPWpNewsDetailViewController : MPBaseViewController<UIWebViewDelegate, UIScrollViewDelegate, ManagerDownloadDelegate>
{
    CGFloat lastContentOffset;
}

@property (strong, nonatomic) MPNewHomeObject *contents;

@end
