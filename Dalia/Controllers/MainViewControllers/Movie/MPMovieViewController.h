//
//  MPMovieViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPMovieTableViewCell.h"
#import "MPVideolistObject.h"
#import "MPVideolist_thumbnailObject.h"
#import "MPMovieSubViewController.h"

@interface MPMovieViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPMovieSubViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    NSMutableArray* _list_data;

    __weak IBOutlet UITableView *_tbl_menulist;

    NSMutableArray *_ary_image;
    NSMutableArray *_ary_title;
    NSMutableArray *_ary_time;
    NSMutableArray *_ary_love;
}

@end
