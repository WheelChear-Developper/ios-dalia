//
//  MPMenu_ItemObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPMenu_ItemObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *sub_title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic) long order_by;
@property (nonatomic, strong) NSString *liked;
@property (nonatomic) long likedd;
@end
