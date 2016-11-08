//
//  MPCouponShareView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponShareCell.h"
#import "ManagerDownload.h"

@protocol MPCouponShareViewDelegate<NSObject>
- (void) getCouponShare: (MPCouponObject*) object;
@end

@interface MPCouponShareView : UIView<UITableViewDataSource,UITableViewDelegate,ManagerDownloadDelegate>
{
    IBOutlet UITableView *_tableView;
    NSArray *listCouponShare;
}
@property (nonatomic, assign) id<MPCouponShareViewDelegate> delegate;

@end
