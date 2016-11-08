//
//  MPCouponDetailViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPCouponObject.h"
#import "MPCouponDetailCell.h"

@interface MPCouponDetailViewController : MPBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    MPCouponObject *couponObj;
    UITableView *_tableView;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
}
- (void) setData: (MPCouponObject*) object;

@end
