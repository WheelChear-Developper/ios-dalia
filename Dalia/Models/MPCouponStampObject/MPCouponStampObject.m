//
//  MPCouponStampObject.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPCouponStampObject.h"

@implementation MPCouponStampObject

- (id)init{

    if (self = [super init]) {
        self.stamp_date_set = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.stamp_devices = [[NSMutableArray alloc] init];
    }
    
    return  self;
}

@end
