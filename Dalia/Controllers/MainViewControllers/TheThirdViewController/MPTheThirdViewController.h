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

@interface MPTheThirdViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UITableView *_tbl_menulist;

    NSMutableArray *ary_image;
    NSMutableArray *ary_title;
    NSMutableArray *ary_subTitle;
}


@end
