//
//  MPCouponBirthdayCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPCouponBirthdayCellDelegate<NSObject>
- (void) setBirthDay;
@end

@interface MPCouponBirthdayCell : UITableViewCell
{    
}
@property (nonatomic, assign) id<MPCouponBirthdayCellDelegate> delegate;

@end
