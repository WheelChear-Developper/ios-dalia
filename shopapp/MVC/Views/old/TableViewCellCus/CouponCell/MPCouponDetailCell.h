//
//  MPCouponDetailCell.h
//  Misepuri
//
//  Created by TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponObject.h"

@interface MPCouponDetailCell : UITableViewCell
{
    MPCouponObject *couponObj;

    // INSERTED BY M.ama 2016.10.25 START
    // 画像取得
    __weak IBOutlet UIImageView *img_photo;
    // INSERTED BY M.ama 2016.10.25 END
    IBOutlet UILabel *titleCoupon;
    IBOutlet UILabel *dueDateCouponLabel;
    IBOutlet UILabel *contentCouponLabel;
    IBOutlet UIImageView *imageSmall;
    
    IBOutlet UIImageView *imageBg;
    IBOutlet UIImageView *bottomImageSmall;
    
    __weak IBOutlet UILabel *lbl_fromtodate;
}
- (void) setData: (MPCouponObject*) object;
+ (CGFloat) heightForRow: (MPCouponObject*) object;

@end
