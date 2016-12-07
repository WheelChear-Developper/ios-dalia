//
//  MPStaffShoplistObject.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/06.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPStaffShoplistObject.h"

@implementation MPStaffShoplistObject
- (id)init{
    if (self = [super init]) {
        self.category = [[NSMutableArray alloc] init];
    }

    return  self;
}
@end
