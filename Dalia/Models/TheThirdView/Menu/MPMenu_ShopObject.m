//
//  MPMenu_ShopObject.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/28.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMenu_ShopObject.h"

@implementation MPMenu_ShopObject
- (id)init{
    if (self = [super init]) {
        self.category = [[NSMutableArray alloc] init];
    }

    return  self;
}
@end
