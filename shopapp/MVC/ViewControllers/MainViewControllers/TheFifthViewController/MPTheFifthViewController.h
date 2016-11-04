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
    // REPRASED BY M.ama 2016.10.30 START
    // レイアウト調整用
    UILabel *title2;
    // REPRASED BY M.ama 2016.10.30 END
    NSArray *arr_myShop;
    NSMutableArray *arr_eliaShop;
    NSMutableArray* ary_elias_groupe;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    // INSERTED BY M.ama 2016.10.19 START
    // myshop有り無しでの表示切り替え
    UILabel *myShopTitle;
    // INSERTED BY M.ama 2016.10.19 END
    // INSERTED BY M.ama 2016.10.25 START
    // 未登録時のメッセージ表示
    UILabel *myShopNotSetInfo;
    // INSERTED BY M.ama 2016.10.25 END
}
- (void) setListShop:(NSArray*)array;

@end

