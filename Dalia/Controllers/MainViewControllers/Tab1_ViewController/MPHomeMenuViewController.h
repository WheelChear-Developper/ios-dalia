//
//  MPHomeMenuViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAppDelegate.h"
#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPPlanTextCell.h"
#import "MPMenuGridCell.h"
#import "MPListCell.h"
#import "MPMenuObject.h"
#import "MPHomeMenuDetailViewController.h"

@interface MPHomeMenuViewController : MPBaseViewController<ManagerDownloadDelegate,UITableViewDataSource,UITableViewDelegate,MPMenuGridCellDelegate>
{
    UITableView *_tableView;
    NSArray *listItem;
    NSArray *listMenu;
    long countTemp;
    STYLE_FORMAT_MENU_TYPE style;
    DETAIL_LIST_TYPE detailType;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UIImageView *iv_toppics;
}
- (void) setType: (DETAIL_LIST_TYPE) type;

@end
