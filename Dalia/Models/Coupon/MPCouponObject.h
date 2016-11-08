//
//  MPCouponObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CouponType) {
    CouponType_ISSUE_USED = 1,
    CouponType_SHARE_USED,
    CouponType_BIRTHDAY_USSED,
    CouponType_STAMP_USED
    
};
@interface MPCouponObject : NSObject
@property (nonatomic,strong) NSString *coupon_id;
@property (nonatomic) long coupon_type;
@property (nonatomic, strong) NSString *coupon_code;
@property (nonatomic, strong) NSString *coupon_name;
@property (nonatomic) long is_due_date;
@property (nonatomic, strong) NSString *due_date;
@property (nonatomic) long limit_num;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *status;
@property (nonatomic) long stamp_num;
@property (nonatomic,strong) NSArray *stamp_date_set;
@property (nonatomic, strong) NSString *share_content;
@property (nonatomic) long limit_date;
@property (nonatomic) long is_birthday;
@property (nonatomic, strong) NSString *dob;
@property (nonatomic, strong) NSString *is_limit_stamp;
@property (nonatomic, strong) NSString *stamp_condition;
@property (nonatomic, strong) NSString *due_date_format;
// INSERT START 2015.01.16
// INSERTED BY M.FUJII
// ADD OPTION9 (LINE連携追加)
@property (nonatomic, strong)  NSString *is_share_line;
// INSERT END 2015.01.16

// INSERTED BY M.FUJII 2015.12.11 START
// 電子スタンプ機能実装
@property (nonatomic, strong)  NSArray *stamp_devices;
// INSERTED BY M.FUJII 2015.12.11 END

// INSERTED BY ama 2016.10.05 START
// ランク用カラー設定
@property (nonatomic, strong) NSString* rank_color;
// INSERTED BY ama 2016.10.05 END

// INSERTED BY ama 2016.10.25 START
// 画像URL
@property (nonatomic, strong) NSString *coupon_image;
// INSERTED BY ama 2016.10.25 END

@end
