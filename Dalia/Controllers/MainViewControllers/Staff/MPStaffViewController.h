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
#import "MPStaffInfoViewController.h"
#import "MPStafflistObject.h"
#import "MPStaffShoplistObject.h"
#import "MPStaffHeadCell.h"

@interface MPStaffViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPStaffInfoViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    NSMutableArray* _ary_total_data;
    NSMutableArray* _arr_elia_Staff;
    NSMutableArray* _ary_elis_Shop;

    long lng_ShopNo;
    BOOL bln_menuOpen;

    __weak IBOutlet UITableView *_tbl_shopflist;
    __weak IBOutlet UITableView *_tbl_stafflist;

    NSMutableArray *_ary_image;
    NSMutableArray *_ary_name;
    NSMutableArray *_ary_subname;

    NSMutableDictionary* _dic_menu_data;

    __weak IBOutlet UILabel *_lbl_shopName;

}

@end
