//
//  MPVideoChannelHeaderView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPVideoObject.h"
#import "MPAppDelegate.h"

@interface MPVideoChannelHeaderView : UIView
{
     IBOutlet UILabel *detailLabel;
     IBOutlet UIWebView *webView;
    BOOL _isFullscreen;
}

- (void) setData: (MPVideoObject*) object;
+ (CGFloat) heightForHeader: (MPVideoObject*) object;

@end
