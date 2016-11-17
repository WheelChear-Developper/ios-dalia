//
//  MPCouponObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
typedef NS_ENUM(NSInteger, CouponType) {
    CouponType_ISSUE_USED = 1,
    CouponType_SHARE_USED,
    CouponType_BIRTHDAY_USSED,
    CouponType_STAMP_USED
    
};
*/
@interface MPCouponObject : NSObject
@property (nonatomic,strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) long is_due_date;
@property (nonatomic, strong) NSString *due_date;
@property (nonatomic) long limit_num;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *coupon_image;
@property (nonatomic) long tokuten_mode;
@property (nonatomic) long percentage;
@property (nonatomic) long original_price;
@property (nonatomic) long open_price;
@property (nonatomic, strong) NSString *tokuten_free_word;
@property (nonatomic) long coupon_type;
@property (nonatomic) long is_birthday;
@property (nonatomic, strong) NSString *tokuten_detail;
@property (nonatomic, strong) NSString *created_at;

@end
