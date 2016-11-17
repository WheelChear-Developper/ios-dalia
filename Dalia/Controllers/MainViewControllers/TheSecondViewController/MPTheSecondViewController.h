//
//  MPTheSecondViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPTheSecond_SlideView.h"

@interface MPTheSecondViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTheSecond_SlideViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    long _lng_MaxPageCount;
    long _lng_PageCount;

    MPTheSecond_SlideView *_view_slide;
}
- (IBAction)btn_back:(id)sender;
- (IBAction)btn_next:(id)sender;

@end
