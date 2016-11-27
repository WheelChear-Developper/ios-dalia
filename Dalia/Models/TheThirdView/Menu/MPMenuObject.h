//
//  MPMenuObject.h
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
@interface MPMenuObject : NSObject
@property (nonatomic) STYLE_FORMAT_MENU_TYPE style;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *order_by;
@property (nonatomic, strong) NSMutableArray *item;
@end
