//
//  MPNewHomeObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPNewHomeObject : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic) long is_new;                 //今回は未使用
@property (nonatomic) long is_read;
@property (nonatomic, strong) NSString *update_at;
@property (nonatomic) BOOL isOptionPlus01;         //今回は未使用
@property (nonatomic) NSInteger position;          //今回は未使用
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *thumbnail;
@property (nonatomic,strong) NSString *wp_url;     //今回は未使用
@property (nonatomic) long wp_flg;                 //今回は未使用

@end
