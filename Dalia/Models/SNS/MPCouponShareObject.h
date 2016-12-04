//
//  MPCouponShareObject.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPCouponShareObject : NSObject

@property (nonatomic,strong) NSString  *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *is_due_date;
@property (nonatomic, strong) NSString *due_date;
@property (nonatomic, strong) NSString *limit_num;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *coupon_image;
@property (nonatomic) long tokuten_mode;
@property (nonatomic) long percentage;
@property (nonatomic) long original_price;
@property (nonatomic) long open_price;
@property (nonatomic, strong) NSString *tokuten_free_word;
@property (nonatomic, strong) NSString *coupon_type;
@property (nonatomic, strong) NSString *share_conten;
@property (nonatomic, strong) NSString *tokuten_detail;
@property (nonatomic, strong) NSString *created_at;

@end
