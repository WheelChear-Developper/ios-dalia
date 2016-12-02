//
//  MPCouponStampObject.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CouponType) {
    CouponType_ISSUE_USED = 1,
    CouponType_SHARE_USED,
    CouponType_BIRTHDAY_USSED,
    CouponType_STAMP_USED

};
@interface MPCouponStampObject : NSObject
@property (nonatomic,strong) NSString  *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *is_due_date;
@property (nonatomic, strong) NSString *due_date;
@property (nonatomic, strong) NSString *due_date_format;
@property (nonatomic, strong) NSString *stamp_num;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *stamp_condition;
@property (nonatomic, strong) NSMutableArray  *stamp_date_set;
@property (nonatomic, strong) NSString *is_limit_stamp;
@property (nonatomic, strong) NSMutableArray *stamp_devices;

@end
