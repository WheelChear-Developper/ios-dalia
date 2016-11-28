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
#import "MPTheMenuCell.h"
#import "MPTheThirdSumMenuViewController.h"
#import "MPMenu_MenuObject.h"

@interface MPTheThirdViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTheThirdSumMenuViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UITableView *_tbl_list;

    NSMutableArray* _list_data;

    NSMutableArray *_ary_image;
    NSMutableArray *_ary_title;
    NSMutableArray *_ary_subTitle;
    NSMutableArray *_ary_infoImage;
    NSMutableDictionary* _dic_menu_data;
}


@end
