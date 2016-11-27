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
#import "MPQLPageView.h"

@interface MPTheSecondViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTheSecond_SlideViewDelegate, MPQLPageViewDataSource, MPQLPageViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    NSMutableArray* _list_data;
}
@property (nonatomic, strong) MPQLPageView *pageView;

@end
