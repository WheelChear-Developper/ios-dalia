//
//  MPStampCardViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/25.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"

@protocol MPStampCardViewControllerDelegate<NSObject>
@end

@interface MPStampCardViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
}
@property (nonatomic, assign) id<MPStampCardViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

@end

