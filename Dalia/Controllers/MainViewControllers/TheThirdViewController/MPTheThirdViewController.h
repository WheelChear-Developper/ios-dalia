//
//  MPTheThirdViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPTheMenuHederCell.h"
#import "MPTheMenuCell.h"
#import "MPTheThirdSumMenuViewController.h"
#import "MPMenu_ShopObject.h"
#import "MPMenu_MenuObject.h"
#import "MPMenu_ItemObject.h"

@interface MPTheThirdViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTheThirdSumMenuViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UITableView *_tbl_head;
    __weak IBOutlet UITableView *_tbl_list;

    NSMutableArray* _ary_total_data;
    NSMutableArray* _arr_elia_Shop;
    NSMutableArray* _ary_elis_menu;

    NSMutableArray *_ary_image;
    NSMutableArray *_ary_title;
    NSMutableArray *_ary_subTitle;
    NSMutableArray *_ary_infoImage;
    NSMutableDictionary* _dic_menu_data;

    long lng_ShopNo;
    BOOL bln_menuOpen;
}

@end
