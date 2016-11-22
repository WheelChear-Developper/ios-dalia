//
//  MPWhatNewViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPWhatNewsCell.h"
#import "MPWhatNewsObject.h"
#import "MPWhatNewInfoViewController.h"

@protocol MPWhatNewViewControllerDelegate<NSObject>
@end

@interface MPWhatNewViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPWhatNewInfoViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UITableView *_WhatNewsList_tableView;

    NSMutableArray* list_WhatNews;
}
@property (nonatomic, assign) id<MPWhatNewViewControllerDelegate> delegate;

@end
