//
//  MPDetailShopObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPDetailShopObject : NSObject
@property (nonatomic,strong) NSString *id;
@property (nonatomic, strong) NSString *shop_name;
@property (nonatomic, strong) NSString *shop_name_furi;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *postcode1;
@property (nonatomic, strong) NSString *postcode2;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *business_hour;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *phone1;
@property (nonatomic, strong) NSString *phone2;
@property (nonatomic, strong) NSString *phone3;
@property (nonatomic, strong) NSString *shop_url;
@property (nonatomic, strong) NSString *instagram_url;
@property (nonatomic, strong) NSString *faebook_url;
@property (nonatomic, strong) NSString *twitter_url;
@property (nonatomic, strong) NSString *reserve_url;

@end
