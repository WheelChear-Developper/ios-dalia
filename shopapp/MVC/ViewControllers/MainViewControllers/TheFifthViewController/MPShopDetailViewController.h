//
//  MPShopDetailViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPShopObject.h"
#import "ManagerDownload.h"
#import "MPHeaderShopView.h"
// INSERTED BY ama 2016.10.18 START
// デリゲート設定のため設定
#import "MPShopDetailCell.h"
// INSERTED BY ama 2016.10.18 END

@interface MPShopDetailViewController : MPBaseViewController<ManagerDownloadDelegate, UITableViewDataSource, UITableViewDelegate, MPHeaderShopViewDelegate>
{
    MPShopObject *shopObject;
    UITableView *_tableView;
    NSMutableDictionary *shopDict;
    NSArray *listTitle;
    NSArray *listContent;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UILabel *lbl_title;

    // INSERTED BY ama 2016.10.18 START
    // デリゲート設定のため設定
    MPHeaderShopView* headerView;
    long lng_TotalHeight;
    // INSERTED BY ama 2016.10.18 END
}
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic) BOOL hasOneItem;

@end
