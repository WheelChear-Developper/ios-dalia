//
//  MPCouponCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponObject.h"

@protocol MPCouponCellDelegate<NSObject>

@optional
- (void)useCoupon:(MPCouponObject*) object;
@end

@interface MPCouponCell : UITableViewCell {
    
    MPCouponObject *couponObject;
    __weak IBOutlet UIImageView *img_photo;
    __weak IBOutlet UILabel *couponNameLabel;
    __weak IBOutlet UILabel *dueDateLabel;
    __weak IBOutlet UILabel *dueDateValueLabel;
    __weak IBOutlet UILabel *conditionLabel;
    __weak IBOutlet UILabel *conditionValueLabel;
    __weak IBOutlet UILabel *numberUsingLabel;
}
@property (nonatomic, assign) id<MPCouponCellDelegate> delegate;

- (void)setData:(MPCouponObject*)object;
+ (CGFloat)heightForRow:(MPCouponObject*)object;

@end
