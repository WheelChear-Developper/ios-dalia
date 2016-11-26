//
//  MPStaffViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPStaffCell.h"

@interface MPStaffViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UITableView *_tbl_menulist;

    NSMutableArray *_ary_image;
    NSMutableArray *_ary_name;
    NSMutableArray *_ary_subname;

    NSMutableDictionary* _dic_menu_data;
}

@end
