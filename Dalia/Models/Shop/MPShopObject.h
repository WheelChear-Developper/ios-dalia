//
//  MPShopObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPShopObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *shop_name;
@property (nonatomic, strong) NSString *image;
//▽ 2016年9月29日 項目追加
@property (nonatomic, strong) NSString *postcode1;
@property (nonatomic, strong) NSString *postcode2;
//△ 2016年9月29日 項目追加
@property (nonatomic, strong) NSString *passcode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *business_hour;
@property (nonatomic, strong) NSString *regular_holiday;
@property (nonatomic, strong) NSString *access_method;
@property (nonatomic, strong) NSString *seat_number;
@property (nonatomic, strong) NSString *parking;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *responsible_person;
@property (nonatomic, strong) NSString *other_title;
@property (nonatomic, strong) NSString *other_content;
// INSERTED BY ama 2016.10.05 START
// お気に入り状態追加
@property (nonatomic) BOOL favorite;
// INSERTED BY ama 2016.10.05 END

@end
