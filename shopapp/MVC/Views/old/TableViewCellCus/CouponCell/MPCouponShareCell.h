//
//  MPCouponShareCell.h
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponObject.h"

@interface MPCouponShareCell : UITableViewCell
{
     IBOutlet UILabel *nameCouponLabel;
    
     IBOutlet UILabel *dueDateLabel;
    
     IBOutlet UIImageView *lineView;
     IBOutlet UILabel *conditionLabel;
     IBOutlet UIImageView *indicatorView;
    MPCouponObject *couponObject;
}
- (void)setData:(MPCouponObject*)object;
+ (CGFloat)heightForRow:(MPCouponObject*)object;

@end
