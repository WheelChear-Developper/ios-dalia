//
//  MPMenuTopinfoObject.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuTopinfoObject.h"

@implementation MPMenuTopinfoObject

- (id)init{
    if (self = [super init]) {
        self.recommend_item = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.recommend_menu = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.news = [[NSMutableArray alloc] init];
    }

    return  self;
}
@end
