//
//  MPMenu_MenuObject.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenu_MenuObject.h"

@implementation MPMenu_MenuObject
- (id)init{
    if (self = [super init]) {
        self.item = [[NSMutableArray alloc] init];
    }
    
    return  self;
}
@end
