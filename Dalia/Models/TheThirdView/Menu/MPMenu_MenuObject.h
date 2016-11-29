//
//  MPMenu_MenuObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, STYLE_FORMAT_MENU_TYPE) {
    STYLE_FORMAT_MENU_TYPE_Grid = 1,
    STYLE_FORMAT_MENU_TYPE_List,
    STYLE_FORMAT_MENU_TYPE_Plantext
};
@interface MPMenu_MenuObject : NSObject
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *sub_title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic) long order_by;
@property (nonatomic, strong) NSMutableArray *item;
@end
