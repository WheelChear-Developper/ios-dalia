//
//  MPReservationViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPReservationCell.h"

@protocol MPReservationViewControllerDelegate<NSObject>
@end

@interface MPReservationViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UITableView *_tbl_list;

    NSMutableArray* _ary_area;
}
@property (nonatomic, assign) id<MPReservationViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

@end
