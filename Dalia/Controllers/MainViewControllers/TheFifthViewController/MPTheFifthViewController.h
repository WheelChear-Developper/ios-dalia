//
//  MPTheFifthViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPTheFifthViewController : MPBaseViewController<UITableViewDataSource,UITableViewDelegate,ManagerDownloadDelegate>
{
    UITableView *_myshop_tableView;
    UITableView *_elia_tableView;
    UILabel *title2;
    NSArray *arr_myShop;
    NSMutableArray *arr_eliaShop;
    NSMutableArray* ary_elias_groupe;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UILabel *myShopTitle;
    UILabel *myShopNotSetInfo;
}
- (void) setListShop:(NSArray*)array;

@end

