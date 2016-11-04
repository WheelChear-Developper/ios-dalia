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

@end
